package com.infosystem.common.util;

import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class IDIntegerCreater {

	private static AtomicInteger uniqueId = new AtomicInteger(0);
	private static  Lock LOCK = new ReentrantLock();
	private static int lastTime = (int) System.currentTimeMillis();
	private static int time;

	/**
	 * 获取唯一ID，为自增整数与当前应用服务时间整型数字之和
	 * 
	 */
	@SuppressWarnings("static-access")
	public static synchronized Long createID() {
		LOCK.lock();
		try{
			boolean done = false;
			while (!done) {
				int now = (int) System.currentTimeMillis();
				if (now == lastTime) {
					try {
						Thread.currentThread().sleep(1);
					}catch (java.lang.InterruptedException e){
						e.printStackTrace();
					}
					continue;
				}else {
					lastTime = now;
					done = true;
				}
			}
			time = lastTime;
		}finally {
			
		}
		LOCK.unlock();
		String str = Integer.valueOf(time+uniqueId.incrementAndGet()).toString();
		
		return Long.valueOf(str.replace("-", ""));
	}

}
