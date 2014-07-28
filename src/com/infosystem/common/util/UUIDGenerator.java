package com.infosystem.common.util;

import java.util.UUID;

public class UUIDGenerator implements IDGenerator<String> {

   private static UUIDGenerator generator = new UUIDGenerator();

   private UUIDGenerator() {
     
   }

   @Override
   public String getID() {
      UUID uid = UUID.randomUUID();
      return uid.toString();
   }

   public static UUIDGenerator getGenerator() {
      return generator;
   }

}
