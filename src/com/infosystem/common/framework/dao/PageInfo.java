package com.infosystem.common.framework.dao;

public class PageInfo {

   public static final String SORT_ASC = "asc";
   public static final String SORT_DESC = "desc";
   private final int startRow;
   private final int count;
   private final int stopRow;
   private final  String sortColumn;
   private  String sortStyle = SORT_ASC;

   public PageInfo(int startRow, int count, String sortColumn, String sortStyle) {
      this.startRow = startRow;
      this.count = count;
      this.stopRow = startRow + count;
      this.sortColumn = sortColumn;
      this.sortStyle = sortStyle;
   }

   public int getStartRow() {
      return startRow;
   }

   public int getCount() {
      return count;
   }

   public int getStopRow() {
      return stopRow;
   }

   public String getSortColumn(){
      return this.sortColumn;
   }

   public String getSortStyle(){
      return this.sortStyle;
   }

}
