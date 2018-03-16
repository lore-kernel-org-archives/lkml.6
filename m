Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeCPHRj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:17:39 -0400
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:34015
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753098AbeCPHR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:29 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 07/28] watchdog: Remove Blackfin watchdog support
Date: Fri, 16 Mar 2018 15:08:05 +0800
Message-ID: <1521184106-24475-5-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(4326008)(72206003)(6916009)(16586007)(246002)(478600001)(966005)(6666003)(86362001)(26005)(77096007)(107886003)(47776003)(186003)(2950100002)(336012)(305945005)(7696005)(51416003)(5660300001)(7636002)(6306002)(50466002)(2351001)(48376002)(316002)(76176011)(426003)(106466001)(106002)(356003)(59450400001)(8676002)(2906002)(36756003)(50226002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1475;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD027;1:8FHwC6HTr5M3Kw2HZp87BM7gsfiWZm9daQVkQwqA0Si87gDqW2oCza3A3jZuWQtNBqFSvZ3XBhx8QxobAgNkxqoqu2vvw7MwCFebQW8B1VpBaBPEnL4c/0gQYMiaTdkr
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9230b15e-e8bc-45e9-f114-08d58b0df901
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BLUPR03MB1475;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1475;3:MRysbbmCngphbZlhWM54GpVbi2vhXj5zOlOpJO+aZnuUEaa9ISlBmZtdu3/ndf4DJigFfMg20+f6xk0ziYVFtgmBzygOPuoQzxaYat9ScIWmkvgLAlx5PYlK0BsX+x+DI2Tnplmjqan1YGM3Ul1QwSMVkbApxnKifYS2OlysO+h0y49V70h8SjDFb/+pusAgZUv+iKxYb/CtQv+0CKSMnCFEhweMcLqiBz+ecThnMWWnbd65EdNElFu9J7orqfAH4hxtUUoT5CHc0YCpGLavNRkbcC9rLI9zYr7rqLFckaKe7AIgCL3yW+wKOpRYoDu0SOkmM+Vundr4seCQzyvifA==;25:E6+1cJgxD2ntG4/H3J154ER6Ch/l9vr6JJ5ExKKyB0c8xNRloZLKT1JeQ/ZvjTGT4JUYTeIhcK97ssrs8u11C2YVOMbwYWoxw0/ifSnu5TPFjcffm8GKD/txKJvR2GkOx4yWpwRhXpolnzbM/rigtR34KoaN7SeVxy9A0YXWt+V1BKonMgfqH0iS2UKlSkKEIMptFlmXRvA1mIQlpmUziikq711SmEk/9nduaPea1pGbO3BOXWbaBZtwqSReJX6b1Q3+wYc4QxDNquYYMePKBNVXVDI7eiZMEDq5BD8pqWYe/Z+4swFTO9Vf3G0TKZEqv998VzBOWkHh2YKgDsPp/Q==;31:5JMaBgoI0vr6PcyCtw+hcfYDUADObkCGr1e7fMADAgpQ1vc9wXmDbrBsT/zE8djX7PcVCnvyZtubMjaKxbYtF95nqCqw1cHclBgnyxSQctQfV5VBzxk9sv9YXGfhpUq+is3OGostvojfmKEVBTsVdj2M4vQH+EqZUM0EAieSs6ZoURcfHIseTI2h60s184h2y6JNm/rXiM2F8DAOUspcDlKXUGeBYppjDsjaPY7DeEA=
X-MS-TrafficTypeDiagnostic: BLUPR03MB1475:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1475;20:HmxEMlJ19GGgbU5zMO+8o6l5HS7eOI3zqNjUAquANDNi0cF0Pwlu5kfOvjjp3x1bvwxqr6xvhC0V6W21Q+OR2b1TGhGJazLaBlT286ZFdj0Bb4TjBXKLFdwuqGUQpBpIVLHmk7dRFPduhVOC10o5pqC8hli7EKphP/kVWPSWY1nRaSlCgiJdnw4WDAj9s9jAtC8rZ/81E0mw+bvGE8nG3hmwpfMcpYkj/7+1TxDUe7yTXMW2ztiGVObG1PbmWUbtYIp1SwykmDqZ1+RuHXH6iH96WyBw0pTLF5YuViR8ieJvIU4/pIT8jRNhSBLcbBiHr+chjF4XACG9yFRVpagLhkS5DakkrKU3tAIclzhE3/eY8mVa+XyiCZRN2o/QL+t9UOKswzSC4rjpe96jEigtVZaN8F2Uj1DzN6avoHYQrM7wifU/LFhlK2UtMQfECBa7uXaSX9pg1Px90MkBhgGNj5LSfb5LHczNZnajPMz6jyxtriVitMFDh2/fd2CXu48T;4:YVfLzHL7Yl+yqm5TUbLOtnsIWzi3xXh5tpFrhjurHl3E/VAqO4Wi+HfXnBN/+rmi2caeppBY6e67uc7T/6HcAuIgyoFZKqgzoCxmyydjVc502JqIcwOHACVmcna0zLeCFHGmi1oAwBv3ZzIre7F9N5/roufYq1boDSl/x4zIJ70pB6IHBcg0wVajZWCkKJJ/8Z6oryIzOo+XZ2u+1PnS6kGgaa5426QFP0Xl6QCFXw5qOPJhvDN3F4dHPjqmoQ0ViDfylYMNLteKFQ9BPmZnZ6/FiSkgitUNt8MK/jBTJ3nlRJAOIqwqZWcyqxmVaJQm
X-Microsoft-Antispam-PRVS: <BLUPR03MB147583E9EFBA731778945511E0D70@BLUPR03MB1475.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BLUPR03MB1475;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB1475;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB1475;23:z3NsESSa1SHMCgFx46hCyOdMcxtWFtVDHx8FLdvMm?=
 =?us-ascii?Q?ZPcfAFBpl498LfDlO1KR1fifiiyCw0tSDG+RlVGXtbuUBdqmpS8/HeikIKnd?=
 =?us-ascii?Q?Jf6aJfb0kxvRb5YTtZ9z8SdSP0RwOsztL04yYikh6b7OTTf/V0aZAQ84qeRL?=
 =?us-ascii?Q?MWqJJQUD7DHc/DcB1ujk7hZmIrbGxOTx2irk/NCbu/RnE/bo/hJpNdS4hOkD?=
 =?us-ascii?Q?GMDu3LI7ii+FcDprCynsyxnGbyKOepNSn1ErDrKfrjVpqaJRrEvp0MGd8IXH?=
 =?us-ascii?Q?soq/YOH/kXmosnqwnXp757dD+Srb8Z1AkUuwTnhzdW0+zf+km4EtrC8eAGoE?=
 =?us-ascii?Q?+O78NO074Sj42X7TCjsaMDQdIT+jKqbhO30ibx764Z2dhSeI11IZUZNSmp1i?=
 =?us-ascii?Q?NpTgYXO/JbAI1+/LZUxWEU+qhYXgLHVpUxfW4hLET+L2Kv1ukQlvWjM750iS?=
 =?us-ascii?Q?j1XW/VR6J/OMHsZSW+ypW+6cyt1Naua9QhYtuJKZvGhvvOjZZNw/e0vcpTQh?=
 =?us-ascii?Q?Pfqz9lmIgroA5IMd5jJxgxKqs6OXgyB85Cia1Dk3+wwuAa01DL+zfhat2Orm?=
 =?us-ascii?Q?Snm4D0xqU2Id0z16QaZnXSkNITwiJbjx7A5WLmih0XTLIEN5ZAZi+EpiuCEG?=
 =?us-ascii?Q?Dwvz1NvwzFnZ3y9PxeZUGBOc+ireEknvZwxBepMT+ftTEUOKN2x+esqVaV/S?=
 =?us-ascii?Q?u9qiSajYwBJx0687wUALfICM0oEKTtNhsXBbdlqogR4guSksFCXEFcXuArg6?=
 =?us-ascii?Q?T2usd994NYeEoyZRa5KomsHHQ9YMPhAfdheKHUR5Ara1XH9fVpt4cDa1urdq?=
 =?us-ascii?Q?qaCrSsfLoQi2nwJA6TZgB+HzfOSVmBNuhTIh2MTPiYoxi4q9rw46OLxpiyN+?=
 =?us-ascii?Q?iVqpstYoQAf7RU1t57Ucx0u/O9N71JhBb42v/o9efQsf7l3Q+H0tOXvqmRL5?=
 =?us-ascii?Q?GlG7zG/pOVLHgO6DU3rB6Z8aC37GGddv9sRZdGMeoxltQJ+rdwTOUebd/UlD?=
 =?us-ascii?Q?lu2Lxwn58U+ry+F6pSk0qsg2+XjTFedSB56UChLoLT+vd9dMssD3YlKOxTxm?=
 =?us-ascii?Q?FKgI8s=3D?=
X-Microsoft-Antispam-Message-Info: 0/WP6i1siLO+F35jB0hneFatsCx3/CA1YT+/hXgw3PO8NOM0c/TGABOVRUhniPm6I0bPRMTAkmB3CYvf281rg0HeZhsNyM/cOq8JkJ7PXpWqtWgnM/wWbhs9E5ghk1gijaV5EhBA4xSC9YuayJCxrBp9YPDLu8xgRBE1XOV3ffPV9sDlQ5M5IsJzBBTlnMyA
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1475;6:EZ/0AWMmiKPkXHXHxODzQCAc3m1lfL2nw3Xd9ju/B3sGyUM7rutmiNtm4eYTPb4GqPFcGRArv/RkQ5YgAGPS+9KkiSCwYeTGgvhmKM8oHokYmjZjcdLT2Xo0oUpC8VCEgHNYl7Tq7BgH8keOgOyOLYfaQs10O18tzv2DMTWsZqYD9KP2uXGMf+Bz7LgkyqBR8dBSjxJ+fGOWGSJ4G378gw7ce7RZniTQpGCqfGyaEljrHp83li2YczTYsRe5gEh9SAPK+IdUfOBK7DtAxTnvR04JGN/I17tQk1atj0wkwb4pDzuVBgebnPpehb4JqZw9oEyfe9ZtJsqk3On/HrXab1lFhraHU53Uq+OMqRwQ2RM=;5:vfAars+ZkWSnCJrpuBnXEYlcgIDI9cKcftoCrQwBybnG+vkDFRbn9gXy13dUMtc0SOUzcxmrul5DsOH0NyBc5KsV+aFdtFImuZRhT1Lgka2n0Z4cmwkJm/cqvn/xHX/sZLXzvuYEEz/KgOmwKE0MieTJdsIZ9zSr3NO10wpurJM=;24:sKuzTUHt4gKHMfbhOJW0n9KuE0/ACb8tCxUwNMk4upcBcTjn/vxepNs/g+KD3IxxBBBy3+xDDtVQCnp/dWW++IyQJyMKC8enivws2oAPFF0=;7:kGNdMsrjpPdBrNjY8BIOqURe2vigsEcVyvtItrDEvvCLHRkO1jgmj5UnZQ4bRiKvMmlYIFKRdFcB6EUom4BOyOpyvq0fxS2ZeOvQ40qFUR45ROHBnA0P/OyhSprOR6VOAktNVqPbfaOi1s6e6w9NIQttGBu62+YaREYKawEGmJfRnYNR5md3DeL6Qx/qHQSfEdtItkNlZTvr1u5Vo7a4UeP6zWK+TtgelQY8FxKaJ9LcqpzuNEK3Vw8V2S1uOnVf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:27.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9230b15e-e8bc-45e9-f114-08d58b0df901
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB1475
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin watchdog support
---
 drivers/watchdog/Kconfig    |  13 --
 drivers/watchdog/Makefile   |   3 -
 drivers/watchdog/bfin_wdt.c | 476 --------------------------------------------
 3 files changed, 492 deletions(-)
 delete mode 100644 drivers/watchdog/bfin_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 37460cd..6174e99 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -815,19 +815,6 @@ config SPRD_WATCHDOG
 	  Say Y here to include watchdog timer supported
 	  by Spreadtrum system.
 
-# BLACKFIN Architecture
-
-config BFIN_WDT
-	tristate "Blackfin On-Chip Watchdog Timer"
-	depends on BLACKFIN
-	---help---
-	  If you say yes here you will get support for the Blackfin On-Chip
-	  Watchdog Timer. If you have one of these processors and wish to
-	  have watchdog support enabled, say Y, otherwise say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_wdt.
-
 # CRIS Architecture
 
 # FRV Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0474d38..1971f86 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -91,9 +91,6 @@ obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
 obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
 obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
 
-# BLACKFIN Architecture
-obj-$(CONFIG_BFIN_WDT) += bfin_wdt.o
-
 # CRIS Architecture
 
 # FRV Architecture
diff --git a/drivers/watchdog/bfin_wdt.c b/drivers/watchdog/bfin_wdt.c
deleted file mode 100644
index aa4d2e8..0000000
--- a/drivers/watchdog/bfin_wdt.c
+++ /dev/null
@@ -1,476 +0,0 @@
-/*
- * Blackfin On-Chip Watchdog Driver
- *
- * Originally based on softdog.c
- * Copyright 2006-2010 Analog Devices Inc.
- * Copyright 2006-2007 Michele d'Amico
- * Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>
- *
- * Enter bugs at http://blackfin.uclinux.org/
- *
- * Licensed under the GPL-2 or later.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/timer.h>
-#include <linux/miscdevice.h>
-#include <linux/watchdog.h>
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/uaccess.h>
-#include <asm/blackfin.h>
-#include <asm/bfin_watchdog.h>
-
-#define stamp(fmt, args...) \
-	pr_debug("%s:%i: " fmt "\n", __func__, __LINE__, ## args)
-#define stampit() stamp("here i am")
-
-#define WATCHDOG_NAME "bfin-wdt"
-
-/* The BF561 has two watchdogs (one per core), but since Linux
- * only runs on core A, we'll just work with that one.
- */
-#ifdef BF561_FAMILY
-# define bfin_read_WDOG_CTL()    bfin_read_WDOGA_CTL()
-# define bfin_read_WDOG_CNT()    bfin_read_WDOGA_CNT()
-# define bfin_read_WDOG_STAT()   bfin_read_WDOGA_STAT()
-# define bfin_write_WDOG_CTL(x)  bfin_write_WDOGA_CTL(x)
-# define bfin_write_WDOG_CNT(x)  bfin_write_WDOGA_CNT(x)
-# define bfin_write_WDOG_STAT(x) bfin_write_WDOGA_STAT(x)
-#endif
-
-/* some defaults */
-#define WATCHDOG_TIMEOUT 20
-
-static unsigned int timeout = WATCHDOG_TIMEOUT;
-static bool nowayout = WATCHDOG_NOWAYOUT;
-static const struct watchdog_info bfin_wdt_info;
-static unsigned long open_check;
-static char expect_close;
-static DEFINE_SPINLOCK(bfin_wdt_spinlock);
-
-/**
- *	bfin_wdt_keepalive - Keep the Userspace Watchdog Alive
- *
- *	The Userspace watchdog got a KeepAlive: schedule the next timeout.
- */
-static int bfin_wdt_keepalive(void)
-{
-	stampit();
-	bfin_write_WDOG_STAT(0);
-	return 0;
-}
-
-/**
- *	bfin_wdt_stop - Stop the Watchdog
- *
- *	Stops the on-chip watchdog.
- */
-static int bfin_wdt_stop(void)
-{
-	stampit();
-	bfin_write_WDOG_CTL(WDEN_DISABLE);
-	return 0;
-}
-
-/**
- *	bfin_wdt_start - Start the Watchdog
- *
- *	Starts the on-chip watchdog.  Automatically loads WDOG_CNT
- *	into WDOG_STAT for us.
- */
-static int bfin_wdt_start(void)
-{
-	stampit();
-	bfin_write_WDOG_CTL(WDEN_ENABLE | ICTL_RESET);
-	return 0;
-}
-
-/**
- *	bfin_wdt_running - Check Watchdog status
- *
- *	See if the watchdog is running.
- */
-static int bfin_wdt_running(void)
-{
-	stampit();
-	return ((bfin_read_WDOG_CTL() & WDEN_MASK) != WDEN_DISABLE);
-}
-
-/**
- *	bfin_wdt_set_timeout - Set the Userspace Watchdog timeout
- *	@t: new timeout value (in seconds)
- *
- *	Translate the specified timeout in seconds into System Clock
- *	terms which is what the on-chip Watchdog requires.
- */
-static int bfin_wdt_set_timeout(unsigned long t)
-{
-	u32 cnt, max_t, sclk;
-	unsigned long flags;
-
-	sclk = get_sclk();
-	max_t = -1 / sclk;
-	cnt = t * sclk;
-	stamp("maxtimeout=%us newtimeout=%lus (cnt=%#x)", max_t, t, cnt);
-
-	if (t > max_t) {
-		pr_warn("timeout value is too large\n");
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&bfin_wdt_spinlock, flags);
-	{
-		int run = bfin_wdt_running();
-		bfin_wdt_stop();
-		bfin_write_WDOG_CNT(cnt);
-		if (run)
-			bfin_wdt_start();
-	}
-	spin_unlock_irqrestore(&bfin_wdt_spinlock, flags);
-
-	timeout = t;
-
-	return 0;
-}
-
-/**
- *	bfin_wdt_open - Open the Device
- *	@inode: inode of device
- *	@file: file handle of device
- *
- *	Watchdog device is opened and started.
- */
-static int bfin_wdt_open(struct inode *inode, struct file *file)
-{
-	stampit();
-
-	if (test_and_set_bit(0, &open_check))
-		return -EBUSY;
-
-	if (nowayout)
-		__module_get(THIS_MODULE);
-
-	bfin_wdt_keepalive();
-	bfin_wdt_start();
-
-	return nonseekable_open(inode, file);
-}
-
-/**
- *	bfin_wdt_close - Close the Device
- *	@inode: inode of device
- *	@file: file handle of device
- *
- *	Watchdog device is closed and stopped.
- */
-static int bfin_wdt_release(struct inode *inode, struct file *file)
-{
-	stampit();
-
-	if (expect_close == 42)
-		bfin_wdt_stop();
-	else {
-		pr_crit("Unexpected close, not stopping watchdog!\n");
-		bfin_wdt_keepalive();
-	}
-	expect_close = 0;
-	clear_bit(0, &open_check);
-	return 0;
-}
-
-/**
- *	bfin_wdt_write - Write to Device
- *	@file: file handle of device
- *	@buf: buffer to write
- *	@count: length of buffer
- *	@ppos: offset
- *
- *	Pings the watchdog on write.
- */
-static ssize_t bfin_wdt_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
-{
-	stampit();
-
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			/* In case it was set long ago */
-			expect_close = 0;
-
-			for (i = 0; i != len; i++) {
-				char c;
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_close = 42;
-			}
-		}
-		bfin_wdt_keepalive();
-	}
-
-	return len;
-}
-
-/**
- *	bfin_wdt_ioctl - Query Device
- *	@file: file handle of device
- *	@cmd: watchdog command
- *	@arg: argument
- *
- *	Query basic information from the device or ping it, as outlined by the
- *	watchdog API.
- */
-static long bfin_wdt_ioctl(struct file *file,
-				unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-
-	stampit();
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		if (copy_to_user(argp, &bfin_wdt_info, sizeof(bfin_wdt_info)))
-			return -EFAULT;
-		else
-			return 0;
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(!!(_bfin_swrst & SWRST_RESET_WDOG), p);
-	case WDIOC_SETOPTIONS: {
-		unsigned long flags;
-		int options, ret = -EINVAL;
-
-		if (get_user(options, p))
-			return -EFAULT;
-
-		spin_lock_irqsave(&bfin_wdt_spinlock, flags);
-		if (options & WDIOS_DISABLECARD) {
-			bfin_wdt_stop();
-			ret = 0;
-		}
-		if (options & WDIOS_ENABLECARD) {
-			bfin_wdt_start();
-			ret = 0;
-		}
-		spin_unlock_irqrestore(&bfin_wdt_spinlock, flags);
-		return ret;
-	}
-	case WDIOC_KEEPALIVE:
-		bfin_wdt_keepalive();
-		return 0;
-	case WDIOC_SETTIMEOUT: {
-		int new_timeout;
-
-		if (get_user(new_timeout, p))
-			return -EFAULT;
-		if (bfin_wdt_set_timeout(new_timeout))
-			return -EINVAL;
-	}
-	/* Fall */
-	case WDIOC_GETTIMEOUT:
-		return put_user(timeout, p);
-	default:
-		return -ENOTTY;
-	}
-}
-
-#ifdef CONFIG_PM
-static int state_before_suspend;
-
-/**
- *	bfin_wdt_suspend - suspend the watchdog
- *	@pdev: device being suspended
- *	@state: requested suspend state
- *
- *	Remember if the watchdog was running and stop it.
- *	TODO: is this even right?  Doesn't seem to be any
- *	      standard in the watchdog world ...
- */
-static int bfin_wdt_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	stampit();
-
-	state_before_suspend = bfin_wdt_running();
-	bfin_wdt_stop();
-
-	return 0;
-}
-
-/**
- *	bfin_wdt_resume - resume the watchdog
- *	@pdev: device being resumed
- *
- *	If the watchdog was running, turn it back on.
- */
-static int bfin_wdt_resume(struct platform_device *pdev)
-{
-	stampit();
-
-	if (state_before_suspend) {
-		bfin_wdt_set_timeout(timeout);
-		bfin_wdt_start();
-	}
-
-	return 0;
-}
-#else
-# define bfin_wdt_suspend NULL
-# define bfin_wdt_resume NULL
-#endif
-
-static const struct file_operations bfin_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.write		= bfin_wdt_write,
-	.unlocked_ioctl	= bfin_wdt_ioctl,
-	.open		= bfin_wdt_open,
-	.release	= bfin_wdt_release,
-};
-
-static struct miscdevice bfin_wdt_miscdev = {
-	.minor    = WATCHDOG_MINOR,
-	.name     = "watchdog",
-	.fops     = &bfin_wdt_fops,
-};
-
-static const struct watchdog_info bfin_wdt_info = {
-	.identity = "Blackfin Watchdog",
-	.options  = WDIOF_SETTIMEOUT |
-		    WDIOF_KEEPALIVEPING |
-		    WDIOF_MAGICCLOSE,
-};
-
-/**
- *	bfin_wdt_probe - Initialize module
- *
- *	Registers the misc device.  Actual device
- *	initialization is handled by bfin_wdt_open().
- */
-static int bfin_wdt_probe(struct platform_device *pdev)
-{
-	int ret;
-
-	ret = misc_register(&bfin_wdt_miscdev);
-	if (ret) {
-		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
-		       WATCHDOG_MINOR, ret);
-		return ret;
-	}
-
-	pr_info("initialized: timeout=%d sec (nowayout=%d)\n",
-		timeout, nowayout);
-
-	return 0;
-}
-
-/**
- *	bfin_wdt_remove - Initialize module
- *
- *	Unregisters the misc device.  Actual device
- *	deinitialization is handled by bfin_wdt_close().
- */
-static int bfin_wdt_remove(struct platform_device *pdev)
-{
-	misc_deregister(&bfin_wdt_miscdev);
-	return 0;
-}
-
-/**
- *	bfin_wdt_shutdown - Soft Shutdown Handler
- *
- *	Handles the soft shutdown event.
- */
-static void bfin_wdt_shutdown(struct platform_device *pdev)
-{
-	stampit();
-
-	bfin_wdt_stop();
-}
-
-static struct platform_device *bfin_wdt_device;
-
-static struct platform_driver bfin_wdt_driver = {
-	.probe     = bfin_wdt_probe,
-	.remove    = bfin_wdt_remove,
-	.shutdown  = bfin_wdt_shutdown,
-	.suspend   = bfin_wdt_suspend,
-	.resume    = bfin_wdt_resume,
-	.driver    = {
-		.name  = WATCHDOG_NAME,
-	},
-};
-
-/**
- *	bfin_wdt_init - Initialize module
- *
- *	Checks the module params and registers the platform device & driver.
- *	Real work is in the platform probe function.
- */
-static int __init bfin_wdt_init(void)
-{
-	int ret;
-
-	stampit();
-
-	/* Check that the timeout value is within range */
-	if (bfin_wdt_set_timeout(timeout))
-		return -EINVAL;
-
-	/* Since this is an on-chip device and needs no board-specific
-	 * resources, we'll handle all the platform device stuff here.
-	 */
-	ret = platform_driver_register(&bfin_wdt_driver);
-	if (ret) {
-		pr_err("unable to register driver\n");
-		return ret;
-	}
-
-	bfin_wdt_device = platform_device_register_simple(WATCHDOG_NAME,
-								-1, NULL, 0);
-	if (IS_ERR(bfin_wdt_device)) {
-		pr_err("unable to register device\n");
-		platform_driver_unregister(&bfin_wdt_driver);
-		return PTR_ERR(bfin_wdt_device);
-	}
-
-	return 0;
-}
-
-/**
- *	bfin_wdt_exit - Deinitialize module
- *
- *	Back out the platform device & driver steps.  Real work is in the
- *	platform remove function.
- */
-static void __exit bfin_wdt_exit(void)
-{
-	platform_device_unregister(bfin_wdt_device);
-	platform_driver_unregister(&bfin_wdt_driver);
-}
-
-module_init(bfin_wdt_init);
-module_exit(bfin_wdt_exit);
-
-MODULE_AUTHOR("Michele d'Amico, Mike Frysinger <vapier@gentoo.org>");
-MODULE_DESCRIPTION("Blackfin Watchdog Device Driver");
-MODULE_LICENSE("GPL");
-
-module_param(timeout, uint, 0);
-MODULE_PARM_DESC(timeout,
-	"Watchdog timeout in seconds. (1<=timeout<=((2^32)/SCLK), default="
-		__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
-
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout,
-	"Watchdog cannot be stopped once started (default="
-		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-- 
2.7.4
