Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeCPHUt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:20:49 -0400
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:31165
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753180AbeCPHR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:58 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 25/28] staging: Remove Blackfin iio trigger timer support
Date: Fri, 16 Mar 2018 15:08:23 +0800
Message-ID: <1521184106-24475-23-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(186003)(336012)(107886003)(86362001)(316002)(16586007)(575784001)(2906002)(106002)(426003)(6666003)(6916009)(8676002)(2950100002)(36756003)(8936002)(246002)(106466001)(72206003)(2351001)(305945005)(4326008)(50226002)(26005)(478600001)(76176011)(50466002)(5660300001)(7696005)(59450400001)(51416003)(48376002)(77096007)(7636002)(47776003)(356003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1484;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC001;1:E5HlobwM4M28MQRQ1i1oFOnmfalHKXXvovZI3HRUjkyRCgFFdyJvbkMzUwJWOOfGuv76Ap3rmgExlnYfC3abCov1uNTxjY98vU4H3ufpl6cinQI/QFfBxYNkrgLqZSAS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5cf78d2-8a1d-4d50-8d1e-08d58b0e0a25
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY1PR03MB1484;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1484;3:j8076Cyj0gxRenvxz8Kl7yqyhx9V5gUTuXilJv2i/k7/RNts8+er5OB0Eqm+2uEiHVU8dHEpumgTol93qS42tpGte/y0LhkvM21MY7Ezd2sC5O0MWag99iVVCHdec2fZqk1gYO2UrjECZAwvSKp4KNXz39vEBXTkKbdmE6rFMX9jLhyBr/7L8rbhELcGK5M8L1wuaXnKjsGC6C3/e4qkVSjADqEG28A3SPNvoyAa7g4DuNe3iywxN0vVEhoClMn9NPx+sD0bPy7IZKxEuJGOSteY6x0doJuRVOcatmOkh2SrsYtve3nDMht7MIT0dT6qktiv5lOpPBVWHq0MgHxKaA==;25:N4nGondgnUnKyqA+0sXnImQtkCHq75eOGel+sByapo91MPgDlKrHpq/FbdY8mzTmGQqruHL/qeJfB/KUltuiVcA1tUYgL1qxi65acXOVLFpQx0D4MYPah9+0+wRnQxGrNpahIdcNqm14pmCzOGDJIQQ2RuirwlH0YLETnKHt3TWgz2+E36vayESGuaysRwTFWVE8aznczIDrS1udLdBgGkk1fIp3vGvBeOb2KI1nte+gwCc4yc0xNDuv57LLMdf+a3Mgln3yFZ1snSjiKoE/hY9txJUbbr/WjqaBv74qKu0DLnjeAQz8tDgW69bkI/9k8ycvht/HgV36ueWc0WQ9nQ==;31:dzFARS85yz0yBmG8G1iZ3mM3lI0Xk5I+tMphYMBccItxvp90lQgtfafO8c3zlHCZu+13+5/rn0I+fvbn5gz0H9Na3fZlDcxeINerbWo1BAxaR3eLE9zfl0YZvL63GArROfjLE5Tt98ibQVhHCiFpIjd2UAM4hmrwgS1j8+qOEMTMnW2BOnNsbyjApllbuCcUYYoiRyeRCRKPvUSTI8dETbQ+8kLXB3v+RmBoP9Aseqg=
X-MS-TrafficTypeDiagnostic: BY1PR03MB1484:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1484;20:rCmcW9jFOsUY1A+LU/v3uEyCSlqEl5suVcXSU5YxGr8rtEG9djh7Sseubb85yBMjyDJOTRjmUuHeb65V+c5zadhNKcI7hgQNAtDIBIZ2hZbrDiwZ4Ebwz5stpWqj6ttWP9XBnnIn2bAdUacd58S8V8THb/4LAz95xQD/W99WXR2cFkRia36N9vi0K8+E2r52GDamuaWfwSq1jF0y8DY2t0m9olNw/dg68e8wtZ0M9poDD7TSYMmo7PGnCJ1aOoROcGmMgSYQqjB0SpMlbtpwX3gM5+U1kgtUi1B+qy6KWWmeejBbQ/zmxeiltArcmSaah76S4yFPTs3p97BjQUjg4lcXXRPZn30F//7HpRxQZ2OH8DWlTLs2K3Ib6NXPNv2hijTDcgT0ae77R/bMGqx/VZdgP8LveBa+/eAg0AV7qf+ZdWdubWXUTdu4tk4HI9nc3gbmwibDaC0iL1IkwDTIngzlf3PqDAxWam90S9GWwcyaoSN7pjmySiJ/q/linRkR;4:8aAIz0+mS/HVcD1nXZWvmOcUN4EkOIHCRZS4kpUJk9e8w+tzyuJ6hw4GsQ072vR7cuaj/dpKakItOBTV9+ADE1WQICZldpVz6jyYveK2IbypwvNk2Va8sS9RPnTUfUjsHhDFfWjwyNOvzlR+ABb3UIl2wmggd4y4BIDD4zh6Mw9y2JQ3JVSMGqMeCNvhHXv5F9LmDi8ns+icaLnt4L1Y85ShH9eDqlY5y1oQj3mKkQeEMihnPsUqGkFkkfzoRXoXU4BUCsKS67AFyNJmtYjN5V/9edvr7HygN+tkrxwrdnf0+Ni2rXbTcN11ITASfDrm
X-Microsoft-Antispam-PRVS: <BY1PR03MB1484BC1F36B14A989FB3965CE0D70@BY1PR03MB1484.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BY1PR03MB1484;BCL:0;PCL:0;RULEID:;SRVR:BY1PR03MB1484;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1484;23:5zaG6hVlmi3bB6+6xeauoBMGZIT1aWxGSgcpJzqwY?=
 =?us-ascii?Q?MnPdzA/Na6+jc3hhQQRj7s9Qzgu9EU2NL646EWcuRkUm36tbBDNHsoL6iXsP?=
 =?us-ascii?Q?Q1pWKAv5xBIeGESA71/3+y7c/LCSsHx6t0zEU3pocuRgd4ibW+k4X62dNy6y?=
 =?us-ascii?Q?n4E9Amsj8RK1terj2rPVJ68BPNshbfGQVf0NTPrV57CsO04PX1q6AIpe+Pns?=
 =?us-ascii?Q?k7SazSga3ywd0icVIvw40XxGZJ5TEAGq2HZsMsiz25uXsnbUYCZtV1ZSurW+?=
 =?us-ascii?Q?W1/WNYE3kmJnBhC+OsQEYILaQ0p4mOOWbG4N1OsISEz36d8p6T3LxJ38YVGs?=
 =?us-ascii?Q?ZBGUxrJp0CXip4M2nm4bd0w+R3PsQVHXyHGhqWxcB9wsLnDacbuYio+jxU0n?=
 =?us-ascii?Q?Ckm/F4BuxyEwxKAQcuARw3i5VFm7en6x3i/ilQLR/U+oBnCiQfWQZd2KxXRZ?=
 =?us-ascii?Q?ESj4Db2qk6/toe+ZDoFf8rGth244Wnz2D3E0SL0YmT8As2GvKjGlBc2D3vF+?=
 =?us-ascii?Q?CQzl4LV+EnHNUomTt0ZdbGyEv17qupwi3tOjwvxRHSXiAtQYZTNSSV5Wqdrm?=
 =?us-ascii?Q?oW22ebbbEr0JtXzEH52NVD6rXowcLK2mwTzr/ShbnIPrji7dOS/kVzcQVLkD?=
 =?us-ascii?Q?m15o5Lo0dBLoIrOvlWWmZyIH1d5wojbZkEN1abk891AfckEQjJgOzbbBNqt9?=
 =?us-ascii?Q?4oTlNZlCdmWim+jsIGtOnplQh/5GfxraQ2grCezNAUkyFEBZj3f7mkRu+0Mg?=
 =?us-ascii?Q?f2BSEvBA6gEP98aoZ6LJtGlEZIAW9/NIc4eFwUu7qjeKVA5/iXVPjrDBPhG3?=
 =?us-ascii?Q?3rOmYl1T2suBKA5n7rN1/OLnbPGF70GKTcr3PcW0AjwAcys3Itkjr7yLNmvC?=
 =?us-ascii?Q?wFR0pXiexOHz61IrPbpLLoxwlAK/3eOry/ZKCOBe3dRFi0urUXm4fHXdnGWH?=
 =?us-ascii?Q?zdq9UVe4w0ybJVhqaWYEuSCQIQhMfu/kI7QaB5VQBto0+BNv1vXwxars9I/P?=
 =?us-ascii?Q?slKjS2X8XKxxC04NBWw4ojvNTYXWKXYpRYNDNNF6oZ1kQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Cc7IKrxCPYOUC8j5Hb57HISxGsy43QeKZSNHioN85Gm8qCUXnsEe/aux4UObbo2A47M9nfUg0d2hIGX7kCsnV9XRFSPLeA0a1q6sZLCUd3LXoxNxB/EpwCQ0KkmJdD/BL9UcEVbfzC4zAhgIyxzOxNcM3TN1zEo5lpufaJ2h2FmmVd1fDvPqVA8mkfAm2t/6
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1484;6:yc4ZcmJkIQfT9BB+p139u11jmB96eR4I1Gw77MB1lh0poxAsdNPM1kTQu0MLpGAGqB57bzsZaydmUz++aXYDpjSLW8L9hQEheIunzRXSZVoTkoU3B+zJNE9zFXCdRwHGo+2/9Kpr3w/jmNP5+QfRvF7Tn7au+nxfTT21ToMybKdLo6ZDo7MdAGO+rKZqhLv+e3+//2MDPiR3algM/M8IpXX0UV7Xe5jGfLnk6jzTmdTP3izGMtkhexbVj3vmdB5GkCYzNs4edrUbckOXKwbedNJdeqdNFePpNuQHDB1OAUTgeT+Lku/5Xe1gqhYToPefatYdQTLG2MU/C8Bn4X8B2gwjiO85SngynTYkbygqreg=;5:AE9g2gnIffABKchYmS30vnIGzV2AgsLd0+P2eagsuzV6DIElAOssq3m3/4m39J1gfUwrP0m1FuAYD5wrzrg4MjC03YCFUdKoUrNrPDC48pN3xwSBIwWXV5MYKOfcvzNrVkR0+pIWM9H2EH5rvkD+pNcm37j1CsxStnHpW5FrWOI=;24:47On0FBW0i76icSvH/JskXdMIgXLyJrlSh0UwLSmWbSqNsSoA0AsRnfsd1yCcz3eWwgI1H6xQD4tPM8W83C1PzjTbTxGw6Hqj7xfWjvWC+Q=;7:Ye3POMP1X3bz368VddYYbrxUy44b3UcX+pwxdTKVLFJuTthciXnKvoMwv6t+SKGudMiMHj3FUnwXlRRFajquZfV6Keay7QTNN/+3CRWPMSii3dMV7+TrGr1ErlDFrk0rn5Knz+i3S0tFRglVDQAEMgnQ/TbTyh1xa1J9JM1InuFZDihh1M3zY3FxzBYjVMh1tXcXhF6CbalQcaFslcQ5E+b4GRp/7AtljCUIBBErwuvmrVk63u1cG/ooEoWWXXgZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:55.5865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cf78d2-8a1d-4d50-8d1e-08d58b0e0a25
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1484
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin iio trigger timer support
---
 drivers/staging/iio/Kconfig                       |   1 -
 drivers/staging/iio/Makefile                      |   1 -
 drivers/staging/iio/trigger/Kconfig               |  19 --
 drivers/staging/iio/trigger/Makefile              |   5 -
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 292 ----------------------
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h |  25 --
 6 files changed, 343 deletions(-)
 delete mode 100644 drivers/staging/iio/trigger/Kconfig
 delete mode 100644 drivers/staging/iio/trigger/Makefile
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 8abc1ab..bd94459 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -14,6 +14,5 @@ source "drivers/staging/iio/impedance-analyzer/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
-source "drivers/staging/iio/trigger/Kconfig"
 
 endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 455bffc..e99a375 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -13,4 +13,3 @@ obj-y += impedance-analyzer/
 obj-y += light/
 obj-y += meter/
 obj-y += resolver/
-obj-y += trigger/
diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
deleted file mode 100644
index 0b01d24..0000000
--- a/drivers/staging/iio/trigger/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-  #
-# Industrial I/O standalone triggers
-#
-comment "Triggers - standalone"
-
-if IIO_TRIGGER
-
-config IIO_BFIN_TMR_TRIGGER
-	tristate "Blackfin TIMER trigger"
-	depends on BLACKFIN
-	select BFIN_GPTIMERS
-	help
-	  Provides support for using a Blackfin timer as IIO triggers.
-	  If unsure, say N (but it's safe to say "Y").
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called iio-trig-bfin-timer.
-
-endif # IIO_TRIGGER
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
deleted file mode 100644
index 1300a21..0000000
--- a/drivers/staging/iio/trigger/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for triggers not associated with iio-devices
-#
-
-obj-$(CONFIG_IIO_BFIN_TMR_TRIGGER) += iio-trig-bfin-timer.o
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
deleted file mode 100644
index 71f11d7..0000000
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ /dev/null
@@ -1,292 +0,0 @@
-/*
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
-
-#include "iio-trig-bfin-timer.h"
-
-struct bfin_timer {
-	unsigned short id, bit;
-	unsigned long irqbit;
-	int irq;
-	int pin;
-};
-
-/*
- * this covers all hardware timer configurations on
- * all Blackfin derivatives out there today
- */
-
-static struct bfin_timer iio_bfin_timer_code[MAX_BLACKFIN_GPTIMERS] = {
-	{TIMER0_id,  TIMER0bit,  TIMER_STATUS_TIMIL0,  IRQ_TIMER0, P_TMR0},
-	{TIMER1_id,  TIMER1bit,  TIMER_STATUS_TIMIL1,  IRQ_TIMER1, P_TMR1},
-	{TIMER2_id,  TIMER2bit,  TIMER_STATUS_TIMIL2,  IRQ_TIMER2, P_TMR2},
-#if (MAX_BLACKFIN_GPTIMERS > 3)
-	{TIMER3_id,  TIMER3bit,  TIMER_STATUS_TIMIL3,  IRQ_TIMER3, P_TMR3},
-	{TIMER4_id,  TIMER4bit,  TIMER_STATUS_TIMIL4,  IRQ_TIMER4, P_TMR4},
-	{TIMER5_id,  TIMER5bit,  TIMER_STATUS_TIMIL5,  IRQ_TIMER5, P_TMR5},
-	{TIMER6_id,  TIMER6bit,  TIMER_STATUS_TIMIL6,  IRQ_TIMER6, P_TMR6},
-	{TIMER7_id,  TIMER7bit,  TIMER_STATUS_TIMIL7,  IRQ_TIMER7, P_TMR7},
-#endif
-#if (MAX_BLACKFIN_GPTIMERS > 8)
-	{TIMER8_id,  TIMER8bit,  TIMER_STATUS_TIMIL8,  IRQ_TIMER8, P_TMR8},
-	{TIMER9_id,  TIMER9bit,  TIMER_STATUS_TIMIL9,  IRQ_TIMER9, P_TMR9},
-	{TIMER10_id, TIMER10bit, TIMER_STATUS_TIMIL10, IRQ_TIMER10, P_TMR10},
-#if (MAX_BLACKFIN_GPTIMERS > 11)
-	{TIMER11_id, TIMER11bit, TIMER_STATUS_TIMIL11, IRQ_TIMER11, P_TMR11},
-#endif
-#endif
-};
-
-struct bfin_tmr_state {
-	struct iio_trigger	*trig;
-	struct bfin_timer	*t;
-	unsigned int		timer_num;
-	bool			output_enable;
-	unsigned int		duty;
-	int			irq;
-};
-
-static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
-{
-	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
-
-	if (get_gptimer_period(st->t->id) == 0)
-		return -EINVAL;
-
-	if (state)
-		enable_gptimers(st->t->bit);
-	else
-		disable_gptimers(st->t->bit);
-
-	return 0;
-}
-
-static ssize_t frequency_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
-{
-	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
-	unsigned int val;
-	bool enabled;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	if (val > 100000)
-		return -EINVAL;
-
-	enabled = get_enabled_gptimers() & st->t->bit;
-
-	if (enabled)
-		disable_gptimers(st->t->bit);
-
-	if (!val)
-		return count;
-
-	val = get_sclk() / val;
-	if (val <= 4 || val <= st->duty)
-		return -EINVAL;
-
-	set_gptimer_period(st->t->id, val);
-	set_gptimer_pwidth(st->t->id, val - st->duty);
-
-	if (enabled)
-		enable_gptimers(st->t->bit);
-
-	return count;
-}
-
-static ssize_t frequency_show(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
-	unsigned int period = get_gptimer_period(st->t->id);
-	unsigned long val;
-
-	if (!period)
-		val = 0;
-	else
-		val = get_sclk() / get_gptimer_period(st->t->id);
-
-	return sprintf(buf, "%lu\n", val);
-}
-
-static DEVICE_ATTR_RW(frequency);
-
-static struct attribute *iio_bfin_tmr_trigger_attrs[] = {
-	&dev_attr_frequency.attr,
-	NULL,
-};
-
-static const struct attribute_group iio_bfin_tmr_trigger_attr_group = {
-	.attrs = iio_bfin_tmr_trigger_attrs,
-};
-
-static const struct attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
-	&iio_bfin_tmr_trigger_attr_group,
-	NULL
-};
-
-static irqreturn_t iio_bfin_tmr_trigger_isr(int irq, void *devid)
-{
-	struct bfin_tmr_state *st = devid;
-
-	clear_gptimer_intr(st->t->id);
-	iio_trigger_poll(st->trig);
-
-	return IRQ_HANDLED;
-}
-
-static int iio_bfin_tmr_get_number(int irq)
-{
-	int i;
-
-	for (i = 0; i < MAX_BLACKFIN_GPTIMERS; i++)
-		if (iio_bfin_timer_code[i].irq == irq)
-			return i;
-
-	return -ENODEV;
-}
-
-static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
-	.set_trigger_state = iio_bfin_tmr_set_state,
-};
-
-static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
-{
-	struct iio_bfin_timer_trigger_pdata *pdata;
-	struct bfin_tmr_state *st;
-	unsigned int config;
-	int ret;
-
-	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
-	if (!st)
-		return -ENOMEM;
-
-	st->irq = platform_get_irq(pdev, 0);
-	if (st->irq < 0) {
-		dev_err(&pdev->dev, "No IRQs specified");
-		return st->irq;
-	}
-
-	ret = iio_bfin_tmr_get_number(st->irq);
-	if (ret < 0)
-		return ret;
-
-	st->timer_num = ret;
-	st->t = &iio_bfin_timer_code[st->timer_num];
-
-	st->trig = iio_trigger_alloc("bfintmr%d", st->timer_num);
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->ops = &iio_bfin_tmr_trigger_ops;
-	st->trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
-	iio_trigger_set_drvdata(st->trig, st);
-	ret = iio_trigger_register(st->trig);
-	if (ret)
-		goto out;
-
-	ret = request_irq(st->irq, iio_bfin_tmr_trigger_isr,
-			  0, st->trig->name, st);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"request IRQ-%d failed", st->irq);
-		goto out1;
-	}
-
-	config = PWM_OUT | PERIOD_CNT | IRQ_ENA;
-
-	pdata =	dev_get_platdata(&pdev->dev);
-	if (pdata && pdata->output_enable) {
-		unsigned long long val;
-
-		st->output_enable = true;
-
-		ret = peripheral_request(st->t->pin, st->trig->name);
-		if (ret)
-			goto out_free_irq;
-
-		val = (unsigned long long)get_sclk() * pdata->duty_ns;
-		do_div(val, NSEC_PER_SEC);
-		st->duty = val;
-
-		/**
-		 * The interrupt will be generated at the end of the period,
-		 * since we want the interrupt to be generated at end of the
-		 * pulse we invert both polarity and duty cycle, so that the
-		 * pulse will be generated directly before the interrupt.
-		 */
-		if (pdata->active_low)
-			config |= PULSE_HI;
-	} else {
-		st->duty = 1;
-		config |= OUT_DIS;
-	}
-
-	set_gptimer_config(st->t->id, config);
-
-	dev_info(&pdev->dev, "iio trigger Blackfin TMR%d, IRQ-%d",
-		 st->timer_num, st->irq);
-	platform_set_drvdata(pdev, st);
-
-	return 0;
-out_free_irq:
-	free_irq(st->irq, st);
-out1:
-	iio_trigger_unregister(st->trig);
-out:
-	iio_trigger_free(st->trig);
-	return ret;
-}
-
-static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
-{
-	struct bfin_tmr_state *st = platform_get_drvdata(pdev);
-
-	disable_gptimers(st->t->bit);
-	if (st->output_enable)
-		peripheral_free(st->t->pin);
-	free_irq(st->irq, st);
-	iio_trigger_unregister(st->trig);
-	iio_trigger_free(st->trig);
-
-	return 0;
-}
-
-static struct platform_driver iio_bfin_tmr_trigger_driver = {
-	.driver = {
-		.name = "iio_bfin_tmr_trigger",
-	},
-	.probe = iio_bfin_tmr_trigger_probe,
-	.remove = iio_bfin_tmr_trigger_remove,
-};
-
-module_platform_driver(iio_bfin_tmr_trigger_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Blackfin system timer based trigger for the iio subsystem");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:iio-trig-bfin-timer");
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h b/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
deleted file mode 100644
index fb05a2a..0000000
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __IIO_BFIN_TIMER_TRIGGER_H__
-#define __IIO_BFIN_TIMER_TRIGGER_H__
-
-/**
- * struct iio_bfin_timer_trigger_pdata - timer trigger platform data
- * @output_enable: Enable external trigger pulse generation.
- * @active_low: Whether the trigger pulse is active low.
- * @duty_ns: Length of the trigger pulse in nanoseconds.
- *
- * This struct is used to configure the output pulse generation of the blackfin
- * timer trigger. If output_enable is set to true an external trigger signal
- * will generated on the pin corresponding to the timer. This is useful for
- * converters which needs an external signal to start conversion. active_low and
- * duty_ns are used to configure the type of the trigger pulse. If output_enable
- * is set to false no external trigger pulse will be generated and active_low
- * and duty_ns are ignored.
- **/
-struct iio_bfin_timer_trigger_pdata {
-	bool output_enable;
-	bool active_low;
-	unsigned int duty_ns;
-};
-
-#endif
-- 
2.7.4
