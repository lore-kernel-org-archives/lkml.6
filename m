Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeCPHXG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:23:06 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:4026
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753119AbeCPHRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:35 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 10/28] i2c: Remove Blackfin I2C bus support
Date: Fri, 16 Mar 2018 15:08:08 +0800
Message-ID: <1521184106-24475-8-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(478600001)(106002)(336012)(7696005)(51416003)(4326008)(106466001)(305945005)(2351001)(6666003)(6916009)(6306002)(2906002)(5660300001)(59450400001)(76176011)(2950100002)(8936002)(246002)(50226002)(186003)(26005)(50466002)(48376002)(966005)(8676002)(72206003)(316002)(86362001)(47776003)(36756003)(107886003)(7636002)(356003)(16586007)(77096007)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1481;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC016;1:GDcXGp9DoWk2nS1FIFzPd4jdyrsUERX4uadf17ux1/RGzPZRo32ZklhTqW0zbs9XNcmPcquz1vY2MxCp6GdnBx+q/CwflQ1cGOC+eim/7Btrw3EAubtL+IeiTRzWewfT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e37ceef5-9c74-4d0f-d3b6-08d58b0dfc7e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY1PR03MB1481;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1481;3:602tklQbfH1+/rOzWA7ZOHo3VxR/NM9bKUA6hecGel8zd/l7l3sGlydd7oRDkYoFKQEq9G9fsGvjIlJYULbdZqiVv6A6se/C3h5+UzZldLtp36jZwl4gkgK+eQhFvNBf0GWO+43VxNTUai5ADYjDkCeJHF7UCRX+sQy3kT0rCqzH4gt0pD9OcIf3EnrwHR+gHk+iqjK+SxDBwywiLdqw0hhtsYrfKDPI20Q5nVBrMsYSIMqWeBLfzAKknjDE9V8ZUK7ZBqBcoAkCx3DMkv9BMXsM/HfoqWT7XfAhRmJMM2svu7kko9O0I55pfuLPD1xKZKKS7uPcXynZz4MYdl6uMA==;25:nqM9T4w8NVSBif1+nixAfbDrzyq/rr1jo1aJQWnNHgIwC7JyE4Nyhr7nkMTmxLIWQgChHOdDcHEHmk/wrrNKjWWAgA9mJn+woC4mQ3h2hLOAb5dEbIxvlWtL6gx84MvnQZiR0YmKwJiQMb7bKVnBRbK9Swn24zI7cFcm98lpX/mb5+CNrK+LPiNxTH+X2MYZ5Ic6VuGyIW2rdyIlqmIRkyEAa3HTkA/J2oL1PyVdaeGBsWOTN8oCjexCSde1GtGRgPCfUgvSqzN9gQ3hfYWRonJpPoK0U8cK8nBVmpl6qj0KNn6YkRqm/GgJXBEwqSng8xpkwZVaQxnyxosVh7SO7Q==;31:cCudFZMQqPj/IcCK6yKpzNdYontfzVu9gyxR7iUWh9aZDsM2Rxd4G1MwfdVLxDCSRG1Tq4ubn9qg7SsZwER6cU+UBZhyZwbIDzay3vegJ/YkoqMbqXVnAQZSiWiz+kBTaQRYcDW9Qd6MtuyAYUfAebe11g+Hyg0+pglmdR49ArER/GEqQNxiLtIERcVzaK/Q+N9F6DlMeqKjZvziyHziF4o6mFacsZNGg/4tscZ4QDQ=
X-MS-TrafficTypeDiagnostic: BY1PR03MB1481:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1481;20:FY2Rs1QRF2t3tHB3WAsvolo1JTdTr7dGRsh6vutupd2gercNdwHmkAblvaJ9q24fkJvReWPFDZLIRBbDvDaPyMcraiaYysmD4anEhHH6Rol+UkADkIGB4a7CZI+zr/zuviH2jSyXuMy+B8A/IRbjKD2KMccQIJ6owwwZ1q4ktOGGGSg1G1pUO4+oAif0SjJmtibnpVxC1ghDyb34HjSBESmSN8vNWXkNOVu3CbJTlpqHbUTGNF7I/btd8iHDICHr+mctO/9N/sKldEMDXNjeE5oDA+/bu8D+8/qXOxNQJ8B8XkvddTQ0cgz73H40s3BgYrCckc0GxADUvyOd0neCov0xMKic0oMky4bj3GMcX98e81qQtD8xL0q9MjVA9O6cq9LOHTOA9Aa1n8n2o4Ks8g/NG6nCQdzsIX5YVUvqzC2E9aCjH1O+/r5chFsIkHj5ySKw6z2aWZ1qSD7PcgEAZMvnKskXa/2zCTfxjZb+8ooy7qThJCK6tNk1lLgv+aWH;4:hxUrc7Wo2XFK8heG2UsW/IdQtP99wZg7MZVDrK6Hi6HlVyM4BBdn8Iw3enmf7KTRMpXecSu4pdtv5IZMr/ty3bofdSSSXQt7OWfMHKogCEEeekzu8fMjaaUwqgHIco2b4fpj1hObCMFzTEbaeA6N2zXCs2AoVw/fUFEYneGLXQ24i2QE5BtEufKi/FAVtwIiu+fqmMo4fNA/maql8YR/QyKHEy5txX5ugoMPhLlap9sAUPbpNiyFLo1Jp4/cNe11fIOpTu+4seeLpRKZHydIJOu1W6igAk/nJafbcbaN2vHsu1Ofcbl9Gek1FRK/S/Z1
X-Microsoft-Antispam-PRVS: <BY1PR03MB148145ADAE218BA6D5F8C488E0D70@BY1PR03MB1481.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BY1PR03MB1481;BCL:0;PCL:0;RULEID:;SRVR:BY1PR03MB1481;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1481;23:U0pWPwUAPLSvEjVO1qfa3thVrDAHTKT/sFBhMKHhJ?=
 =?us-ascii?Q?KQ7llnZnM/4JKm6UU4yH3G2BJ5NdU9FpQs1to9FxFrh2F0iO4BUa8Ee/W79e?=
 =?us-ascii?Q?e4EWjYRQbHhme+bT7JELap+pBLIJBmNImBS0zP+U7d4pvNzG3nCoGHWOiFXW?=
 =?us-ascii?Q?VXdpab0SK6cCntVSRNPvn2ctFEZ728/M0iOj4WUUQil4ixih34eLsYpEVNxh?=
 =?us-ascii?Q?YaT/mcDC7H5jiG+LkbNJO2YZK4xOk6UqTPwk1oK9koTBKmzJB7TseXwssfbC?=
 =?us-ascii?Q?ErJu++p+zdNCmE1/pHdiwrN7hkrQo/W5Vy07g/onWWglrcTT5ybwUgC7hoXp?=
 =?us-ascii?Q?z5HQlx1qvpUSXmSe/QfXchk0ydxp3l08cfB3dH/kmYNubR+EH8BxJUNhqVXE?=
 =?us-ascii?Q?ZyAZ/uFv5B86mesLR1NwCxjRPZTc3BQ8L+7qw1rnxR4Co779faH1c5IIFJew?=
 =?us-ascii?Q?iuzdmv/tJr9EKEZ9Lh40ru+dsCdHBuTFVzMy0k1y/XBGD7J0Iv+0zhn7euYH?=
 =?us-ascii?Q?hpAIQ2R62nyWdewDxXxcidHgDdjiGXBMz8EGuZXmQWXsB6aN0ma8WsA8+Jos?=
 =?us-ascii?Q?MLMC0drcHGbVPfdheA6bkmJUe2DuItYrd7MAtj6Kd7AdYTwaU9VyKZ67+DKw?=
 =?us-ascii?Q?XROivwdK9XELMAelEPdjWa7zEbHDAKT91r9ophDLWXC8tnjNi30xBYll+yK9?=
 =?us-ascii?Q?KFNCGofEzyZHKTDXYi8k7MqI3pMptu3zgP+tMETa8ojZIFP59ze/WPOBIsx1?=
 =?us-ascii?Q?2WRTvLt9mIbhtpI9ZaSb0F+JS6LZYiW7s+gaCM7NszDFh3DgWwMQiO5wcQ+o?=
 =?us-ascii?Q?utO4SSAzeSIQeH6cpvYLMnMd5AM8+fO5ohQpoDPVc8k+XM3+ELOlbCVulvY5?=
 =?us-ascii?Q?lef9Wakn69fIBsfK/kBy62rpq0QtLHCaKiYegHTZDrMlBcS4pOFgKc4DoDCw?=
 =?us-ascii?Q?iaaez7Kj6FDdeKAuhpcRV587+9Wbhn1c8sxrlk6cTmkORwJ3qj2QwmxbIGhq?=
 =?us-ascii?Q?5F4MTw7VPHJPcxB481lpDC5je+8v/PoE8810bec1mpYaou1M89srWll5bmEw?=
 =?us-ascii?Q?sCwSU8=3D?=
X-Microsoft-Antispam-Message-Info: 2vyVzXB/gKtP7S0HWefUDWqsHOZbFutJWATJ1kvGduMRb6O8X6fMIfF6qewedRXNz4hvAJ7at7t/ZbLRaXmOplsf+tFlboJnEnURxGMgsjzUQVxiQtwuPX2Jl5JcnV72BfJDR5okDutOfL48lTFRocLzVvZBSekTiNQbuXY2qk0zj62MaXzSm6OHmZYWIfdL
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1481;6:WGUuhH6yFfeD6RBwjaHVU1toC3ls+kQlJ138rzy6Z04tBpiEv1w7mZLZvbzPD2r2HwlS/qsmiz+ELWhLdK/qk7UxA0PhVI58ehr48BR9BvpHLivQ78BfGSVXo3JqXw1jySZYiHzeRYdSvq08sWZICn3MK6umxO6r9TZ4ato2gmUE2UUQRfI7wgkDmrwbAoNFvcp3k2rgRowI8dOkUIrhjI3atSVUVB7iXu8NbtpAQUgR0pnPWS1yBvKTMF7lhfeVrYhf1OlTU5mdLsBnhzccyxTAevaTOza7OnJyaKbGIEUkZoWKaoit5+Qdu5bNHOQLo67b1Gg72bS7kLCYTa+ToLTjDtihl3uqVpxEWIz64Co=;5:+jVfjRoQWEi2uPvFMv4YhMlwLkNYj3QaL4VJdIlGr7EexJFY5arDWBKIRWGnCLAmbadC6oTPQBavPPrIUNW6KNzMedE4j1aixwmcuLD0EqogblO7Yr//sMcldqT8DZiAGuTrIPRnTjl7N287pZjKR8z9Y3kaoyEeUVtWiqzTPVo=;24:DJcN7UG4pSxDlmJhwMrT1mNU74tfw4diPMBpA58jnVNVhEBumJcO0ReVaiTy2iOiadzOkL3BLBFg2IYI92D88XtF7NqqAyl6nSOG2sOUFPw=;7:9mhpa0YCTrU9ZXVzP37sIqhCkEUTepQ3ZH9TZNrpCW1x5XJJpWoiEc58NQcrcQQh4jHo+np+1OckK08RDxWz4NAvMIxIAgBA5/5wJTyoCJFrG70qdiPd8aHInXnMqLNvMsDVN83meB45c9sr+Y0zRO1lAJLBnpcigtTq6s0Z2Ww/SvP55D0QGeG78ma4rHN3TLn/uHHE61kwBoPevdbRHuscAZCj0Tb6hGVcA3B6soYbmb5YD4yFyb5s9l8lBA5U
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:32.5275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ceef5-9c74-4d0f-d3b6-08d58b0dfc7e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1481
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin I2C bus support
---
 drivers/i2c/busses/Kconfig        |  18 -
 drivers/i2c/busses/Makefile       |   1 -
 drivers/i2c/busses/i2c-bfin-twi.c | 737 --------------------------------------
 3 files changed, 756 deletions(-)
 delete mode 100644 drivers/i2c/busses/i2c-bfin-twi.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e2954fb..8ffe2bc 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -445,24 +445,6 @@ config I2C_BRCMSTB
 
 	  If you do not need I2C interface, say N.
 
-config I2C_BLACKFIN_TWI
-	tristate "Blackfin TWI I2C support"
-	depends on BLACKFIN
-	depends on !BF561 && !BF531 && !BF532 && !BF533
-	help
-	  This is the I2C bus driver for Blackfin on-chip TWI interface.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-bfin-twi.
-
-config I2C_BLACKFIN_TWI_CLK_KHZ
-	int "Blackfin TWI I2C clock (kHz)"
-	depends on I2C_BLACKFIN_TWI
-	range 21 400
-	default 50
-	help
-	  The unit of the TWI clock is kHz.
-
 config I2C_CADENCE
 	tristate "Cadence I2C Controller"
 	depends on ARCH_ZYNQ || ARM64 || XTENSA
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 2ce8576..9e475a5 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
 obj-$(CONFIG_I2C_BCM_IPROC)	+= i2c-bcm-iproc.o
-obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
 obj-$(CONFIG_I2C_CADENCE)	+= i2c-cadence.o
 obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
deleted file mode 100644
index ff33431..0000000
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ /dev/null
@@ -1,737 +0,0 @@
-/*
- * Blackfin On-Chip Two Wire Interface Driver
- *
- * Copyright 2005-2007 Analog Devices Inc.
- *
- * Enter bugs at http://blackfin.uclinux.org/
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/mm.h>
-#include <linux/timer.h>
-#include <linux/spinlock.h>
-#include <linux/completion.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-
-#include <asm/irq.h>
-#include <asm/portmux.h>
-#include <asm/bfin_twi.h>
-
-/* SMBus mode*/
-#define TWI_I2C_MODE_STANDARD		1
-#define TWI_I2C_MODE_STANDARDSUB	2
-#define TWI_I2C_MODE_COMBINED		3
-#define TWI_I2C_MODE_REPEAT		4
-
-static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
-					unsigned short twi_int_status)
-{
-	unsigned short mast_stat = read_MASTER_STAT(iface);
-
-	if (twi_int_status & XMTSERV) {
-		if (iface->writeNum <= 0) {
-			/* start receive immediately after complete sending in
-			 * combine mode.
-			 */
-			if (iface->cur_mode == TWI_I2C_MODE_COMBINED)
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) | MDIR);
-			else if (iface->manual_stop)
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) | STOP);
-			else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-				iface->cur_msg + 1 < iface->msg_num) {
-				if (iface->pmsg[iface->cur_msg + 1].flags &
-					I2C_M_RD)
-					write_MASTER_CTL(iface,
-						read_MASTER_CTL(iface) |
-						MDIR);
-				else
-					write_MASTER_CTL(iface,
-						read_MASTER_CTL(iface) &
-						~MDIR);
-			}
-		}
-		/* Transmit next data */
-		while (iface->writeNum > 0 &&
-			(read_FIFO_STAT(iface) & XMTSTAT) != XMT_FULL) {
-			write_XMT_DATA8(iface, *(iface->transPtr++));
-			iface->writeNum--;
-		}
-	}
-	if (twi_int_status & RCVSERV) {
-		while (iface->readNum > 0 &&
-			(read_FIFO_STAT(iface) & RCVSTAT)) {
-			/* Receive next data */
-			*(iface->transPtr) = read_RCV_DATA8(iface);
-			if (iface->cur_mode == TWI_I2C_MODE_COMBINED) {
-				/* Change combine mode into sub mode after
-				 * read first data.
-				 */
-				iface->cur_mode = TWI_I2C_MODE_STANDARDSUB;
-				/* Get read number from first byte in block
-				 * combine mode.
-				 */
-				if (iface->readNum == 1 && iface->manual_stop)
-					iface->readNum = *iface->transPtr + 1;
-			}
-			iface->transPtr++;
-			iface->readNum--;
-		}
-
-		if (iface->readNum == 0) {
-			if (iface->manual_stop) {
-				/* Temporary workaround to avoid possible bus stall -
-				 * Flush FIFO before issuing the STOP condition
-				 */
-				read_RCV_DATA16(iface);
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) | STOP);
-			} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-					iface->cur_msg + 1 < iface->msg_num) {
-				if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
-					write_MASTER_CTL(iface,
-						read_MASTER_CTL(iface) | MDIR);
-				else
-					write_MASTER_CTL(iface,
-						read_MASTER_CTL(iface) & ~MDIR);
-			}
-		}
-	}
-	if (twi_int_status & MERR) {
-		write_INT_MASK(iface, 0);
-		write_MASTER_STAT(iface, 0x3e);
-		write_MASTER_CTL(iface, 0);
-		iface->result = -EIO;
-
-		if (mast_stat & LOSTARB)
-			dev_dbg(&iface->adap.dev, "Lost Arbitration\n");
-		if (mast_stat & ANAK)
-			dev_dbg(&iface->adap.dev, "Address Not Acknowledged\n");
-		if (mast_stat & DNAK)
-			dev_dbg(&iface->adap.dev, "Data Not Acknowledged\n");
-		if (mast_stat & BUFRDERR)
-			dev_dbg(&iface->adap.dev, "Buffer Read Error\n");
-		if (mast_stat & BUFWRERR)
-			dev_dbg(&iface->adap.dev, "Buffer Write Error\n");
-
-		/* Faulty slave devices, may drive SDA low after a transfer
-		 * finishes. To release the bus this code generates up to 9
-		 * extra clocks until SDA is released.
-		 */
-
-		if (read_MASTER_STAT(iface) & SDASEN) {
-			int cnt = 9;
-			do {
-				write_MASTER_CTL(iface, SCLOVR);
-				udelay(6);
-				write_MASTER_CTL(iface, 0);
-				udelay(6);
-			} while ((read_MASTER_STAT(iface) & SDASEN) && cnt--);
-
-			write_MASTER_CTL(iface, SDAOVR | SCLOVR);
-			udelay(6);
-			write_MASTER_CTL(iface, SDAOVR);
-			udelay(6);
-			write_MASTER_CTL(iface, 0);
-		}
-
-		/* If it is a quick transfer, only address without data,
-		 * not an err, return 1.
-		 */
-		if (iface->cur_mode == TWI_I2C_MODE_STANDARD &&
-			iface->transPtr == NULL &&
-			(twi_int_status & MCOMP) && (mast_stat & DNAK))
-			iface->result = 1;
-
-		complete(&iface->complete);
-		return;
-	}
-	if (twi_int_status & MCOMP) {
-		if (twi_int_status & (XMTSERV | RCVSERV) &&
-			(read_MASTER_CTL(iface) & MEN) == 0 &&
-			(iface->cur_mode == TWI_I2C_MODE_REPEAT ||
-			iface->cur_mode == TWI_I2C_MODE_COMBINED)) {
-			iface->result = -1;
-			write_INT_MASK(iface, 0);
-			write_MASTER_CTL(iface, 0);
-		} else if (iface->cur_mode == TWI_I2C_MODE_COMBINED) {
-			if (iface->readNum == 0) {
-				/* set the read number to 1 and ask for manual
-				 * stop in block combine mode
-				 */
-				iface->readNum = 1;
-				iface->manual_stop = 1;
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) | (0xff << 6));
-			} else {
-				/* set the readd number in other
-				 * combine mode.
-				 */
-				write_MASTER_CTL(iface,
-					(read_MASTER_CTL(iface) &
-					(~(0xff << 6))) |
-					(iface->readNum << 6));
-			}
-			/* remove restart bit and enable master receive */
-			write_MASTER_CTL(iface,
-				read_MASTER_CTL(iface) & ~RSTART);
-		} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-				iface->cur_msg + 1 < iface->msg_num) {
-			iface->cur_msg++;
-			iface->transPtr = iface->pmsg[iface->cur_msg].buf;
-			iface->writeNum = iface->readNum =
-				iface->pmsg[iface->cur_msg].len;
-			/* Set Transmit device address */
-			write_MASTER_ADDR(iface,
-				iface->pmsg[iface->cur_msg].addr);
-			if (iface->pmsg[iface->cur_msg].flags & I2C_M_RD)
-				iface->read_write = I2C_SMBUS_READ;
-			else {
-				iface->read_write = I2C_SMBUS_WRITE;
-				/* Transmit first data */
-				if (iface->writeNum > 0) {
-					write_XMT_DATA8(iface,
-						*(iface->transPtr++));
-					iface->writeNum--;
-				}
-			}
-
-			if (iface->pmsg[iface->cur_msg].len <= 255) {
-				write_MASTER_CTL(iface,
-					(read_MASTER_CTL(iface) &
-					(~(0xff << 6))) |
-					(iface->pmsg[iface->cur_msg].len << 6));
-				iface->manual_stop = 0;
-			} else {
-				write_MASTER_CTL(iface,
-					(read_MASTER_CTL(iface) |
-					(0xff << 6)));
-				iface->manual_stop = 1;
-			}
-			/* remove restart bit before last message */
-			if (iface->cur_msg + 1 == iface->msg_num)
-				write_MASTER_CTL(iface,
-					read_MASTER_CTL(iface) & ~RSTART);
-		} else {
-			iface->result = 1;
-			write_INT_MASK(iface, 0);
-			write_MASTER_CTL(iface, 0);
-		}
-		complete(&iface->complete);
-	}
-}
-
-/* Interrupt handler */
-static irqreturn_t bfin_twi_interrupt_entry(int irq, void *dev_id)
-{
-	struct bfin_twi_iface *iface = dev_id;
-	unsigned long flags;
-	unsigned short twi_int_status;
-
-	spin_lock_irqsave(&iface->lock, flags);
-	while (1) {
-		twi_int_status = read_INT_STAT(iface);
-		if (!twi_int_status)
-			break;
-		/* Clear interrupt status */
-		write_INT_STAT(iface, twi_int_status);
-		bfin_twi_handle_interrupt(iface, twi_int_status);
-	}
-	spin_unlock_irqrestore(&iface->lock, flags);
-	return IRQ_HANDLED;
-}
-
-/*
- * One i2c master transfer
- */
-static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
-				struct i2c_msg *msgs, int num)
-{
-	struct bfin_twi_iface *iface = adap->algo_data;
-	struct i2c_msg *pmsg;
-	int rc = 0;
-
-	if (!(read_CONTROL(iface) & TWI_ENA))
-		return -ENXIO;
-
-	if (read_MASTER_STAT(iface) & BUSBUSY)
-		return -EAGAIN;
-
-	iface->pmsg = msgs;
-	iface->msg_num = num;
-	iface->cur_msg = 0;
-
-	pmsg = &msgs[0];
-	if (pmsg->flags & I2C_M_TEN) {
-		dev_err(&adap->dev, "10 bits addr not supported!\n");
-		return -EINVAL;
-	}
-
-	if (iface->msg_num > 1)
-		iface->cur_mode = TWI_I2C_MODE_REPEAT;
-	iface->manual_stop = 0;
-	iface->transPtr = pmsg->buf;
-	iface->writeNum = iface->readNum = pmsg->len;
-	iface->result = 0;
-	init_completion(&(iface->complete));
-	/* Set Transmit device address */
-	write_MASTER_ADDR(iface, pmsg->addr);
-
-	/* FIFO Initiation. Data in FIFO should be
-	 *  discarded before start a new operation.
-	 */
-	write_FIFO_CTL(iface, 0x3);
-	write_FIFO_CTL(iface, 0);
-
-	if (pmsg->flags & I2C_M_RD)
-		iface->read_write = I2C_SMBUS_READ;
-	else {
-		iface->read_write = I2C_SMBUS_WRITE;
-		/* Transmit first data */
-		if (iface->writeNum > 0) {
-			write_XMT_DATA8(iface, *(iface->transPtr++));
-			iface->writeNum--;
-		}
-	}
-
-	/* clear int stat */
-	write_INT_STAT(iface, MERR | MCOMP | XMTSERV | RCVSERV);
-
-	/* Interrupt mask . Enable XMT, RCV interrupt */
-	write_INT_MASK(iface, MCOMP | MERR | RCVSERV | XMTSERV);
-
-	if (pmsg->len <= 255)
-		write_MASTER_CTL(iface, pmsg->len << 6);
-	else {
-		write_MASTER_CTL(iface, 0xff << 6);
-		iface->manual_stop = 1;
-	}
-
-	/* Master enable */
-	write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
-		(iface->msg_num > 1 ? RSTART : 0) |
-		((iface->read_write == I2C_SMBUS_READ) ? MDIR : 0) |
-		((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 100) ? FAST : 0));
-
-	while (!iface->result) {
-		if (!wait_for_completion_timeout(&iface->complete,
-			adap->timeout)) {
-			iface->result = -1;
-			dev_err(&adap->dev, "master transfer timeout\n");
-		}
-	}
-
-	if (iface->result == 1)
-		rc = iface->cur_msg + 1;
-	else
-		rc = iface->result;
-
-	return rc;
-}
-
-/*
- * Generic i2c master transfer entrypoint
- */
-static int bfin_twi_master_xfer(struct i2c_adapter *adap,
-				struct i2c_msg *msgs, int num)
-{
-	return bfin_twi_do_master_xfer(adap, msgs, num);
-}
-
-/*
- * One I2C SMBus transfer
- */
-int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
-			unsigned short flags, char read_write,
-			u8 command, int size, union i2c_smbus_data *data)
-{
-	struct bfin_twi_iface *iface = adap->algo_data;
-	int rc = 0;
-
-	if (!(read_CONTROL(iface) & TWI_ENA))
-		return -ENXIO;
-
-	if (read_MASTER_STAT(iface) & BUSBUSY)
-		return -EAGAIN;
-
-	iface->writeNum = 0;
-	iface->readNum = 0;
-
-	/* Prepare datas & select mode */
-	switch (size) {
-	case I2C_SMBUS_QUICK:
-		iface->transPtr = NULL;
-		iface->cur_mode = TWI_I2C_MODE_STANDARD;
-		break;
-	case I2C_SMBUS_BYTE:
-		if (data == NULL)
-			iface->transPtr = NULL;
-		else {
-			if (read_write == I2C_SMBUS_READ)
-				iface->readNum = 1;
-			else
-				iface->writeNum = 1;
-			iface->transPtr = &data->byte;
-		}
-		iface->cur_mode = TWI_I2C_MODE_STANDARD;
-		break;
-	case I2C_SMBUS_BYTE_DATA:
-		if (read_write == I2C_SMBUS_READ) {
-			iface->readNum = 1;
-			iface->cur_mode = TWI_I2C_MODE_COMBINED;
-		} else {
-			iface->writeNum = 1;
-			iface->cur_mode = TWI_I2C_MODE_STANDARDSUB;
-		}
-		iface->transPtr = &data->byte;
-		break;
-	case I2C_SMBUS_WORD_DATA:
-		if (read_write == I2C_SMBUS_READ) {
-			iface->readNum = 2;
-			iface->cur_mode = TWI_I2C_MODE_COMBINED;
-		} else {
-			iface->writeNum = 2;
-			iface->cur_mode = TWI_I2C_MODE_STANDARDSUB;
-		}
-		iface->transPtr = (u8 *)&data->word;
-		break;
-	case I2C_SMBUS_PROC_CALL:
-		iface->writeNum = 2;
-		iface->readNum = 2;
-		iface->cur_mode = TWI_I2C_MODE_COMBINED;
-		iface->transPtr = (u8 *)&data->word;
-		break;
-	case I2C_SMBUS_BLOCK_DATA:
-		if (read_write == I2C_SMBUS_READ) {
-			iface->readNum = 0;
-			iface->cur_mode = TWI_I2C_MODE_COMBINED;
-		} else {
-			iface->writeNum = data->block[0] + 1;
-			iface->cur_mode = TWI_I2C_MODE_STANDARDSUB;
-		}
-		iface->transPtr = data->block;
-		break;
-	case I2C_SMBUS_I2C_BLOCK_DATA:
-		if (read_write == I2C_SMBUS_READ) {
-			iface->readNum = data->block[0];
-			iface->cur_mode = TWI_I2C_MODE_COMBINED;
-		} else {
-			iface->writeNum = data->block[0];
-			iface->cur_mode = TWI_I2C_MODE_STANDARDSUB;
-		}
-		iface->transPtr = (u8 *)&data->block[1];
-		break;
-	default:
-		return -1;
-	}
-
-	iface->result = 0;
-	iface->manual_stop = 0;
-	iface->read_write = read_write;
-	iface->command = command;
-	init_completion(&(iface->complete));
-
-	/* FIFO Initiation. Data in FIFO should be discarded before
-	 * start a new operation.
-	 */
-	write_FIFO_CTL(iface, 0x3);
-	write_FIFO_CTL(iface, 0);
-
-	/* clear int stat */
-	write_INT_STAT(iface, MERR | MCOMP | XMTSERV | RCVSERV);
-
-	/* Set Transmit device address */
-	write_MASTER_ADDR(iface, addr);
-
-	switch (iface->cur_mode) {
-	case TWI_I2C_MODE_STANDARDSUB:
-		write_XMT_DATA8(iface, iface->command);
-		write_INT_MASK(iface, MCOMP | MERR |
-			((iface->read_write == I2C_SMBUS_READ) ?
-			RCVSERV : XMTSERV));
-
-		if (iface->writeNum + 1 <= 255)
-			write_MASTER_CTL(iface, (iface->writeNum + 1) << 6);
-		else {
-			write_MASTER_CTL(iface, 0xff << 6);
-			iface->manual_stop = 1;
-		}
-		/* Master enable */
-		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
-			((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ>100) ? FAST : 0));
-		break;
-	case TWI_I2C_MODE_COMBINED:
-		write_XMT_DATA8(iface, iface->command);
-		write_INT_MASK(iface, MCOMP | MERR | RCVSERV | XMTSERV);
-
-		if (iface->writeNum > 0)
-			write_MASTER_CTL(iface, (iface->writeNum + 1) << 6);
-		else
-			write_MASTER_CTL(iface, 0x1 << 6);
-		/* Master enable */
-		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN | RSTART |
-			((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ>100) ? FAST : 0));
-		break;
-	default:
-		write_MASTER_CTL(iface, 0);
-		if (size != I2C_SMBUS_QUICK) {
-			/* Don't access xmit data register when this is a
-			 * read operation.
-			 */
-			if (iface->read_write != I2C_SMBUS_READ) {
-				if (iface->writeNum > 0) {
-					write_XMT_DATA8(iface,
-						*(iface->transPtr++));
-					if (iface->writeNum <= 255)
-						write_MASTER_CTL(iface,
-							iface->writeNum << 6);
-					else {
-						write_MASTER_CTL(iface,
-							0xff << 6);
-						iface->manual_stop = 1;
-					}
-					iface->writeNum--;
-				} else {
-					write_XMT_DATA8(iface, iface->command);
-					write_MASTER_CTL(iface, 1 << 6);
-				}
-			} else {
-				if (iface->readNum > 0 && iface->readNum <= 255)
-					write_MASTER_CTL(iface,
-						iface->readNum << 6);
-				else if (iface->readNum > 255) {
-					write_MASTER_CTL(iface, 0xff << 6);
-					iface->manual_stop = 1;
-				} else
-					break;
-			}
-		}
-		write_INT_MASK(iface, MCOMP | MERR |
-			((iface->read_write == I2C_SMBUS_READ) ?
-			RCVSERV : XMTSERV));
-
-		/* Master enable */
-		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
-			((iface->read_write == I2C_SMBUS_READ) ? MDIR : 0) |
-			((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 100) ? FAST : 0));
-		break;
-	}
-
-	while (!iface->result) {
-		if (!wait_for_completion_timeout(&iface->complete,
-			adap->timeout)) {
-			iface->result = -1;
-			dev_err(&adap->dev, "smbus transfer timeout\n");
-		}
-	}
-
-	rc = (iface->result >= 0) ? 0 : -1;
-
-	return rc;
-}
-
-/*
- * Generic I2C SMBus transfer entrypoint
- */
-int bfin_twi_smbus_xfer(struct i2c_adapter *adap, u16 addr,
-			unsigned short flags, char read_write,
-			u8 command, int size, union i2c_smbus_data *data)
-{
-	return bfin_twi_do_smbus_xfer(adap, addr, flags,
-			read_write, command, size, data);
-}
-
-/*
- * Return what the adapter supports
- */
-static u32 bfin_twi_functionality(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL |
-	       I2C_FUNC_I2C | I2C_FUNC_SMBUS_I2C_BLOCK;
-}
-
-static const struct i2c_algorithm bfin_twi_algorithm = {
-	.master_xfer   = bfin_twi_master_xfer,
-	.smbus_xfer    = bfin_twi_smbus_xfer,
-	.functionality = bfin_twi_functionality,
-};
-
-#ifdef CONFIG_PM_SLEEP
-static int i2c_bfin_twi_suspend(struct device *dev)
-{
-	struct bfin_twi_iface *iface = dev_get_drvdata(dev);
-
-	iface->saved_clkdiv = read_CLKDIV(iface);
-	iface->saved_control = read_CONTROL(iface);
-
-	free_irq(iface->irq, iface);
-
-	/* Disable TWI */
-	write_CONTROL(iface, iface->saved_control & ~TWI_ENA);
-
-	return 0;
-}
-
-static int i2c_bfin_twi_resume(struct device *dev)
-{
-	struct bfin_twi_iface *iface = dev_get_drvdata(dev);
-
-	int rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
-		0, to_platform_device(dev)->name, iface);
-	if (rc) {
-		dev_err(dev, "Can't get IRQ %d !\n", iface->irq);
-		return -ENODEV;
-	}
-
-	/* Resume TWI interface clock as specified */
-	write_CLKDIV(iface, iface->saved_clkdiv);
-
-	/* Resume TWI */
-	write_CONTROL(iface, iface->saved_control);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(i2c_bfin_twi_pm,
-			 i2c_bfin_twi_suspend, i2c_bfin_twi_resume);
-#define I2C_BFIN_TWI_PM_OPS	(&i2c_bfin_twi_pm)
-#else
-#define I2C_BFIN_TWI_PM_OPS	NULL
-#endif
-
-static int i2c_bfin_twi_probe(struct platform_device *pdev)
-{
-	struct bfin_twi_iface *iface;
-	struct i2c_adapter *p_adap;
-	struct resource *res;
-	int rc;
-	unsigned int clkhilow;
-
-	iface = devm_kzalloc(&pdev->dev, sizeof(struct bfin_twi_iface),
-			GFP_KERNEL);
-	if (!iface) {
-		dev_err(&pdev->dev, "Cannot allocate memory\n");
-		return -ENOMEM;
-	}
-
-	spin_lock_init(&(iface->lock));
-
-	/* Find and map our resources */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iface->regs_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(iface->regs_base)) {
-		dev_err(&pdev->dev, "Cannot map IO\n");
-		return PTR_ERR(iface->regs_base);
-	}
-
-	iface->irq = platform_get_irq(pdev, 0);
-	if (iface->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ specified\n");
-		return -ENOENT;
-	}
-
-	p_adap = &iface->adap;
-	p_adap->nr = pdev->id;
-	strlcpy(p_adap->name, pdev->name, sizeof(p_adap->name));
-	p_adap->algo = &bfin_twi_algorithm;
-	p_adap->algo_data = iface;
-	p_adap->class = I2C_CLASS_DEPRECATED;
-	p_adap->dev.parent = &pdev->dev;
-	p_adap->timeout = 5 * HZ;
-	p_adap->retries = 3;
-
-	rc = peripheral_request_list(
-			dev_get_platdata(&pdev->dev),
-			"i2c-bfin-twi");
-	if (rc) {
-		dev_err(&pdev->dev, "Can't setup pin mux!\n");
-		return -EBUSY;
-	}
-
-	rc = devm_request_irq(&pdev->dev, iface->irq, bfin_twi_interrupt_entry,
-		0, pdev->name, iface);
-	if (rc) {
-		dev_err(&pdev->dev, "Can't get IRQ %d !\n", iface->irq);
-		rc = -ENODEV;
-		goto out_error;
-	}
-
-	/* Set TWI internal clock as 10MHz */
-	write_CONTROL(iface, ((get_sclk() / 1000 / 1000 + 5) / 10) & 0x7F);
-
-	/*
-	 * We will not end up with a CLKDIV=0 because no one will specify
-	 * 20kHz SCL or less in Kconfig now. (5 * 1000 / 20 = 250)
-	 */
-	clkhilow = ((10 * 1000 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ) + 1) / 2;
-
-	/* Set Twi interface clock as specified */
-	write_CLKDIV(iface, (clkhilow << 8) | clkhilow);
-
-	/* Enable TWI */
-	write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
-
-	rc = i2c_add_numbered_adapter(p_adap);
-	if (rc < 0)
-		goto out_error;
-
-	platform_set_drvdata(pdev, iface);
-
-	dev_info(&pdev->dev, "Blackfin BF5xx on-chip I2C TWI Controller, "
-		"regs_base@%p\n", iface->regs_base);
-
-	return 0;
-
-out_error:
-	peripheral_free_list(dev_get_platdata(&pdev->dev));
-	return rc;
-}
-
-static int i2c_bfin_twi_remove(struct platform_device *pdev)
-{
-	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
-
-	i2c_del_adapter(&(iface->adap));
-	peripheral_free_list(dev_get_platdata(&pdev->dev));
-
-	return 0;
-}
-
-static struct platform_driver i2c_bfin_twi_driver = {
-	.probe		= i2c_bfin_twi_probe,
-	.remove		= i2c_bfin_twi_remove,
-	.driver		= {
-		.name	= "i2c-bfin-twi",
-		.pm	= I2C_BFIN_TWI_PM_OPS,
-	},
-};
-
-static int __init i2c_bfin_twi_init(void)
-{
-	return platform_driver_register(&i2c_bfin_twi_driver);
-}
-
-static void __exit i2c_bfin_twi_exit(void)
-{
-	platform_driver_unregister(&i2c_bfin_twi_driver);
-}
-
-subsys_initcall(i2c_bfin_twi_init);
-module_exit(i2c_bfin_twi_exit);
-
-MODULE_AUTHOR("Bryan Wu, Sonic Zhang");
-MODULE_DESCRIPTION("Blackfin BF5xx on-chip I2C TWI Controller Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:i2c-bfin-twi");
-- 
2.7.4
