//
//  AxcDBManager.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/19.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcDBManager.h"
#define kAxcDB_Folder           @"AxcDB_Folder"

#define kTaskMattersTableName   @"task_matters"


static AxcDBManager    *_axcDBManager;

@interface AxcDBManager ()

@property(nonatomic , strong)FMDatabase *db;

// 添加数据建表时候的状态
@property(nonatomic , assign)NSInteger addTaskMatters_createTable;

@end

@implementation AxcDBManager
+(AxcDBManager *)manager{
    if (_axcDBManager == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{                    // 设置该线程仅进行一次初始化操作，该核心对象包括所含参数全为单例模式
            _axcDBManager = [[AxcDBManager alloc]init];
        });
    }
    return _axcDBManager;
}

// 线程安全
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t once;
    dispatch_once(&once, ^{                             // 为防止Alloc初始化 将alloc方法锁定
        _axcDBManager = [super allocWithZone:zone];
    });
    return _axcDBManager;
}


- (NSArray<TaskModel *> *)getAllTaskMatters{
    
    // 只展示未完成的
    FMResultSet *resultSet = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE is_complete = 0",kTaskMattersTableName]];
    // 遍历结果
    NSMutableArray <MonthEventModel *>*allTask = @[].mutableCopy;
    // 所有月份的Key
    NSMutableDictionary *allMonthKey = @{}.mutableCopy;
    while ([resultSet next]) {
        
        MonthEventModel *model = [MonthEventModel new];
        model._id = [resultSet stringForColumn:@"id"];
        
        NSString *dateStr = [resultSet stringForColumn:@"date_str"];
        model.date = [NSDate AxcTool_getDateString:dateStr withFomant:kDateFormat];
        
        model.addDate = [NSDate AxcTool_getDateString:[resultSet stringForColumn:@"add_date"] withFomant:kDateFormat];
        
        model.title = [resultSet stringForColumn:@"title"];
        model.Introduction = [resultSet stringForColumn:@"introduction"];
        model.level = [resultSet intForColumn:@"level"];
        
        model.isComplete = [resultSet intForColumn:@"is_complete"];
        [allTask addObject:model];
        
        NSString *monthStr = [NSString stringWithFormat:@"%ld",[model.date month]];
        // 检测一遍，set比fotKey更耗性能
        if (![allMonthKey objectForKey:monthStr]) { // 如果没有该月份
            [allMonthKey setObject:monthStr forKey:monthStr];
        }
        
    }
    // 整合数据
    NSMutableArray <TaskModel *>*taskArray = @[].mutableCopy;
    [[allMonthKey allKeys] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray <MonthEventModel *>*monthTask = @[].mutableCopy;
        [allTask enumerateObjectsUsingBlock:^(MonthEventModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == model.date.month) {   // 相同月份的添加
                [monthTask addObject:model];
            }
        }];
        TaskModel *model = [TaskModel new];
        model.date = monthTask.firstObject.date.copy;
        model.monthEvents = monthTask;
        [taskArray addObject:model];
    }];
    // 时间升序
    [taskArray sortUsingComparator:^NSComparisonResult(MonthEventModel * _Nonnull obj1 , MonthEventModel * _Nonnull obj2) {
        return [obj1.date compare:obj2.date];
    }];
    
    return taskArray;
}

- (void)addTaskMatter:(MonthEventModel *)model{
    
    // 如果大量重复插入数据需要此步节省性能，省略查表、建表过程
    if (self.addTaskMatters_createTable == 0) { // app第一次开启，第一次插入数据
        // 检测表是否存在
        if (![self detectionTableExistWithTableName:kTaskMattersTableName]) { // 不存在则需要先创建
            // 创建表列
            NSMutableString *tableColumStr = @"".mutableCopy;
            
            [tableColumStr appendString:@"date_str TEXT(20),"];         // 日期
            [tableColumStr appendString:@"add_date TEXT(20),"];         // 日期
            [tableColumStr appendString:@"title TEXT(50),"];            // 标题
            [tableColumStr appendString:@"introduction TEXT(255),"];    // 描述
            [tableColumStr appendString:@"level INTEGER(5),"];           // 事项等级
            [tableColumStr appendString:@"is_complete INTEGER(1)"];     // 是否完成
            
            NSString *sq_str = [NSString stringWithFormat:
                                @"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT,%@)",
                                kTaskMattersTableName,
                                tableColumStr];
            
            FMResultSet *rs = [self.db executeQuery:sq_str];
            if (![rs next]) {
                NSLog(@"数据库建表失败！");
            }else{
                self.addTaskMatters_createTable = 1; // 标记表已创建好
            }
        }
    }
    // 开始存储数据
    BOOL insert = [self.db executeUpdate:[NSString stringWithFormat:
                                          @"INSERT INTO %@ (date_str, add_date, title, introduction,level,is_complete) VALUES ('%@', '%@', '%@', '%@', %ld, %d);",
                                          kTaskMattersTableName,
                                          
                                          [model.date AxcTool_getDateWithFomant:kDateFormat],    // 时间戳
                                          [model.addDate AxcTool_getDateWithFomant:kDateFormat], // 添加日期
                                          model.title,                                           // 标题
                                          model.Introduction,                                    // 描述
                                          model.level,                                           // 事项等级
                                          model.isComplete                                       // 是否已完成
                                          ]];
    if (!insert) {
        NSLog(@"数据存储失败！");
    }
}

- (BOOL )detectionTableExistWithTableName:(NSString *)tableName{
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName ];
    FMResultSet *rs = [self.db executeQuery:existsSql];
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        return count == 1;
    }else{
        return NO;
    }
}

- (void)deleteTaskMatter:(MonthEventModel *)model{
    NSString *sq_str = [NSString stringWithFormat:
                        @"DELETE FROM %@ WHERE id = %@",
                        kTaskMattersTableName,
                        
                        model._id];
    BOOL delete_ = [self.db executeUpdate:sq_str];
    if (!delete_) {
        NSLog(@"数据删除失败！");
    }
}
- (void)completeTaskMatter:(MonthEventModel *)model{
    NSString *sq_str = [NSString stringWithFormat:
                        @"UPDATE %@ SET is_complete = 1 WHERE id = %@",
                        kTaskMattersTableName,
                        
                        model._id];
    BOOL delete_ = [self.db executeUpdate:sq_str];
    if (!delete_) {
        NSLog(@"数据更新-任务完成-失败！");
    }
}



#pragma mark - 懒加载
- (FMDatabase *)db{
    if (!_db) {
        NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),kAxcDB_Folder];
        NSString *dbName = @"Axc_Secretary.sqlite";
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:path]){
            //如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        _db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/%@",path,dbName]];
        if (![_db open]) {
            NSLog(@"数据库打开失败！");
        }
    }
    return _db;
}

@end
