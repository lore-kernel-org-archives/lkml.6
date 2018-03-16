Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeCPHUq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:20:46 -0400
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:37088
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753181AbeCPHR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:59 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 23/28] char: Remove Blackfin OTP support
Date: Fri, 16 Mar 2018 15:08:21 +0800
Message-ID: <1521184106-24475-21-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(4326008)(6916009)(8936002)(106466001)(246002)(8676002)(2906002)(47776003)(48376002)(50466002)(50226002)(5660300001)(6306002)(72206003)(107886003)(186003)(26005)(77096007)(305945005)(426003)(356003)(7636002)(6666003)(966005)(478600001)(2351001)(336012)(16586007)(36756003)(51416003)(86362001)(316002)(106002)(7696005)(59450400001)(76176011)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1482;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC003;1:NGlA1SAP+kPAeYVmv6eXuwNi0grch0WkoeAHrfge6eiGdFahbdjiu9zy18KlClHtfXsjZ5NSkW53at+NIFjaN/gm4m44SPhDcGQqFLfG7pnV9UCXp03iPwSC8b+14YLs
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03befa0-1544-4d4f-3bdb-08d58b0e086e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY1PR03MB1482;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1482;3:eYPBr+EcYkTkHO0PK4HJuNgmgk0RryfshgMUTQ3jqSpelCSSEGDHWNT4JUVw7riRGAjrtaxJuiKsCDeaDwqmLYVELlOv2CBzZ2EUCKjB8R+SQr+MN+S/7hczOQ0GPwJZ8P0y324EKJD09nC0NFm2xdu8Tk3tpiKTjYhqr5Kdzj9S/Ii1d8K6+y/Hbkb80zVcIKphKg+XEr8ZKLPk1Vcl7+k2XvYA9hh03G/6zvBD46NGbxnJFVmdw2Vt0BXsnXIJlpdWjEXYe1iJ5GThkMylDxqIeCk71FLPQcPNFsnPmKNsvn75O0Y8KuTEORMfTAI+U/S9LSsv63jKx00g9ed7WA==;25:ydEHaBLWWVXhPAks6RdT7P/IvtrVkvD+kINlNYj3PS1PJsIQJHOXVV38VwzDtHOnFAk2Xii1Zed1+YLlw+RTgWec1hchlramjZA6DU5zYyhHhb8bZy4j7Q1idpRSxXeMBxNhHF7/w4relrMbuSRYPGtvLMjIzdd9c0Oh8yUxzjEddlNI++zC5eh01o4XQ+KcHSmMXCQB+BABQWC007PKI/1l9kU7rOasf/TpyIeFg81914FI91CFMLzHXhY6b92BdZCRO1eeutjXhEB4YGmvaFcoD8jFQMPNNssue5qlB3xKKGGYm/U0tewJ2vjCdQwUyVIFHqSNyAfIuqYgdCMsIw==;31:zrJGdWBvP7sePeEuPB7056pco3Mu6U6odnHohueCkcusytcsOzqhJzTWXeA9DEd2FAdt0KlRYk8UAO+zW17SsMqnAlTHc4ks/WwJh86VU7VIs9ozIR0UdzdiHl2s1fqAcoPKRt8fZjWOqHNondG3zdQJA0Gor/xvrFNfQCuyTOD/tfrKKJjM7hpsOyE4u744t5UgHsLOxXzGEMQI73C4wQhC+C8AOzohUPl2zvB5DRQ=
X-MS-TrafficTypeDiagnostic: BY1PR03MB1482:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1482;20:BJ+ENle88NvBwUiB2YRUiXL24ZeuDAMKmWOlFK5yTgsarRL0neTDdL0fofRjwxwYC4hN36ygLr++24/KVUF+NFbp8UcrsNGfMsfmIuQI3fxLO9EMavnpETKGlvdKgSA345V3dWxHfnTaElUjoXilm1EpSazVH58ADGT1BkkK6nWIBd6SMM7FPJsBOPSofOYScGigu84FhTMBSQw1e1bssqN2dPfgcmZg2g5SWXKG4tUuGAmRyFXwC/n5SVuQ4ENEFpQwYv5NZkcBX2x2jADTfaZRz9oPnzKNA+7APyu56KckUK/idbvi4Rg/w9uv3+G5iwTv0s+4rpYXJV+aV0Z4p+0eG0nDKvkZyhSc3TPgMI8LEl/DVe494ZJ9kKqt36gd+Y5tnIv9bJDybWLAG/E4H2zHXJdllXULOl6tbBTBCvV6gmDJhy0Y7t6lRB9EGiRW9JlCmrYy5ANt5KiIPm/SEQYuer0Lj2RxzFjEYdcGyAcJRtfBdcUbm+ci1XvmeMyV;4:TghnUP/RnjbGPReo+WQRTSZEZSMwdmCKpKGKHXe03V88hzqgJGcICa07UBTaKJD6Ab/8ScqWqOzBa7Th9uOEX5qw4mmdk8Ito0TlxIGPClaQrrcT5q1pdyLQmRPlMMmOMjRLFrFBVMpmCtNXiCYgz73oPmrm4Zx9ena8UpOrJQ/iXbFf5TDkzTWjP+z+phdRs7rtMha9sxznGHhnA0PaLUoniQQiYC4HGzh/wIDle5hWnN8aPFTRsvdYR2Tfypz7zktZJP/UmvQYw0pnIj3FnVp3o84rcuiDyBKxpNpAxR7297iRWcN2ZjWLZSAGdG5s
X-Microsoft-Antispam-PRVS: <BY1PR03MB14828991F106A534EF1F97A0E0D70@BY1PR03MB1482.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BY1PR03MB1482;BCL:0;PCL:0;RULEID:;SRVR:BY1PR03MB1482;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1482;23:jOTdqUTaHbtDwu4qVJFkwezc158r1j0a5h8axAjvH?=
 =?us-ascii?Q?2JReFiX+eBmoP0FYAdajfXozTxCbfHQtDgW2Y4yhdcRAbmHfgZSf9zN+SA6s?=
 =?us-ascii?Q?8qKF8MLJ86JrQaAwtyMJXeAWcC4oQXCR2qnNLf/ORTzwY00jJf4sx0J7ocSi?=
 =?us-ascii?Q?Uce7axvA2pJLKqkorsOhLxlXMUP/KPpGocRS8Leq1mMHyswpQBPqHsEWBtbW?=
 =?us-ascii?Q?MkU+DiuVDA6L1KRU5jF1Cn6IBgi3qmIPOcnwFU6NuwUh9+rAvDMGQZEqnF5R?=
 =?us-ascii?Q?kle2y80ckTNG3Beakqo58Z7cCdXx5yBK04g64Du1VB/p5JweKOk7lImXOTLZ?=
 =?us-ascii?Q?Uf9EC/j6FXPa3Z5ybop7d6N2a1WeSPvUA23MNKqbXPVte3J6ChVMsAIv4f/5?=
 =?us-ascii?Q?WH5dobhHz64UTD5hWmevlrvy5L30nhpHOEZybNbAuXLGRZI77W0ZVejVb7lO?=
 =?us-ascii?Q?ptKWyMuPQEyz9Vd0PyiUZLbCYMDw6r8TrsxL2BZHeTnPRdRXnD5TDau1u+59?=
 =?us-ascii?Q?Tdyk/Zw7NXVDzUZo9BqkHFJkocISOuntlO3TTGWwZA/DXWBFhp7S3Zerqek/?=
 =?us-ascii?Q?gTgFmgr/WCC8Cxv71RJ4w8SdcBzgKurYZfPmpIbdiZ5ebC+gVF0jqI9ESejl?=
 =?us-ascii?Q?6/8zs4NKBY24rCxvQCO9E95/m0kXO+w62krTmcNvipuHzuWzKXwvM25rCPFH?=
 =?us-ascii?Q?QPDa9udRLcuTWMV8bnIj53zBbBKU3MEzJ961ClTULm4+P+CQbnKbNej7704X?=
 =?us-ascii?Q?1R9PBpk5iil9c+WyJK/2xazAvIsk5ddSxLKKgth3hCN4+PbHZvK8TPtT7rGa?=
 =?us-ascii?Q?utXJIen9ZfStAgf8IKmqhSmTgdxLNk6SUlr1vZd8tV2fXLfYuaWOMcof/Enq?=
 =?us-ascii?Q?+XRRTgcEKJNnd5EWnzWMJAMUCAyfUUYfAza76dgDatEWlQixUWbphs9YkfCz?=
 =?us-ascii?Q?2pJvuL3uMT2lQz5GcmCDdU825jGfCh+UWM5N4SlclEsLUEhM8woQJpPM98rH?=
 =?us-ascii?Q?TBYghtSd1BHe1Ry1+GW2tG/E3zBqnUtVxiLStAfyFEYrlEHf39Uagz54yAX6?=
 =?us-ascii?Q?hPiZEc=3D?=
X-Microsoft-Antispam-Message-Info: 3jzCAHUmbhw7EKiEZpmlJQI+i/60rV90xBPDjrCV+p2VvuOFi8j9ivln6f4xY3GnGwgVXFlAQD2cEBx3G0a5BVHXc1GDN2pOquuOfndQGn6NSFqheHFWXG9ny+l3ZaFrfo+CF2HicxC2eH1qjoSGyFWFZoJjC9BfzruR60lHc9rkjJk+sAYshSkB/VLuKjpi
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1482;6:woSddsatQfwwacC0S0H7HR2aD2BmOxO0vXivS9Y75chp1Z9giXKB3FxqurJf62c6fI8RNta/LyqnvzrCqOaaY9Ie/k4SnhgAaKMO+7LyoVmpGXWH20xjjupyIpn2XGz0EDIefkNDV0Zm9dxi2meKIkq4vdka1FJeZUWyLWWC1Xe8/SPXplHMP+3Gum3g7o5HzQ0RK8WD8wkBoGU5HJKHe/KDkiFoqGAErjI8s5Bwp+z1nYI6aEw/iHY87Ucndp8OjIRSdMCnkGOohyUoRIg4hoiss5xcxlNI89us06xcVDO/EwN5rJb8V0TJRsPH1Vn2SRLa7p+sVgUTCqwDbuFhWa0ERqYX4L5sgs53m2gCLdw=;5:VRKH07wuwFBHdlUZNjFinp6TSDQauHxyYKkI5DlWHYJ757fIQs8aLaev662xnzPh/VA1YoDk8EwOaSJ2DIpTCHjKRI3Drg7u51/Wz8ExbwG99DNv/qy4V8gcObodMuKjpvqrCxUxVEuZXgMRGzQb3uoZ/7pJuxWQUoRf7ZbMLyg=;24:18ie0OvHCDdkrjdI9b6wpTMMvokrHPxOmr41VCtQeaHKi6DAkb14vMszHQbMkYF3IR3VHc1QLjazUaA9BM15taqbKaJBD4/S6zli3vjcAf4=;7:LEtxphXgpvscoK67R4252jVLx8EZqPQdc8JBnszBy9pc7m7CQ8aH7CHkMopraG1YMoRzUaT7mhKCJ2o7bQ0V5qycly5ABbb0Ocmf1QWU+8kylGqBpcCgo66RRVlFHf1/nvbO7zxfcCrbQdIIt2eQvbN+0t+qRZIsujDUK6YL/4L4F9QtVhL0oji+rx8F1XktAI5yKRDmsgK9Il89dKmar58MV/bbAJhjqCmDlAKFk7NHndNKstLc7wDzNldhz6W9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:52.5358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d03befa0-1544-4d4f-3bdb-08d58b0e086e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1482
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin OTP support
---
 drivers/char/Kconfig    |  28 ------
 drivers/char/Makefile   |   1 -
 drivers/char/bfin-otp.c | 237 ------------------------------------------------
 3 files changed, 266 deletions(-)
 delete mode 100644 drivers/char/bfin-otp.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c28dca0..8f64ce8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -66,34 +66,6 @@ config TTY_PRINTK
 
 	  If unsure, say N.
 
-config BFIN_OTP
-	tristate "Blackfin On-Chip OTP Memory Support"
-	depends on BLACKFIN && (BF51x || BF52x || BF54x)
-	default y
-	help
-	  If you say Y here, you will get support for a character device
-	  interface into the One Time Programmable memory pages that are
-	  stored on the Blackfin processor.  This will not get you access
-	  to the secure memory pages however.  You will need to write your
-	  own secure code and reader for that.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called bfin-otp.
-
-	  If unsure, it is safe to say Y.
-
-config BFIN_OTP_WRITE_ENABLE
-	bool "Enable writing support of OTP pages"
-	depends on BFIN_OTP
-	default n
-	help
-	  If you say Y here, you will enable support for writing of the
-	  OTP pages.  This is dangerous by nature as you can only program
-	  the pages once, so only enable this option when you actually
-	  need it so as to not inadvertently clobber data.
-
-	  If unsure, say N.
-
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 7dc3abe..f28d07b 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MSPEC)		+= mspec.o
 obj-$(CONFIG_UV_MMTIMER)	+= uv_mmtimer.o
 obj-$(CONFIG_IBM_BSR)		+= bsr.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
-obj-$(CONFIG_BFIN_OTP)		+= bfin-otp.o
 
 obj-$(CONFIG_PRINTER)		+= lp.o
 
diff --git a/drivers/char/bfin-otp.c b/drivers/char/bfin-otp.c
deleted file mode 100644
index 0584025..0000000
--- a/drivers/char/bfin-otp.c
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- * Blackfin On-Chip OTP Memory Interface
- *
- * Copyright 2007-2009 Analog Devices Inc.
- *
- * Enter bugs at http://blackfin.uclinux.org/
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/miscdevice.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/types.h>
-#include <mtd/mtd-abi.h>
-
-#include <asm/blackfin.h>
-#include <asm/bfrom.h>
-#include <linux/uaccess.h>
-
-#define stamp(fmt, args...) pr_debug("%s:%i: " fmt "\n", __func__, __LINE__, ## args)
-#define stampit() stamp("here i am")
-#define pr_init(fmt, args...) ({ static const __initconst char __fmt[] = fmt; printk(__fmt, ## args); })
-
-#define DRIVER_NAME "bfin-otp"
-#define PFX DRIVER_NAME ": "
-
-static DEFINE_MUTEX(bfin_otp_lock);
-
-/**
- *	bfin_otp_read - Read OTP pages
- *
- *	All reads must be in half page chunks (half page == 64 bits).
- */
-static ssize_t bfin_otp_read(struct file *file, char __user *buff, size_t count, loff_t *pos)
-{
-	ssize_t bytes_done;
-	u32 page, flags, ret;
-	u64 content;
-
-	stampit();
-
-	if (count % sizeof(u64))
-		return -EMSGSIZE;
-
-	if (mutex_lock_interruptible(&bfin_otp_lock))
-		return -ERESTARTSYS;
-
-	bytes_done = 0;
-	page = *pos / (sizeof(u64) * 2);
-	while (bytes_done < count) {
-		flags = (*pos % (sizeof(u64) * 2) ? OTP_UPPER_HALF : OTP_LOWER_HALF);
-		stamp("processing page %i (0x%x:%s)", page, flags,
-			(flags & OTP_UPPER_HALF ? "upper" : "lower"));
-		ret = bfrom_OtpRead(page, flags, &content);
-		if (ret & OTP_MASTER_ERROR) {
-			stamp("error from otp: 0x%x", ret);
-			bytes_done = -EIO;
-			break;
-		}
-		if (copy_to_user(buff + bytes_done, &content, sizeof(content))) {
-			bytes_done = -EFAULT;
-			break;
-		}
-		if (flags & OTP_UPPER_HALF)
-			++page;
-		bytes_done += sizeof(content);
-		*pos += sizeof(content);
-	}
-
-	mutex_unlock(&bfin_otp_lock);
-
-	return bytes_done;
-}
-
-#ifdef CONFIG_BFIN_OTP_WRITE_ENABLE
-static bool allow_writes;
-
-/**
- *	bfin_otp_init_timing - setup OTP timing parameters
- *
- *	Required before doing any write operation.  Algorithms from HRM.
- */
-static u32 bfin_otp_init_timing(void)
-{
-	u32 tp1, tp2, tp3, timing;
-
-	tp1 = get_sclk() / 1000000;
-	tp2 = (2 * get_sclk() / 10000000) << 8;
-	tp3 = (0x1401) << 15;
-	timing = tp1 | tp2 | tp3;
-	if (bfrom_OtpCommand(OTP_INIT, timing))
-		return 0;
-
-	return timing;
-}
-
-/**
- *	bfin_otp_deinit_timing - set timings to only allow reads
- *
- *	Should be called after all writes are done.
- */
-static void bfin_otp_deinit_timing(u32 timing)
-{
-	/* mask bits [31:15] so that any attempts to write fail */
-	bfrom_OtpCommand(OTP_CLOSE, 0);
-	bfrom_OtpCommand(OTP_INIT, timing & ~(-1 << 15));
-	bfrom_OtpCommand(OTP_CLOSE, 0);
-}
-
-/**
- *	bfin_otp_write - write OTP pages
- *
- *	All writes must be in half page chunks (half page == 64 bits).
- */
-static ssize_t bfin_otp_write(struct file *filp, const char __user *buff, size_t count, loff_t *pos)
-{
-	ssize_t bytes_done;
-	u32 timing, page, base_flags, flags, ret;
-	u64 content;
-
-	if (!allow_writes)
-		return -EACCES;
-
-	if (count % sizeof(u64))
-		return -EMSGSIZE;
-
-	if (mutex_lock_interruptible(&bfin_otp_lock))
-		return -ERESTARTSYS;
-
-	stampit();
-
-	timing = bfin_otp_init_timing();
-	if (timing == 0) {
-		mutex_unlock(&bfin_otp_lock);
-		return -EIO;
-	}
-
-	base_flags = OTP_CHECK_FOR_PREV_WRITE;
-
-	bytes_done = 0;
-	page = *pos / (sizeof(u64) * 2);
-	while (bytes_done < count) {
-		flags = base_flags | (*pos % (sizeof(u64) * 2) ? OTP_UPPER_HALF : OTP_LOWER_HALF);
-		stamp("processing page %i (0x%x:%s) from %p", page, flags,
-			(flags & OTP_UPPER_HALF ? "upper" : "lower"), buff + bytes_done);
-		if (copy_from_user(&content, buff + bytes_done, sizeof(content))) {
-			bytes_done = -EFAULT;
-			break;
-		}
-		ret = bfrom_OtpWrite(page, flags, &content);
-		if (ret & OTP_MASTER_ERROR) {
-			stamp("error from otp: 0x%x", ret);
-			bytes_done = -EIO;
-			break;
-		}
-		if (flags & OTP_UPPER_HALF)
-			++page;
-		bytes_done += sizeof(content);
-		*pos += sizeof(content);
-	}
-
-	bfin_otp_deinit_timing(timing);
-
-	mutex_unlock(&bfin_otp_lock);
-
-	return bytes_done;
-}
-
-static long bfin_otp_ioctl(struct file *filp, unsigned cmd, unsigned long arg)
-{
-	stampit();
-
-	switch (cmd) {
-	case OTPLOCK: {
-		u32 timing;
-		int ret = -EIO;
-
-		if (!allow_writes)
-			return -EACCES;
-
-		if (mutex_lock_interruptible(&bfin_otp_lock))
-			return -ERESTARTSYS;
-
-		timing = bfin_otp_init_timing();
-		if (timing) {
-			u32 otp_result = bfrom_OtpWrite(arg, OTP_LOCK, NULL);
-			stamp("locking page %lu resulted in 0x%x", arg, otp_result);
-			if (!(otp_result & OTP_MASTER_ERROR))
-				ret = 0;
-
-			bfin_otp_deinit_timing(timing);
-		}
-
-		mutex_unlock(&bfin_otp_lock);
-
-		return ret;
-	}
-
-	case MEMLOCK:
-		allow_writes = false;
-		return 0;
-
-	case MEMUNLOCK:
-		allow_writes = true;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-#else
-# define bfin_otp_write NULL
-# define bfin_otp_ioctl NULL
-#endif
-
-static const struct file_operations bfin_otp_fops = {
-	.owner          = THIS_MODULE,
-	.unlocked_ioctl = bfin_otp_ioctl,
-	.read           = bfin_otp_read,
-	.write          = bfin_otp_write,
-	.llseek		= default_llseek,
-};
-
-static struct miscdevice bfin_otp_misc_device = {
-	.minor    = MISC_DYNAMIC_MINOR,
-	.name     = DRIVER_NAME,
-	.fops     = &bfin_otp_fops,
-};
-module_misc_device(bfin_otp_misc_device);
-
-MODULE_AUTHOR("Mike Frysinger <vapier@gentoo.org>");
-MODULE_DESCRIPTION("Blackfin OTP Memory Interface");
-MODULE_LICENSE("GPL");
-- 
2.7.4
