Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeCPHXO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:23:14 -0400
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:56960
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753086AbeCPHR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:26 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 05/28] rtc: Remove Blackfin RTC support
Date: Fri, 16 Mar 2018 15:08:03 +0800
Message-ID: <1521184106-24475-3-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(376002)(2980300002)(438002)(189003)(199004)(426003)(86362001)(8676002)(2906002)(575784001)(512794004)(966005)(478600001)(50226002)(36756003)(356003)(48376002)(50466002)(4326008)(7636002)(305945005)(8936002)(5660300001)(106466001)(2351001)(2950100002)(6916009)(72206003)(51416003)(6306002)(7696005)(246002)(106002)(6666003)(77096007)(186003)(26005)(47776003)(107886003)(316002)(76176011)(16586007)(59450400001)(336012)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2610;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD025;1:Qwe13NzzzUHugjAMTZI7pbAPTv1m/jY3UNWXh1ye2CMEZuRcxie34eeBYkY+ovNbuROLFkDSTBe+2DiggvTB54a0vOVcc5xkbD4H968kIaTq2xoiCWaq8ZRsr2G0NC7K
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc133ae8-93c9-40b4-a853-08d58b0df749
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB2610;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2610;3:3wKvzSy1TG9gimVezoPpwjZAXMZ2j3iuNV51+GFWThVqowU7AzXfROfA35em95NaTYaRNTUrHcV753UOy1/RzRCZ36Cx9Bxn5O7geCITVYo8r/gTd6VDA20VC4XnRKCEbNSgiVlOaXcR2xqH3SHI42Kh1X0FAIv0LUDAMYzC+YTITvPhZQxSTL6PAehWvuZ1wlg1YP5ducl+gaHlUUAJ5Gl5l93Go0T2ZkvLMT5QVQD3B36wKuMrmJW1UdhDJF8XESN6ojBgbEN4gpJxmi+CkPwrJddm60/jM7b8IH0MT/UWfZ0hitfieBh1Aog6PIQr9VL7Q5SmMSSfSkoyXEt12g==;25:IBkdhD9bf7r3sPQeTFabjvXhfsh7AAoxrarmc0LLR+f9oPRxPDYf+jCsqZmih3XjrCxIOnFK8PVV+zdh/3iswa5bqGlKenFJT8U05xDHKFvnJ1FUeZ7dhIbkz5ZCh1udkEF+vb3AkW559IyASRaLoFyBu0R6pWc+A/NoPwu3627lXWNpb89co8byi54TfYj+Bmil6tEZItgmayv/rnMEggdUoOyoHKMVuonJfFXyw7q98MQDHDjluagwmT2Aan5N20svLHobM+hHTzEsk41bYXQLoM1i4H4IW92r02+n6Q28aRjeSmRweGvEHE7RSUGa8cGE0rNgPALgjiUMQQtNBg==;31:CjQSxoCiD1qa6613jMMAn5VB5rZvIwCxQJ8DKQ9TizYiYcEi9YFOI5hfAYEg3PjgcYretCMoQyA5VjyN3VNI8/r29D0YOSesEyQ8AFWzXvnp1jR3JvioF7HKHVdJ2hAh0XqtrJKaQqaXnHIunbGaBUra6jvTgthp7mXEQJZvULD7fBbaS1h1oCwOwo8GilNPiACCRdFKUUdWaCr4j1RMkW+mQtAxyJR82i6xK6EjyUM=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2610:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2610;20:70h54/R3CsLX2GCrQLu1flg1wMD7J7NS1cFDRwWrnI4VA/Djtnwk6vNyVWKziR/b+vY1obuUFlTWXwSMpkxP3T+c0EX9H8pQeKkWKvVjF1fY0YKSZIWeqDyMpyvqxUsk8QMR7nTUzD3FG4NFuchKnvcQXXwI9oNcDth9i77xoLRHdCQ+24VhU1JvdnhJWVED+UGxwWuWuCJa/TvYUdHi0GPACuXDaLbAVZ9Bn4k9VWITrbMa0z2oD9yR9+igl3yDd0ewQNviM+C6eFkCLOyqCJN3ahbTL2f4+jWgN9JNWCi77+yj+oHy3eXEJpGWmDOnSy6trGj7c+28gELUpF02kebpR/q6qKZjJ1p/TczkEViUiQySuwjQOb95DxrK2EJSQrE959Aa0MIeqRCQ+mIENsWc5ISviq4zFZ90n8kxutw5kwU/u5BODFcgd0GfCQLxDOUzmhj6heKWLDOQS2lxZVbgU5rzg292cXq2DmSy0CWz/Z3ODnpwptBrhlBlirJ6;4:yzDPWW0H9dBeur7kx9Jn7KgiDxhhnUkjp9CJhCp5ley6sYMiQWpNh93LRbn87FR/KuppSoL1hPNBhfXxbNdy1VEsGYIwDNePUKuFMyWz/stZicbLOGZ2KYO03xvSoem0rMjXMrrtXqJXvj+1+H/rsGWZdeTd8ygdb7X2+6KsxJcQ7QJ7mRqW52uq9KDvG7qqnLLD/LP/o4wl62jTldjBaova+RQ0xLP0oOHoihfsWTBlJPQE30WEQ4DIFyKHN7hdt5dGBQ/zcYh72cF9g3kwKcaU+1tmfTY7BwdwAO5SpELL+Phmb3zKKcGYtbF7ro0W
X-Microsoft-Antispam-PRVS: <BN6PR03MB26105824D0C73CE1F037B55FE0D70@BN6PR03MB2610.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2610;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2610;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2610;23:VtFf3K38M+24e0rtOSEBQIogIf+zHyik79kUK7oYU?=
 =?us-ascii?Q?3dfSHwzOeSXxMzfH55tNu/+O7tX+cvFR7q6EzV7kb7ZmEokw+vFR8ShgnEV2?=
 =?us-ascii?Q?IH+uvaQiqQpdKlJIvsVjdG/pnpLLz7Xxk4tVqUnPhEsWnOrDsFNaYn+MxCjq?=
 =?us-ascii?Q?gZSdl4ONrmiF1QQgwUhqFaCSLdSlkYCuM1w5+B9T6nzcaACKxt3Ss5Z/2GhN?=
 =?us-ascii?Q?0B+CHAqUhRjfmgsthlr3nVn+lDVor7tZ16pHAoaX/sSW1jUZWfMdrWDbayFv?=
 =?us-ascii?Q?8jw/Lc6JCNN9GNnTjmMbI27gwWaNtmrI/yc5uMxZ3VdH6552yEv+baqOsgf0?=
 =?us-ascii?Q?FtinNI6NPv/+li6C8QV8SxwZS78KDSEKFA8JqwaRyyEXUF5jtmjy6n9Os9gP?=
 =?us-ascii?Q?pSWwaurNzfhonCPszjrYEllXRq9aVi5xdZPWhP15ArluEF4HfF/Dl889LaVb?=
 =?us-ascii?Q?PUKVG++DHar/II0HTCY/jPz8PcXvYqLqvkc7zQiULCGIm/PoN8r6Hk2r96aG?=
 =?us-ascii?Q?X6hmzrDdx9c5mb8lqa0UF3enoc8qzCI+yAIeHCKFXcouDGn0j4q27Q2i8grE?=
 =?us-ascii?Q?g8z+9m7PKG4iGrDfqtpdGK4WcSlJyBUsPCZMawHCclsMM3RMy+8kspK2iqMw?=
 =?us-ascii?Q?BP2mDpecU1g+Io9jc4yCUWnAD3ePCF0rX47/wzYqMFw3IvBVgFG2Qd1k/f40?=
 =?us-ascii?Q?JLhCVni4aDcNmzX5xWcHzwuLyU1dbOgPHaZRFcbLWTYDTsocDN9HYM6RSMhz?=
 =?us-ascii?Q?08nCrfNdGACeMpbC8X0pIIB4IPJ3qI73ffTAHFhsl+U94Re8FKZ92Y4qZ9NW?=
 =?us-ascii?Q?LNX7syNhm6Y3Z3VVYJCcs2fet6ijg84iVk9jIoWLn/B1ugEL5KYNhjbs0Xgd?=
 =?us-ascii?Q?Qa/CKrRVtMfHcVsmgoiWVXemyBbt7N9s3qeSb+hdtEvijAO7qTQUCouOcU59?=
 =?us-ascii?Q?QjrDMURDtli8/Bs0yIvoP8E1I1BD83Lcih0EkIz3HG9Nn93MX/IHlVhkHqOT?=
 =?us-ascii?Q?5zmlULrTDrwD8sotJ0gIrFeuzgD2Bko7akX/XKBjW3f0kNcATOnPfsowBzdq?=
 =?us-ascii?Q?08s1lzXE3Kx2Rwgz2Rb0sc9Yq2zYnWx90lcNAvKqPjdIq/JHxZD0KGIRaWN2?=
 =?us-ascii?Q?TwQtIxi3PE=3D?=
X-Microsoft-Antispam-Message-Info: h02eBn7GfkZ3vkIz1jQDGorzFSDlYuWhXSF0W3Pg00JXMR6+XZgRIJCPrG0jzYbjsIm4gHTdS/pbMdCfsbWa12qftGOUfRuOzINIMAJCr020qqSNOhElEFFfaVcp3hylsCjWtU62bg8fr1z5n1CfC2ZWWgTPru1P+kk4nA7kq+dyuv38mvNGBjeKkJRajjKA
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2610;6:u95xvDDXI0KBKWL/lauA3GGfVcTnRz5q6VOsP4amX4QEZChewPrQoZVrmo/vAZ52o95WG77B1w2EdmWmmRfmtKzQQrYp9z0GGcKKrhugPJ/lsTe3X9rp3aAbBhXBvRyc1fS6yZlrhnvbckuWK28zt6O1JuAK53llTzN7gz+8NLVz43q8Zxnx1k/l2TH4ABZwLOwYzDVf6SjE4u8W7J8QpyhEx8eTNwgiYRbuDSgSrHZcCVxL8yMyoaYsq0D4WtDVFeFkYJGRYe799gZhrI52bxLpxCaIqtF/9i16A7YKm/bkPjd1vtiAWUx8kh+BmZOYrh6zf8eADe30MhqHcDimn4X0UOEkOBwUkI0Ie8bzy2o=;5:VnQHP/gCHd4jRmjIoTRLEBeNTMwVbfjr1Xi6YE1uNHlZS4PHFEE5rUojlPvPn2I7ngUXODS53U6DgnvlKo7QeLJ3AP7Kjtp3XjDpkLTJ4izaNeXFCnwmOJrj9p5t4bFzwtjI0XJTYm34tFC62y1KewpXzizhOkN2TPjbz7jOesw=;24:ZN2BolEySydgwhlo7MzqT4F0rrTYUUf8olMLbRhsRZ6gFr3cC5+UsdT9BnZ11mnvv9r1pigOpjsZ6YkLwn+SDvIBaunhN/8piPIVFlZkX6Q=;7:l4kqEmIooLX1IXOkukTjCMjRt1SjiaY7WIqd6QmxMs/xI5BP4iogxcTG9J3fvuhI+bt4GWPaLZKIDJQEBLReWlrdDAHkHz8nfc5n4ayfYHBa+s5KjZ+1p32+hmEiC0vPCmjaGMJ8gzSF4j1ThRk3rqcB410wf7sP+xCoLpqSnyusGSIHowRWkVbaTiNDywXnyWOCno29SvGCF+uXGpqwRGAOtDGuAvPvkt1GaF3b6Stom5Fbu1Gs+awtIdfHYM+w
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:24.1336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc133ae8-93c9-40b4-a853-08d58b0df749
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2610
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin RTC support
---
 drivers/rtc/Kconfig    |  10 --
 drivers/rtc/Makefile   |   1 -
 drivers/rtc/rtc-bfin.c | 448 -------------------------------------------------
 3 files changed, 459 deletions(-)
 delete mode 100644 drivers/rtc/rtc-bfin.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8ab5f0a5..622d0ed2 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1434,16 +1434,6 @@ config RTC_DRV_AU1XXX
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-au1xxx.
 
-config RTC_DRV_BFIN
-	tristate "Blackfin On-Chip RTC"
-	depends on BLACKFIN && !BF561
-	help
-	  If you say yes here you will get support for the
-	  Blackfin On-Chip Real Time Clock.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-bfin.
-
 config RTC_DRV_RS5C313
 	tristate "Ricoh RS5C313"
 	depends on SH_LANDISK
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 4fbf87e4..014c8a8 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
-obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
 obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
deleted file mode 100644
index 15344b7..0000000
--- a/drivers/rtc/rtc-bfin.c
+++ /dev/null
@@ -1,448 +0,0 @@
-/*
- * Blackfin On-Chip Real Time Clock Driver
- *  Supports BF51x/BF52x/BF53[123]/BF53[467]/BF54x
- *
- * Copyright 2004-2010 Analog Devices Inc.
- *
- * Enter bugs at http://blackfin.uclinux.org/
- *
- * Licensed under the GPL-2 or later.
- */
-
-/* The biggest issue we deal with in this driver is that register writes are
- * synced to the RTC frequency of 1Hz.  So if you write to a register and
- * attempt to write again before the first write has completed, the new write
- * is simply discarded.  This can easily be troublesome if userspace disables
- * one event (say periodic) and then right after enables an event (say alarm).
- * Since all events are maintained in the same interrupt mask register, if
- * we wrote to it to disable the first event and then wrote to it again to
- * enable the second event, that second event would not be enabled as the
- * write would be discarded and things quickly fall apart.
- *
- * To keep this delay from significantly degrading performance (we, in theory,
- * would have to sleep for up to 1 second every time we wanted to write a
- * register), we only check the write pending status before we start to issue
- * a new write.  We bank on the idea that it doesn't matter when the sync
- * happens so long as we don't attempt another write before it does.  The only
- * time userspace would take this penalty is when they try and do multiple
- * operations right after another ... but in this case, they need to take the
- * sync penalty, so we should be OK.
- *
- * Also note that the RTC_ISTAT register does not suffer this penalty; its
- * writes to clear status registers complete immediately.
- */
-
-/* It may seem odd that there is no SWCNT code in here (which would be exposed
- * via the periodic interrupt event, or PIE).  Since the Blackfin RTC peripheral
- * runs in units of seconds (N/HZ) but the Linux framework runs in units of HZ
- * (2^N HZ), there is no point in keeping code that only provides 1 HZ PIEs.
- * The same exact behavior can be accomplished by using the update interrupt
- * event (UIE).  Maybe down the line the RTC peripheral will suck less in which
- * case we can re-introduce PIE support.
- */
-
-#include <linux/bcd.h>
-#include <linux/completion.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/rtc.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-
-#include <asm/blackfin.h>
-
-#define dev_dbg_stamp(dev) dev_dbg(dev, "%s:%i: here i am\n", __func__, __LINE__)
-
-struct bfin_rtc {
-	struct rtc_device *rtc_dev;
-	struct rtc_time rtc_alarm;
-	u16 rtc_wrote_regs;
-};
-
-/* Bit values for the ISTAT / ICTL registers */
-#define RTC_ISTAT_WRITE_COMPLETE  0x8000
-#define RTC_ISTAT_WRITE_PENDING   0x4000
-#define RTC_ISTAT_ALARM_DAY       0x0040
-#define RTC_ISTAT_24HR            0x0020
-#define RTC_ISTAT_HOUR            0x0010
-#define RTC_ISTAT_MIN             0x0008
-#define RTC_ISTAT_SEC             0x0004
-#define RTC_ISTAT_ALARM           0x0002
-#define RTC_ISTAT_STOPWATCH       0x0001
-
-/* Shift values for RTC_STAT register */
-#define DAY_BITS_OFF    17
-#define HOUR_BITS_OFF   12
-#define MIN_BITS_OFF    6
-#define SEC_BITS_OFF    0
-
-/* Some helper functions to convert between the common RTC notion of time
- * and the internal Blackfin notion that is encoded in 32bits.
- */
-static inline u32 rtc_time_to_bfin(unsigned long now)
-{
-	u32 sec  = (now % 60);
-	u32 min  = (now % (60 * 60)) / 60;
-	u32 hour = (now % (60 * 60 * 24)) / (60 * 60);
-	u32 days = (now / (60 * 60 * 24));
-	return (sec  << SEC_BITS_OFF) +
-	       (min  << MIN_BITS_OFF) +
-	       (hour << HOUR_BITS_OFF) +
-	       (days << DAY_BITS_OFF);
-}
-static inline unsigned long rtc_bfin_to_time(u32 rtc_bfin)
-{
-	return (((rtc_bfin >> SEC_BITS_OFF)  & 0x003F)) +
-	       (((rtc_bfin >> MIN_BITS_OFF)  & 0x003F) * 60) +
-	       (((rtc_bfin >> HOUR_BITS_OFF) & 0x001F) * 60 * 60) +
-	       (((rtc_bfin >> DAY_BITS_OFF)  & 0x7FFF) * 60 * 60 * 24);
-}
-static inline void rtc_bfin_to_tm(u32 rtc_bfin, struct rtc_time *tm)
-{
-	rtc_time_to_tm(rtc_bfin_to_time(rtc_bfin), tm);
-}
-
-/**
- *	bfin_rtc_sync_pending - make sure pending writes have complete
- *
- * Wait for the previous write to a RTC register to complete.
- * Unfortunately, we can't sleep here as that introduces a race condition when
- * turning on interrupt events.  Consider this:
- *  - process sets alarm
- *  - process enables alarm
- *  - process sleeps while waiting for rtc write to sync
- *  - interrupt fires while process is sleeping
- *  - interrupt acks the event by writing to ISTAT
- *  - interrupt sets the WRITE PENDING bit
- *  - interrupt handler finishes
- *  - process wakes up, sees WRITE PENDING bit set, goes to sleep
- *  - interrupt fires while process is sleeping
- * If anyone can point out the obvious solution here, i'm listening :).  This
- * shouldn't be an issue on an SMP or preempt system as this function should
- * only be called with the rtc lock held.
- *
- * Other options:
- *  - disable PREN so the sync happens at 32.768kHZ ... but this changes the
- *    inc rate for all RTC registers from 1HZ to 32.768kHZ ...
- *  - use the write complete IRQ
- */
-/*
-static void bfin_rtc_sync_pending_polled(void)
-{
-	while (!(bfin_read_RTC_ISTAT() & RTC_ISTAT_WRITE_COMPLETE))
-		if (!(bfin_read_RTC_ISTAT() & RTC_ISTAT_WRITE_PENDING))
-			break;
-	bfin_write_RTC_ISTAT(RTC_ISTAT_WRITE_COMPLETE);
-}
-*/
-static DECLARE_COMPLETION(bfin_write_complete);
-static void bfin_rtc_sync_pending(struct device *dev)
-{
-	dev_dbg_stamp(dev);
-	while (bfin_read_RTC_ISTAT() & RTC_ISTAT_WRITE_PENDING)
-		wait_for_completion_timeout(&bfin_write_complete, HZ * 5);
-	dev_dbg_stamp(dev);
-}
-
-/**
- *	bfin_rtc_reset - set RTC to sane/known state
- *
- * Initialize the RTC.  Enable pre-scaler to scale RTC clock
- * to 1Hz and clear interrupt/status registers.
- */
-static void bfin_rtc_reset(struct device *dev, u16 rtc_ictl)
-{
-	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-	dev_dbg_stamp(dev);
-	bfin_rtc_sync_pending(dev);
-	bfin_write_RTC_PREN(0x1);
-	bfin_write_RTC_ICTL(rtc_ictl);
-	bfin_write_RTC_ALARM(0);
-	bfin_write_RTC_ISTAT(0xFFFF);
-	rtc->rtc_wrote_regs = 0;
-}
-
-/**
- *	bfin_rtc_interrupt - handle interrupt from RTC
- *
- * Since we handle all RTC events here, we have to make sure the requested
- * interrupt is enabled (in RTC_ICTL) as the event status register (RTC_ISTAT)
- * always gets updated regardless of the interrupt being enabled.  So when one
- * even we care about (e.g. stopwatch) goes off, we don't want to turn around
- * and say that other events have happened as well (e.g. second).  We do not
- * have to worry about pending writes to the RTC_ICTL register as interrupts
- * only fire if they are enabled in the RTC_ICTL register.
- */
-static irqreturn_t bfin_rtc_interrupt(int irq, void *dev_id)
-{
-	struct device *dev = dev_id;
-	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long events = 0;
-	bool write_complete = false;
-	u16 rtc_istat, rtc_istat_clear, rtc_ictl, bits;
-
-	dev_dbg_stamp(dev);
-
-	rtc_istat = bfin_read_RTC_ISTAT();
-	rtc_ictl = bfin_read_RTC_ICTL();
-	rtc_istat_clear = 0;
-
-	bits = RTC_ISTAT_WRITE_COMPLETE;
-	if (rtc_istat & bits) {
-		rtc_istat_clear |= bits;
-		write_complete = true;
-		complete(&bfin_write_complete);
-	}
-
-	bits = (RTC_ISTAT_ALARM | RTC_ISTAT_ALARM_DAY);
-	if (rtc_ictl & bits) {
-		if (rtc_istat & bits) {
-			rtc_istat_clear |= bits;
-			events |= RTC_AF | RTC_IRQF;
-		}
-	}
-
-	bits = RTC_ISTAT_SEC;
-	if (rtc_ictl & bits) {
-		if (rtc_istat & bits) {
-			rtc_istat_clear |= bits;
-			events |= RTC_UF | RTC_IRQF;
-		}
-	}
-
-	if (events)
-		rtc_update_irq(rtc->rtc_dev, 1, events);
-
-	if (write_complete || events) {
-		bfin_write_RTC_ISTAT(rtc_istat_clear);
-		return IRQ_HANDLED;
-	} else
-		return IRQ_NONE;
-}
-
-static void bfin_rtc_int_set(u16 rtc_int)
-{
-	bfin_write_RTC_ISTAT(rtc_int);
-	bfin_write_RTC_ICTL(bfin_read_RTC_ICTL() | rtc_int);
-}
-static void bfin_rtc_int_clear(u16 rtc_int)
-{
-	bfin_write_RTC_ICTL(bfin_read_RTC_ICTL() & rtc_int);
-}
-static void bfin_rtc_int_set_alarm(struct bfin_rtc *rtc)
-{
-	/* Blackfin has different bits for whether the alarm is
-	 * more than 24 hours away.
-	 */
-	bfin_rtc_int_set(rtc->rtc_alarm.tm_yday == -1 ? RTC_ISTAT_ALARM : RTC_ISTAT_ALARM_DAY);
-}
-
-static int bfin_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
-{
-	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-
-	dev_dbg_stamp(dev);
-	if (enabled)
-		bfin_rtc_int_set_alarm(rtc);
-	else
-		bfin_rtc_int_clear(~(RTC_ISTAT_ALARM | RTC_ISTAT_ALARM_DAY));
-
-	return 0;
-}
-
-static int bfin_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-
-	dev_dbg_stamp(dev);
-
-	if (rtc->rtc_wrote_regs & 0x1)
-		bfin_rtc_sync_pending(dev);
-
-	rtc_bfin_to_tm(bfin_read_RTC_STAT(), tm);
-
-	return 0;
-}
-
-static int bfin_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-	int ret;
-	unsigned long now;
-
-	dev_dbg_stamp(dev);
-
-	ret = rtc_tm_to_time(tm, &now);
-	if (ret == 0) {
-		if (rtc->rtc_wrote_regs & 0x1)
-			bfin_rtc_sync_pending(dev);
-		bfin_write_RTC_STAT(rtc_time_to_bfin(now));
-		rtc->rtc_wrote_regs = 0x1;
-	}
-
-	return ret;
-}
-
-static int bfin_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-	dev_dbg_stamp(dev);
-	alrm->time = rtc->rtc_alarm;
-	bfin_rtc_sync_pending(dev);
-	alrm->enabled = !!(bfin_read_RTC_ICTL() & (RTC_ISTAT_ALARM | RTC_ISTAT_ALARM_DAY));
-	return 0;
-}
-
-static int bfin_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-{
-	struct bfin_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long rtc_alarm;
-
-	dev_dbg_stamp(dev);
-
-	if (rtc_tm_to_time(&alrm->time, &rtc_alarm))
-		return -EINVAL;
-
-	rtc->rtc_alarm = alrm->time;
-
-	bfin_rtc_sync_pending(dev);
-	bfin_write_RTC_ALARM(rtc_time_to_bfin(rtc_alarm));
-	if (alrm->enabled)
-		bfin_rtc_int_set_alarm(rtc);
-
-	return 0;
-}
-
-static int bfin_rtc_proc(struct device *dev, struct seq_file *seq)
-{
-#define yesno(x) ((x) ? "yes" : "no")
-	u16 ictl = bfin_read_RTC_ICTL();
-	dev_dbg_stamp(dev);
-	seq_printf(seq,
-		"alarm_IRQ\t: %s\n"
-		"wkalarm_IRQ\t: %s\n"
-		"seconds_IRQ\t: %s\n",
-		yesno(ictl & RTC_ISTAT_ALARM),
-		yesno(ictl & RTC_ISTAT_ALARM_DAY),
-		yesno(ictl & RTC_ISTAT_SEC));
-	return 0;
-#undef yesno
-}
-
-static const struct rtc_class_ops bfin_rtc_ops = {
-	.read_time     = bfin_rtc_read_time,
-	.set_time      = bfin_rtc_set_time,
-	.read_alarm    = bfin_rtc_read_alarm,
-	.set_alarm     = bfin_rtc_set_alarm,
-	.proc          = bfin_rtc_proc,
-	.alarm_irq_enable = bfin_rtc_alarm_irq_enable,
-};
-
-static int bfin_rtc_probe(struct platform_device *pdev)
-{
-	struct bfin_rtc *rtc;
-	struct device *dev = &pdev->dev;
-	int ret;
-	unsigned long timeout = jiffies + HZ;
-
-	dev_dbg_stamp(dev);
-
-	/* Allocate memory for our RTC struct */
-	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
-	if (unlikely(!rtc))
-		return -ENOMEM;
-	platform_set_drvdata(pdev, rtc);
-	device_init_wakeup(dev, 1);
-
-	/* Register our RTC with the RTC framework */
-	rtc->rtc_dev = devm_rtc_device_register(dev, pdev->name, &bfin_rtc_ops,
-						THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
-
-	/* Grab the IRQ and init the hardware */
-	ret = devm_request_irq(dev, IRQ_RTC, bfin_rtc_interrupt, 0,
-				pdev->name, dev);
-	if (unlikely(ret))
-		dev_err(&pdev->dev,
-			"unable to request IRQ; alarm won't work, "
-			"and writes will be delayed\n");
-
-	/* sometimes the bootloader touched things, but the write complete was not
-	 * enabled, so let's just do a quick timeout here since the IRQ will not fire ...
-	 */
-	while (bfin_read_RTC_ISTAT() & RTC_ISTAT_WRITE_PENDING)
-		if (time_after(jiffies, timeout))
-			break;
-	bfin_rtc_reset(dev, RTC_ISTAT_WRITE_COMPLETE);
-	bfin_write_RTC_SWCNT(0);
-
-	return 0;
-}
-
-static int bfin_rtc_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	bfin_rtc_reset(dev, 0);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int bfin_rtc_suspend(struct device *dev)
-{
-	dev_dbg_stamp(dev);
-
-	if (device_may_wakeup(dev)) {
-		enable_irq_wake(IRQ_RTC);
-		bfin_rtc_sync_pending(dev);
-	} else
-		bfin_rtc_int_clear(0);
-
-	return 0;
-}
-
-static int bfin_rtc_resume(struct device *dev)
-{
-	dev_dbg_stamp(dev);
-
-	if (device_may_wakeup(dev))
-		disable_irq_wake(IRQ_RTC);
-
-	/*
-	 * Since only some of the RTC bits are maintained externally in the
-	 * Vbat domain, we need to wait for the RTC MMRs to be synced into
-	 * the core after waking up.  This happens every RTC 1HZ.  Once that
-	 * has happened, we can go ahead and re-enable the important write
-	 * complete interrupt event.
-	 */
-	while (!(bfin_read_RTC_ISTAT() & RTC_ISTAT_SEC))
-		continue;
-	bfin_rtc_int_set(RTC_ISTAT_WRITE_COMPLETE);
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(bfin_rtc_pm_ops, bfin_rtc_suspend, bfin_rtc_resume);
-
-static struct platform_driver bfin_rtc_driver = {
-	.driver		= {
-		.name	= "rtc-bfin",
-		.pm	= &bfin_rtc_pm_ops,
-	},
-	.probe		= bfin_rtc_probe,
-	.remove		= bfin_rtc_remove,
-};
-
-module_platform_driver(bfin_rtc_driver);
-
-MODULE_DESCRIPTION("Blackfin On-Chip Real Time Clock Driver");
-MODULE_AUTHOR("Mike Frysinger <vapier@gentoo.org>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:rtc-bfin");
-- 
2.7.4
