---
title: hbase学习笔记：通过java最新API操作HBase
tags:
  - 大数据
toc: false
comments: true
mathjax: true
categories:
  - 大数据
abbrlink: 88713ffb
date: 2020-05-18 17:06:58
---
**首先环境为：**
HBase的版本2.0.1，Hadoop版本2.7.1， JDK1.8

由于HBase目前网上介绍的API好多已经过时， 这里使用了最新的API，演示了如何创建表，插入数据，获取数据， 删除表几个功能。

```java
public class HbaseOpreation {
    /*
        旧版API，目前已经deprecated
     */
    @Test
    public void createTableOld() throws Exception {
        //配置ZooKeeper
        Configuration conf = new Configuration();
        conf.set("hbase.zookeeper.quorum", "node1");
        Connection connection = ConnectionFactory.createConnection(conf);
        HBaseAdmin admin = (HBaseAdmin) connection.getAdmin();

        //创建表
        HTableDescriptor ht = new HTableDescriptor(TableName.valueOf("mystudent"));
        // 创建列族
        HColumnDescriptor info = new HColumnDescriptor("info");
        HColumnDescriptor grade = new HColumnDescriptor("grade");
        ht.addFamily(info);
        ht.addFamily(grade);
        //创建表
        admin.createTable(ht);
        admin.close();
    }
    /*
        以下为新的API
     */
    @Test
    public void createTable() throws Exception {
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "node1");
        Connection connection = ConnectionFactory.createConnection(conf);
        //获取HBase管理员
        Admin admin = connection.getAdmin();
        //创建表
        TableDescriptorBuilder emp = TableDescriptorBuilder.newBuilder(TableName.valueOf("student"));
        // 添加列族信息
        ColumnFamilyDescriptor info = ColumnFamilyDescriptorBuilder
                .newBuilder(Bytes.toBytes("info")).build();
        ColumnFamilyDescriptor grade = ColumnFamilyDescriptorBuilder
                .newBuilder(Bytes.toBytes("grade")).build();
        ArrayList<ColumnFamilyDescriptor> familes = new ArrayList<>();
        familes.add(info);
        familes.add(grade);
        emp.setColumnFamilies(familes);
        admin.createTable(emp.build());
        admin.close();
    }

    @Test
    public void insert() throws Exception {
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "node1");
        Connection connection = ConnectionFactory.createConnection(conf);
        //打开表（获取表的实例）
        Table table = connection.getTable(TableName.valueOf("student"));
        //向表内添加2条信息
        ArrayList<Put> puts = new ArrayList<>();
        Put put1 = new Put(Bytes.toBytes("stu001"));
        put1.addColumn(Bytes.toBytes("info"), Bytes.toBytes("name"), Bytes.toBytes("Tom"));
        put1.addColumn(Bytes.toBytes("info"), Bytes.toBytes("age"), Bytes.toBytes("13"));
        Put put2 = new Put(Bytes.toBytes("stu002"));
        put2.addColumn(Bytes.toBytes("info"), Bytes.toBytes("name"), Bytes.toBytes("Steven"));
        put2.addColumn(Bytes.toBytes("grade"), Bytes.toBytes("Chinese"), Bytes.toBytes("87"));
        puts.add(put1);
        puts.add(put2);
        table.put(puts);
        //关闭表
        table.close();
    }

    @Test
    public void testGet() throws Exception {
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "node1");
        Connection connection = ConnectionFactory.createConnection(conf);
        //打开表（获取表的实例）
        Table table = connection.getTable(TableName.valueOf("student"));
        //获取数据
        ArrayList<Get> gets = new ArrayList<>();
        Get stu001 = new Get(Bytes.toBytes("stu001"));
        Get stu002 = new Get(Bytes.toBytes("stu002"));
        gets.add(stu001);
        gets.add(stu002);
        Result[] results = table.get(gets);
        //打印
        for (Result r : results) {
            String name = Bytes.toString(r.getValue(Bytes.toBytes("info"), Bytes.toBytes("name")));
            System.out.println(name);
        }
        //关闭表
        table.close();
    }

    @Test
    public void testScan() throws Exception{
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "node1");
        Connection connection = ConnectionFactory.createConnection(conf);
        //打开表（获取表的实例）
        Table table = connection.getTable(TableName.valueOf("student"));

        Scan scan = new Scan();
        ResultScanner results = table.getScanner(scan);
        for (Result r : results) {
            String name = Bytes.toString(r.getValue(Bytes.toBytes("info"), Bytes.toBytes("name")));
            System.out.println(name);
        }
        //关闭表
        table.close();
    }
    /*
        drop table
     */
    @Test
    public void testDropTable() throws Exception{
        TableName mystudent = TableName.valueOf("mystudent");
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "node1");
        Connection connection = ConnectionFactory.createConnection(conf);
        Admin admin = connection.getAdmin();
        if(admin.tableExists(mystudent)){
            admin.disableTable(mystudent);
            admin.deleteTable(mystudent);
            System.out.println("Delete table sucessed!!!");
        }else {
            System.out.println("Table is not exists!!!");
        }
        admin.close();
    }
}

```
