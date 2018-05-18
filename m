Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeERK0H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:26:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:37967 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeERK0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:26:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="56403566"
Date: Fri, 18 May 2018 18:25:04 +0800
From: kbuild test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/asm 2/2] drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:
 sparse: incorrect type in argument 1 (different base types)
Message-ID: <201805181855.m2NfiYNc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
head:   6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a
commit: 6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a [2/2] x86/io: Define readq()/writeq() to use 64-bit type
reproduce:
        # apt-get install sparse
        git checkout 6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/mpt3sas/mpt3sas_base.c:397:17: sparse: restricted __le32 degrades to integer
   drivers/scsi/mpt3sas/mpt3sas_base.c:403:34: sparse: restricted __le32 degrades to integer
   drivers/scsi/mpt3sas/mpt3sas_base.c:414:53: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned long long [unsigned] [usertype] chain_buffer_dma @@    got g long [unsigned] [usertype] chain_buffer_dma @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:414:53:    expected unsigned long long [unsigned] [usertype] chain_buffer_dma
   drivers/scsi/mpt3sas/mpt3sas_base.c:414:53:    got restricted __le32 [usertype] Address
   drivers/scsi/mpt3sas/mpt3sas_base.c:429:39: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] Address @@    got unsignrestricted __le32 [usertype] Address @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:429:39:    expected restricted __le32 [usertype] Address
   drivers/scsi/mpt3sas/mpt3sas_base.c:429:39:    got unsigned int [unsigned] [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:438:50: sparse: restricted __le32 degrades to integer
   drivers/scsi/mpt3sas/mpt3sas_base.c:443:55: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] Address @@    got unsignrestricted __le32 [usertype] Address @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:443:55:    expected restricted __le32 [usertype] Address
   drivers/scsi/mpt3sas/mpt3sas_base.c:443:55:    got unsigned int [unsigned] [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:447:50: sparse: restricted __le32 degrades to integer
   drivers/scsi/mpt3sas/mpt3sas_base.c:448:55: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] Address @@    got unsignrestricted __le32 [usertype] Address @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:448:55:    expected restricted __le32 [usertype] Address
   drivers/scsi/mpt3sas/mpt3sas_base.c:448:55:    got unsigned int [unsigned] [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:451:42: sparse: restricted __le32 degrades to integer
   drivers/scsi/mpt3sas/mpt3sas_base.c:452:47: sparse: restricted __le32 degrades to integer
   drivers/scsi/mpt3sas/mpt3sas_base.c:453:34: sparse: restricted __le32 degrades to integer
   drivers/scsi/mpt3sas/mpt3sas_base.c:1217:42: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] Event @@    got  short [unsigned] [usertype] Event @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1217:42:    expected unsigned short [unsigned] [usertype] Event
   drivers/scsi/mpt3sas/mpt3sas_base.c:1217:42:    got restricted __le16 [usertype] Event
   drivers/scsi/mpt3sas/mpt3sas_base.c:1218:49: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] EventContext @@    got ed int [unsigned] [usertype] EventContext @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1218:49:    expected unsigned int [unsigned] [usertype] EventContext
   drivers/scsi/mpt3sas/mpt3sas_base.c:1218:49:    got restricted __le32 [usertype] EventContext
   drivers/scsi/mpt3sas/mpt3sas_base.c:1436:49: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] [usertype] reply @@    got ed int [unsigned] [usertype] reply @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1436:49:    expected unsigned int [unsigned] [usertype] reply
   drivers/scsi/mpt3sas/mpt3sas_base.c:1436:49:    got restricted __le32 [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:1462:64: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got oid volatile [noderef] <asn:2>*addr @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1462:64:    expected void volatile [noderef] <asn:2>*addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:1462:64:    got unsigned long long [usertype] *<noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:1511:52: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got oid volatile [noderef] <asn:2>*addr @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1511:52:    expected void volatile [noderef] <asn:2>*addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:1511:52:    got unsigned long long [usertype] *<noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:2004:24: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:2762:44: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:2762:44: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:2841:34: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:2841:34: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:2854:42: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:2854:42: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:3047:32: sparse: cast removes address space of expression
   drivers/scsi/mpt3sas/mpt3sas_base.c:3392:26: sparse: cast removes address space of expression
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26: sparse: incorrect type in initializer (different base types) @@    expected unsigned long long [unsigned] [usertype] data_out @@    got g long [unsigned] [usertype] data_out @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26:    expected unsigned long long [unsigned] [usertype] data_out
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26:    got restricted __le64 [usertype] <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned long long [unsigned] [usertype] val @@    got g long [unsigned] [usertype] val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    expected unsigned long long [unsigned] [usertype] val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    got restricted __le64 [usertype] <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned long long [unsigned] [usertype] val @@    got g long [unsigned] [usertype] val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    expected unsigned long long [unsigned] [usertype] val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    got restricted __le64 [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:3476:34: sparse: cast removes address space of expression
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26: sparse: incorrect type in initializer (different base types) @@    expected unsigned long long [unsigned] [usertype] data_out @@    got g long [unsigned] [usertype] data_out @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26:    expected unsigned long long [unsigned] [usertype] data_out
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26:    got restricted __le64 [usertype] <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned long long [unsigned] [usertype] val @@    got g long [unsigned] [usertype] val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    expected unsigned long long [unsigned] [usertype] val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    got restricted __le64 [usertype] <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned long long [unsigned] [usertype] val @@    got g long [unsigned] [usertype] val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    expected unsigned long long [unsigned] [usertype] val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    got restricted __le64 [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:3545:34: sparse: cast removes address space of expression
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26: sparse: incorrect type in initializer (different base types) @@    expected unsigned long long [unsigned] [usertype] data_out @@    got g long [unsigned] [usertype] data_out @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26:    expected unsigned long long [unsigned] [usertype] data_out
   drivers/scsi/mpt3sas/mpt3sas_base.c:3342:26:    got restricted __le64 [usertype] <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned long long [unsigned] [usertype] val @@    got g long [unsigned] [usertype] val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    expected unsigned long long [unsigned] [usertype] val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3365:16:    got restricted __le64 [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:4232:32: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4241:40: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4251:31: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4251:31: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4267:38: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4267:38: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4272:38: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4272:38: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4275:38: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4304:20: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4304:20: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4325:44: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4325:44: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:4491:28: sparse: expression using sizeof(void)
   drivers/scsi/mpt3sas/mpt3sas_base.c:5005:24: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [unsigned] val @@    got restrunsigned int [unsigned] val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:5005:24:    expected unsigned int [unsigned] val
   drivers/scsi/mpt3sas/mpt3sas_base.c:5005:24:    got restricted __le32 [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:5026:20: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:5035:20: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:5049:36: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:6175:42: sparse: cast to restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:6175:42: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] [usertype] reply @@    got ed int [unsigned] [usertype] reply @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:6175:42:    expected unsigned int [unsigned] [usertype] reply
   drivers/scsi/mpt3sas/mpt3sas_base.c:6175:42:    got restricted __le32 [usertype] <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:6220:55: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got oid volatile [noderef] <asn:2>*addr @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:6220:55:    expected void volatile [noderef] <asn:2>*addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:6220:55:    got unsigned long long [usertype] *<noident>

vim +3365 drivers/scsi/mpt3sas/mpt3sas_base.c

e5747439 Suganath Prabu Subramani 2018-02-07  3349  
e5747439 Suganath Prabu Subramani 2018-02-07  3350  /**
f92363d1 Sreekanth Reddy          2012-11-30  3351   * _base_writeq - 64 bit write to MMIO
f92363d1 Sreekanth Reddy          2012-11-30  3352   * @ioc: per adapter object
f92363d1 Sreekanth Reddy          2012-11-30  3353   * @b: data payload
f92363d1 Sreekanth Reddy          2012-11-30  3354   * @addr: address in MMIO space
f92363d1 Sreekanth Reddy          2012-11-30  3355   * @writeq_lock: spin lock
f92363d1 Sreekanth Reddy          2012-11-30  3356   *
f92363d1 Sreekanth Reddy          2012-11-30  3357   * Glue for handling an atomic 64 bit word to MMIO. This special handling takes
f92363d1 Sreekanth Reddy          2012-11-30  3358   * care of 32 bit environment where its not quarenteed to send the entire word
f92363d1 Sreekanth Reddy          2012-11-30  3359   * in one transfer.
f92363d1 Sreekanth Reddy          2012-11-30  3360   */
f92363d1 Sreekanth Reddy          2012-11-30  3361  #if defined(writeq) && defined(CONFIG_64BIT)
f92363d1 Sreekanth Reddy          2012-11-30  3362  static inline void
f92363d1 Sreekanth Reddy          2012-11-30  3363  _base_writeq(__u64 b, volatile void __iomem *addr, spinlock_t *writeq_lock)
f92363d1 Sreekanth Reddy          2012-11-30  3364  {
f92363d1 Sreekanth Reddy          2012-11-30 @3365  	writeq(cpu_to_le64(b), addr);
f92363d1 Sreekanth Reddy          2012-11-30  3366  }
f92363d1 Sreekanth Reddy          2012-11-30  3367  #else
f92363d1 Sreekanth Reddy          2012-11-30  3368  static inline void
f92363d1 Sreekanth Reddy          2012-11-30  3369  _base_writeq(__u64 b, volatile void __iomem *addr, spinlock_t *writeq_lock)
f92363d1 Sreekanth Reddy          2012-11-30  3370  {
e5747439 Suganath Prabu Subramani 2018-02-07  3371  	_base_mpi_ep_writeq(b, addr, writeq_lock);
f92363d1 Sreekanth Reddy          2012-11-30  3372  }
f92363d1 Sreekanth Reddy          2012-11-30  3373  #endif
f92363d1 Sreekanth Reddy          2012-11-30  3374  

:::::: The code at line 3365 was first introduced by commit
:::::: f92363d12359498f9a9960511de1a550f0ec41c2 [SCSI] mpt3sas: add new driver supporting 12GB SAS

:::::: TO: Sreekanth Reddy <Sreekanth.Reddy@lsi.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
