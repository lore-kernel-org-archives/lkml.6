Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeCPHXL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:23:11 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:7438
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753100AbeCPHRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:30 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 06/28] mmc: Remove Blackfin SD host support
Date: Fri, 16 Mar 2018 15:08:04 +0800
Message-ID: <1521184106-24475-4-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(186003)(336012)(107886003)(86362001)(316002)(16586007)(2906002)(106002)(426003)(6666003)(6916009)(8676002)(2950100002)(36756003)(8936002)(246002)(106466001)(72206003)(2351001)(305945005)(4326008)(50226002)(26005)(478600001)(76176011)(50466002)(5660300001)(7696005)(59450400001)(51416003)(48376002)(77096007)(7636002)(47776003)(356003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1484;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD026;1:nkLqI3TQzhzjePy9GUBUCuZnP2mHT+5K2MIuWoh7XPywrPyZZOOTscxztmQq5HzJ/8b5hutXm0AETT4bQtKWY9TZE9rxskFsXP+H404AMi9uOA01mFMku0SP2ad4OW7h
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ee30a3-6f59-4bfc-9a7c-08d58b0df911
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY1PR03MB1484;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1484;3:bCsr+fU6hF2Ru2vv4sh1oZMFNvr2vNwiGJEoWYpGN1RjtQzraIXTWYOoF6IOQLdiKChm3LQTa+/nRxo1LeLWI6qPiZWH3k1iC8fkBUH0kFFlOkxAYu/4bSryRHjGRURQbhnZcyuJkjN7kDeZdAi5X04GzmeJGQTY2gF2y6lPsAnfop5ZW+4q46dhKBbH7DWX+kIxlKBJ8JpMZCU2J9eYMnQ6Tee6qbwjBjjlYRA9W2mlc7n9yD/At1OulQKzLbn/NHXLJbCWz9Xffoza2o3344gn8/pUI0V4v0cUpHWbtL8qgORBnWNV5pzisLjMCaDs1m4LI3ujtUleKP8ACvZ3hw==;25:jP50fke6e5QHmHBRqsBUBvcaDBST49qjofTvftkP+USOt0KYZ9m1+KbgsLn75sU/2sD/O98HyTIWAYHDP+we8r4XJAl+A2zW9wD/HJ+46FbS/nakCCS2gpXNei2c0+32AnNRxWTF75QOSiBqTj6Z2SkWYy8kHBKaCsUudOBGVIxMYfpYQ1KV62dKaYt+moRNuTvt8wDLssKk5ZLr6Ab12ndcIS9KiCHxZW+Xqv0NCVZVEbp/uv59Jk+T0vctiXEyC3i2Unphy3iWdip86fztK/7dTqI4Iy0A8NBeEGL8pBLhRoDY1oaMX5j/zTFzWUtXd9/KeKt67Vc9MEFzQN1dVg==;31:CdldUWa4jPrStb0jeIiCeJj3y09YinyyDz2uuH0GKtO2qgVdToHYDDCD7mCDo81KeTMKuWlPDeL4GIi4m1JbByLZs/8/Pj4pvSltKasMqdbmSW+lBJUnDy7ibeWVYuz9Ae6HPg6nb5/Xhti8NZ8lGBX/S38hjaJIaampPyMIGBt9DpeLI+rR9kL1Lt+fpv/AlYgEAs+GbYOtwjmCvHHTpUk4AJAs8JeNuR68jtltRUY=
X-MS-TrafficTypeDiagnostic: BY1PR03MB1484:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1484;20:hhDKnlJoqQsbQ79IFaJ+mSlcLzTbwtgGKfcEZqdZBntsLvCTHoNZCThhvo7Nq47KLBWymVerWzyKGaepL2OPsutw2qM36XUtffRmhlrYFq6aXuNilYe4E5ebReaQCQmlRuCDCO7Xsk+KkT9ucwnsIMs0SweidGhDjjq4yUOvlV4PzqNCqd0CIOHl1MzkJmyJpHcfe7AD6HjpcWyZ2O2RFJFbl80ZwfVvNqJoyLe9NbaXKB7xFlyhSrqNEvkEgadDT/5yGvJj2SuIESrygrz0kj6HTV0sb/n/VSgQXSP18zkwyyD49i2bZquwizjPeiovDxgCU7Cy64ncP773aSkmNQQ20Goyu3Tb1i9stM9CDbwViI+aiJMbwCOLEoWh392d7WYlFO+XrOvIVr4VIVLXHny3nV6TDBZ2rSE1lVOSQwaiMVpo0z//Iu/WBqAU/AMK7fbqYXvpK81zTLY+6hcxZQv7Uy9U6GdMOGE8plCPB7kWhmKVJ4aNy/jqBek1YBVH;4:G/ARFJK3b4jHwHbGTxAiiXzuy9ipeE/lbyFi8nIehnbXM1z5BrZYPbq3Xph+GBjibBBAjnHuMsT1P/4HpM6jF+H5lUiaM3DeIS0Iu5q88PZ9v1pMX5scSUCVvXDMnosBSK0aUBVmjH2FJ0jO1359ClGJa6S0jCYGhyGjFwm+8qBp7wTdBoge4X417m47i6QNgriroNwgGtxsk5hszQpVyL0NDa7VX9ELzAcjTmepP62Iwes0/VjeLXD0mL7Sa7LZxU8/PXTZtiraSbuSs0dVJcJsDJuQcyRa9lOSv5kXgqr5stgl4JHZl15N3pkobGiw
X-Microsoft-Antispam-PRVS: <BY1PR03MB14845FBE45D0A5FEB274D2D5E0D70@BY1PR03MB1484.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BY1PR03MB1484;BCL:0;PCL:0;RULEID:;SRVR:BY1PR03MB1484;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1484;23:rScLn2R39Jla61nEqziaRA/gnGzc6ocTeGY4y3XWW?=
 =?us-ascii?Q?oFD4aMkRWTdRDGNdO1QEI9i6Ka7STth7M6Yj0O2TX6HdJl9CgeIOgha1gKqo?=
 =?us-ascii?Q?7hfhybo0js7qQVWcMsk2kfcDyHryUJmLRw6a74yL3klXS9LDoRhYH7Rsyers?=
 =?us-ascii?Q?5+E2hs34Zc+4agHXop4vu/8IoqvZM4Dkd5u2exVC532gBBeSa+KxLJuZ42p3?=
 =?us-ascii?Q?CxGFpftTnl6TC9nk7Z3gkp2Rye/vAhybM21UWYYkU4lVKmF7krQ7XM4kKPYM?=
 =?us-ascii?Q?T1ES2Y855IC4vY2b6DnMjXdnghHQ29DMV7MDOpeq5OEV5srTE05QbeD99hRk?=
 =?us-ascii?Q?Xac0P2RTP4c79pKPJk772ROfNvx+04OfmMg1aS0EAAyy3EPf8hrMhv+zouBb?=
 =?us-ascii?Q?nlYnQ7jvCEmzU7TXAzDII/wOsF6D250V1Ii9/Z988v0YNwCZ5kE5Cw2vDTtl?=
 =?us-ascii?Q?MWenfH4/HF6QR/8ruTkLd41Kn70EGFopbPJJjy2A2GAVDK9HLj/KC4S9y3NT?=
 =?us-ascii?Q?HkA9q6ddgjQpiTbnz7znhjOFfE0kSkH84hjDsfakwUEAQhbGKc3o7E4ZWfLA?=
 =?us-ascii?Q?5eYM2w9Jb1vBH4p/wTxNpY0KFFB1cTpy5Qfz78GnS+7vzqE30RPfnridJ+7o?=
 =?us-ascii?Q?MCowTYwdDfL8TptYQyq1+MBuduhUvrIQoNBcPd33uraz+VGv319MBTRk/46o?=
 =?us-ascii?Q?9xWUGK0KQViH1YFmuIGnGK5tD4FMQo+sYX/2UfhUwpxRb0BGyBatVeXbkCRQ?=
 =?us-ascii?Q?NGf2W7ZGKUjc4hK9AsUG1xnoTGuiPSzJJ9Z+S9WO3VzfQRJXXM6XBPQOyXth?=
 =?us-ascii?Q?FDcPYIVPRzmpq0oNRt598BdEsERlYGI5vuIxWwQhThfm8op93oXvX69IJyj/?=
 =?us-ascii?Q?fT46I0KwK5uERW9eaNOhEywnhDr1YNutrmDQjX6eBhkGp/mtOE/HUz13rFAA?=
 =?us-ascii?Q?HApslG3WvQ9EEFgNIyfKs76N7vSyv49FAjYvRTZzhCOyOyXjKe1N62Uwqset?=
 =?us-ascii?Q?lHmtbZGulnRjiDFffZUH/9z?=
X-Microsoft-Antispam-Message-Info: tfz2scQTBcGUL4IEA/uz5B7FJ7O++J8PqP5bd9U6cm2bqk5ZKg4EytY8oj9i+8ENrqV0Im7pR+4MZcv482W10jj9xk1LCS8YRLl6C+xNMNdglVhnlkYCrr8rW7+v6MDtLbebWaGJIuSTDaewU6EZ990jdeoKg1Nt8tDhYKgWy/2nA/UE0y3qCWXhYcGVN9Qy
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1484;6:ieqSa2vi6PF0Y+4yrabQdhASTcJd7g9xK0XgSmQjzJY8t8IgagPc82LyXls++ouu82BvGqiTAL5cJ9AUfZ20BWBcOoth9kGsGPB74hUX2cFAj0Nar368GK/htmYgBvsrkuwBM2J+bqd1kX13CnbBSkVs3C0RFjmX2//MgA8DRFguWS8iXx8SVxqUY1Z41GJSJPdImVq/tdwEetfG63jdFxq/AC8BgWBJh+r/c7VItrz7Vh71v6HHqpS9Y38TFKgfQOQ700Q/g44MFXUso1lDzW+DHTrMfHB70rtnM1cl5SV3mChyqKfdzJBs+Z6w8ykqbMVWdOqYa/C4PUPAmYUbrzLoNsUSlvOMEQ6qEOrEfwg=;5:pTKj7uqvYQkBFvnxMGSq22L5DpsCVRMFTAEH3NXFopzKHOWQtn14F1gAZ5ioRiX8FEJhZnQemwM8NvmLmUNVpRYF8uqdrZ8XwXYhzL0fsT69abgE0BpKBMx2bbGus6A6Mc9/pRKWLIxwqp2s8wEkSd7atnQLU8m7Q0+BSl9rDXs=;24:/90+Z78Fuwr2LiPXxIh2UAvZxQoECc3mLm1cCTy2Hx/kDXQwj8xD1xsR925C1ssClEH4sUGWsJ0AWlHbpMvq9aM0FqGu8rBl+8kKilSmfjw=;7:Mmv+gVOiysx0UN+JfYGIBKyzBRuKy9tP9hQ2NJjNAqIBBpUYwolZ/JN5vMfhUR2i2TWWmKplc+17dkeEnKh3OBprOKthNVuZKq9E3yXeNEZDfhzDoNiVQzRHfTF5+1GHjBJrBeNhwgebGCgjUNi1ozbudGUDOXGqyoshp9iTFW10aAiCBFlel5f6PLerXQ7aQ1tDLcQ+ogOX/SxuqXDf5A9dfKamloWamHHIAOWganwgI0S/WSf+q3ktStdZPwaG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:26.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ee30a3-6f59-4bfc-9a7c-08d58b0df911
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1484
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin SD host support
---
 drivers/mmc/host/Kconfig    |  19 --
 drivers/mmc/host/Makefile   |   1 -
 drivers/mmc/host/bfin_sdh.c | 679 --------------------------------------------
 3 files changed, 699 deletions(-)
 delete mode 100644 drivers/mmc/host/bfin_sdh.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 620c2d9..b4fd5d4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -646,25 +646,6 @@ config MMC_VIA_SDMMC
 
 	  If unsure, say N.
 
-config SDH_BFIN
-	tristate "Blackfin Secure Digital Host support"
-	depends on (BF54x && !BF544) || (BF51x && !BF512)
-	help
-	  If you say yes here you will get support for the Blackfin on-chip
-	  Secure Digital Host interface.  This includes support for MMC and
-	  SD cards.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_sdh.
-
-	  If unsure, say N.
-
-config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
-	bool "Blackfin EZkit Missing SDH_CMD Pull Up Resistor Workaround"
-	depends on SDH_BFIN
-	help
-	  If you say yes here SD-Cards may work on the EZkit.
-
 config MMC_CAVIUM_OCTEON
 	tristate "Cavium OCTEON SD/MMC Card Interface support"
 	depends on CAVIUM_OCTEON_SOC
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 84cd138..f563cc0 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+= renesas_sdhi_sys_dmac.o
 obj-$(CONFIG_MMC_SDHI_INTERNAL_DMAC)	+= renesas_sdhi_internal_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
-obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
 octeon-mmc-objs := cavium.o cavium-octeon.o
 obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o
 thunderx-mmc-objs := cavium.o cavium-thunderx.o
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
deleted file mode 100644
index 526231e..0000000
--- a/drivers/mmc/host/bfin_sdh.c
+++ /dev/null
@@ -1,679 +0,0 @@
-/*
- * bfin_sdh.c - Analog Devices Blackfin SDH Controller
- *
- * Copyright (C) 2007-2009 Analog Device Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#define DRIVER_NAME	"bfin-sdh"
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-#include <linux/mmc/host.h>
-#include <linux/proc_fs.h>
-#include <linux/gfp.h>
-
-#include <asm/cacheflush.h>
-#include <asm/dma.h>
-#include <asm/portmux.h>
-#include <asm/bfin_sdh.h>
-
-#if defined(CONFIG_BF51x) || defined(__ADSPBF60x__)
-#define bfin_read_SDH_CLK_CTL		bfin_read_RSI_CLK_CTL
-#define bfin_write_SDH_CLK_CTL		bfin_write_RSI_CLK_CTL
-#define bfin_write_SDH_ARGUMENT		bfin_write_RSI_ARGUMENT
-#define bfin_write_SDH_COMMAND		bfin_write_RSI_COMMAND
-#define bfin_write_SDH_DATA_TIMER	bfin_write_RSI_DATA_TIMER
-#define bfin_read_SDH_RESPONSE0		bfin_read_RSI_RESPONSE0
-#define bfin_read_SDH_RESPONSE1		bfin_read_RSI_RESPONSE1
-#define bfin_read_SDH_RESPONSE2		bfin_read_RSI_RESPONSE2
-#define bfin_read_SDH_RESPONSE3		bfin_read_RSI_RESPONSE3
-#define bfin_write_SDH_DATA_LGTH	bfin_write_RSI_DATA_LGTH
-#define bfin_read_SDH_DATA_CTL		bfin_read_RSI_DATA_CTL
-#define bfin_write_SDH_DATA_CTL		bfin_write_RSI_DATA_CTL
-#define bfin_read_SDH_DATA_CNT		bfin_read_RSI_DATA_CNT
-#define bfin_write_SDH_STATUS_CLR	bfin_write_RSI_STATUS_CLR
-#define bfin_read_SDH_E_STATUS		bfin_read_RSI_E_STATUS
-#define bfin_write_SDH_E_STATUS		bfin_write_RSI_E_STATUS
-#define bfin_read_SDH_STATUS		bfin_read_RSI_STATUS
-#define bfin_write_SDH_MASK0		bfin_write_RSI_MASK0
-#define bfin_write_SDH_E_MASK		bfin_write_RSI_E_MASK
-#define bfin_read_SDH_CFG		bfin_read_RSI_CFG
-#define bfin_write_SDH_CFG		bfin_write_RSI_CFG
-# if defined(__ADSPBF60x__)
-#  define bfin_read_SDH_BLK_SIZE	bfin_read_RSI_BLKSZ
-#  define bfin_write_SDH_BLK_SIZE	bfin_write_RSI_BLKSZ
-# else
-#  define bfin_read_SDH_PWR_CTL		bfin_read_RSI_PWR_CTL
-#  define bfin_write_SDH_PWR_CTL	bfin_write_RSI_PWR_CTL
-# endif
-#endif
-
-struct sdh_host {
-	struct mmc_host		*mmc;
-	spinlock_t		lock;
-	struct resource		*res;
-	void __iomem		*base;
-	int			irq;
-	int			stat_irq;
-	int			dma_ch;
-	int			dma_dir;
-	struct dma_desc_array	*sg_cpu;
-	dma_addr_t		sg_dma;
-	int			dma_len;
-
-	unsigned long		sclk;
-	unsigned int		imask;
-	unsigned int		power_mode;
-	unsigned int		clk_div;
-
-	struct mmc_request	*mrq;
-	struct mmc_command	*cmd;
-	struct mmc_data		*data;
-};
-
-static struct bfin_sd_host *get_sdh_data(struct platform_device *pdev)
-{
-	return pdev->dev.platform_data;
-}
-
-static void sdh_stop_clock(struct sdh_host *host)
-{
-	bfin_write_SDH_CLK_CTL(bfin_read_SDH_CLK_CTL() & ~CLK_E);
-	SSYNC();
-}
-
-static void sdh_enable_stat_irq(struct sdh_host *host, unsigned int mask)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-	host->imask |= mask;
-	bfin_write_SDH_MASK0(mask);
-	SSYNC();
-	spin_unlock_irqrestore(&host->lock, flags);
-}
-
-static void sdh_disable_stat_irq(struct sdh_host *host, unsigned int mask)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-	host->imask &= ~mask;
-	bfin_write_SDH_MASK0(host->imask);
-	SSYNC();
-	spin_unlock_irqrestore(&host->lock, flags);
-}
-
-static int sdh_setup_data(struct sdh_host *host, struct mmc_data *data)
-{
-	unsigned int length;
-	unsigned int data_ctl;
-	unsigned int dma_cfg;
-	unsigned int cycle_ns, timeout;
-
-	dev_dbg(mmc_dev(host->mmc), "%s enter flags: 0x%x\n", __func__, data->flags);
-	host->data = data;
-	data_ctl = 0;
-	dma_cfg = 0;
-
-	length = data->blksz * data->blocks;
-	bfin_write_SDH_DATA_LGTH(length);
-
-	if (data->flags & MMC_DATA_READ)
-		data_ctl |= DTX_DIR;
-	/* Only supports power-of-2 block size */
-	if (data->blksz & (data->blksz - 1))
-		return -EINVAL;
-#ifndef RSI_BLKSZ
-	data_ctl |= ((ffs(data->blksz) - 1) << 4);
-#else
-        bfin_write_SDH_BLK_SIZE(data->blksz);
-#endif
-
-	bfin_write_SDH_DATA_CTL(data_ctl);
-	/* the time of a host clock period in ns */
-	cycle_ns = 1000000000 / (host->sclk / (2 * (host->clk_div + 1)));
-	timeout = data->timeout_ns / cycle_ns;
-	timeout += data->timeout_clks;
-	bfin_write_SDH_DATA_TIMER(timeout);
-	SSYNC();
-
-	if (data->flags & MMC_DATA_READ) {
-		host->dma_dir = DMA_FROM_DEVICE;
-		dma_cfg |= WNR;
-	} else
-		host->dma_dir = DMA_TO_DEVICE;
-
-	sdh_enable_stat_irq(host, (DAT_CRC_FAIL | DAT_TIME_OUT | DAT_END));
-	host->dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len, host->dma_dir);
-#if defined(CONFIG_BF54x) || defined(CONFIG_BF60x)
-	dma_cfg |= DMAFLOW_ARRAY | RESTART | WDSIZE_32 | DMAEN;
-# ifdef RSI_BLKSZ
-	dma_cfg |= PSIZE_32 | NDSIZE_3;
-# else
-	dma_cfg |= NDSIZE_5;
-# endif
-	{
-		struct scatterlist *sg;
-		int i;
-		for_each_sg(data->sg, sg, host->dma_len, i) {
-			host->sg_cpu[i].start_addr = sg_dma_address(sg);
-			host->sg_cpu[i].cfg = dma_cfg;
-			host->sg_cpu[i].x_count = sg_dma_len(sg) / 4;
-			host->sg_cpu[i].x_modify = 4;
-			dev_dbg(mmc_dev(host->mmc), "%d: start_addr:0x%lx, "
-				"cfg:0x%lx, x_count:0x%lx, x_modify:0x%lx\n",
-				i, host->sg_cpu[i].start_addr,
-				host->sg_cpu[i].cfg, host->sg_cpu[i].x_count,
-				host->sg_cpu[i].x_modify);
-		}
-	}
-	flush_dcache_range((unsigned int)host->sg_cpu,
-		(unsigned int)host->sg_cpu +
-			host->dma_len * sizeof(struct dma_desc_array));
-	/* Set the last descriptor to stop mode */
-	host->sg_cpu[host->dma_len - 1].cfg &= ~(DMAFLOW | NDSIZE);
-	host->sg_cpu[host->dma_len - 1].cfg |= DI_EN;
-
-	set_dma_curr_desc_addr(host->dma_ch, (unsigned long *)host->sg_dma);
-	set_dma_x_count(host->dma_ch, 0);
-	set_dma_x_modify(host->dma_ch, 0);
-	SSYNC();
-	set_dma_config(host->dma_ch, dma_cfg);
-#elif defined(CONFIG_BF51x)
-	/* RSI DMA doesn't work in array mode */
-	dma_cfg |= WDSIZE_32 | DMAEN;
-	set_dma_start_addr(host->dma_ch, sg_dma_address(&data->sg[0]));
-	set_dma_x_count(host->dma_ch, length / 4);
-	set_dma_x_modify(host->dma_ch, 4);
-	SSYNC();
-	set_dma_config(host->dma_ch, dma_cfg);
-#endif
-	bfin_write_SDH_DATA_CTL(bfin_read_SDH_DATA_CTL() | DTX_DMA_E | DTX_E);
-
-	SSYNC();
-
-	dev_dbg(mmc_dev(host->mmc), "%s exit\n", __func__);
-	return 0;
-}
-
-static void sdh_start_cmd(struct sdh_host *host, struct mmc_command *cmd)
-{
-	unsigned int sdh_cmd;
-	unsigned int stat_mask;
-
-	dev_dbg(mmc_dev(host->mmc), "%s enter cmd: 0x%p\n", __func__, cmd);
-	WARN_ON(host->cmd != NULL);
-	host->cmd = cmd;
-
-	sdh_cmd = 0;
-	stat_mask = 0;
-
-	sdh_cmd |= cmd->opcode;
-
-	if (cmd->flags & MMC_RSP_PRESENT) {
-		sdh_cmd |= CMD_RSP;
-		stat_mask |= CMD_RESP_END;
-	} else {
-		stat_mask |= CMD_SENT;
-	}
-
-	if (cmd->flags & MMC_RSP_136)
-		sdh_cmd |= CMD_L_RSP;
-
-	stat_mask |= CMD_CRC_FAIL | CMD_TIME_OUT;
-
-	sdh_enable_stat_irq(host, stat_mask);
-
-	bfin_write_SDH_ARGUMENT(cmd->arg);
-	bfin_write_SDH_COMMAND(sdh_cmd | CMD_E);
-	bfin_write_SDH_CLK_CTL(bfin_read_SDH_CLK_CTL() | CLK_E);
-	SSYNC();
-}
-
-static void sdh_finish_request(struct sdh_host *host, struct mmc_request *mrq)
-{
-	dev_dbg(mmc_dev(host->mmc), "%s enter\n", __func__);
-	host->mrq = NULL;
-	host->cmd = NULL;
-	host->data = NULL;
-	mmc_request_done(host->mmc, mrq);
-}
-
-static int sdh_cmd_done(struct sdh_host *host, unsigned int stat)
-{
-	struct mmc_command *cmd = host->cmd;
-	int ret = 0;
-
-	dev_dbg(mmc_dev(host->mmc), "%s enter cmd: %p\n", __func__, cmd);
-	if (!cmd)
-		return 0;
-
-	host->cmd = NULL;
-
-	if (cmd->flags & MMC_RSP_PRESENT) {
-		cmd->resp[0] = bfin_read_SDH_RESPONSE0();
-		if (cmd->flags & MMC_RSP_136) {
-			cmd->resp[1] = bfin_read_SDH_RESPONSE1();
-			cmd->resp[2] = bfin_read_SDH_RESPONSE2();
-			cmd->resp[3] = bfin_read_SDH_RESPONSE3();
-		}
-	}
-	if (stat & CMD_TIME_OUT)
-		cmd->error = -ETIMEDOUT;
-	else if (stat & CMD_CRC_FAIL && cmd->flags & MMC_RSP_CRC)
-		cmd->error = -EILSEQ;
-
-	sdh_disable_stat_irq(host, (CMD_SENT | CMD_RESP_END | CMD_TIME_OUT | CMD_CRC_FAIL));
-
-	if (host->data && !cmd->error) {
-		if (host->data->flags & MMC_DATA_WRITE) {
-			ret = sdh_setup_data(host, host->data);
-			if (ret)
-				return 0;
-		}
-
-		sdh_enable_stat_irq(host, DAT_END | RX_OVERRUN | TX_UNDERRUN | DAT_TIME_OUT);
-	} else
-		sdh_finish_request(host, host->mrq);
-
-	return 1;
-}
-
-static int sdh_data_done(struct sdh_host *host, unsigned int stat)
-{
-	struct mmc_data *data = host->data;
-
-	dev_dbg(mmc_dev(host->mmc), "%s enter stat: 0x%x\n", __func__, stat);
-	if (!data)
-		return 0;
-
-	disable_dma(host->dma_ch);
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-		     host->dma_dir);
-
-	if (stat & DAT_TIME_OUT)
-		data->error = -ETIMEDOUT;
-	else if (stat & DAT_CRC_FAIL)
-		data->error = -EILSEQ;
-	else if (stat & (RX_OVERRUN | TX_UNDERRUN))
-		data->error = -EIO;
-
-	if (!data->error)
-		data->bytes_xfered = data->blocks * data->blksz;
-	else
-		data->bytes_xfered = 0;
-
-	bfin_write_SDH_STATUS_CLR(DAT_END_STAT | DAT_TIMEOUT_STAT | \
-			DAT_CRC_FAIL_STAT | DAT_BLK_END_STAT | RX_OVERRUN | TX_UNDERRUN);
-	bfin_write_SDH_DATA_CTL(0);
-	SSYNC();
-
-	host->data = NULL;
-	if (host->mrq->stop) {
-		sdh_stop_clock(host);
-		sdh_start_cmd(host, host->mrq->stop);
-	} else {
-		sdh_finish_request(host, host->mrq);
-	}
-
-	return 1;
-}
-
-static void sdh_request(struct mmc_host *mmc, struct mmc_request *mrq)
-{
-	struct sdh_host *host = mmc_priv(mmc);
-	int ret = 0;
-
-	dev_dbg(mmc_dev(host->mmc), "%s enter, mrp:%p, cmd:%p\n", __func__, mrq, mrq->cmd);
-	WARN_ON(host->mrq != NULL);
-
-	spin_lock(&host->lock);
-	host->mrq = mrq;
-	host->data = mrq->data;
-
-	if (mrq->data && mrq->data->flags & MMC_DATA_READ) {
-		ret = sdh_setup_data(host, mrq->data);
-		if (ret)
-			goto data_err;
-	}
-
-	sdh_start_cmd(host, mrq->cmd);
-data_err:
-	spin_unlock(&host->lock);
-}
-
-static void sdh_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-{
-	struct sdh_host *host;
-	u16 clk_ctl = 0;
-#ifndef RSI_BLKSZ
-	u16 pwr_ctl = 0;
-#endif
-	u16 cfg;
-	host = mmc_priv(mmc);
-
-	spin_lock(&host->lock);
-
-	cfg = bfin_read_SDH_CFG();
-	cfg |= MWE;
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_4:
-#ifndef RSI_BLKSZ
-		cfg &= ~PD_SDDAT3;
-#endif
-		cfg |= PUP_SDDAT3;
-		/* Enable 4 bit SDIO */
-		cfg |= SD4E;
-		clk_ctl |= WIDE_BUS_4;
-		break;
-	case MMC_BUS_WIDTH_8:
-#ifndef RSI_BLKSZ
-		cfg &= ~PD_SDDAT3;
-#endif
-		cfg |= PUP_SDDAT3;
-		/* Disable 4 bit SDIO */
-		cfg &= ~SD4E;
-		clk_ctl |= BYTE_BUS_8;
-		break;
-	default:
-		cfg &= ~PUP_SDDAT3;
-		/* Disable 4 bit SDIO */
-		cfg &= ~SD4E;
-	}
-	bfin_write_SDH_CFG(cfg);
-
-	host->power_mode = ios->power_mode;
-#ifndef RSI_BLKSZ
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
-		pwr_ctl |= ROD_CTL;
-# ifndef CONFIG_SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
-		pwr_ctl |= SD_CMD_OD;
-# endif
-	}
-
-	if (ios->power_mode != MMC_POWER_OFF)
-		pwr_ctl |= PWR_ON;
-	else
-		pwr_ctl &= ~PWR_ON;
-
-	bfin_write_SDH_PWR_CTL(pwr_ctl);
-#else
-# ifndef CONFIG_SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
-		cfg |= SD_CMD_OD;
-	else
-		cfg &= ~SD_CMD_OD;
-# endif
-
-	if (ios->power_mode != MMC_POWER_OFF)
-		cfg |= PWR_ON;
-	else
-		cfg &= ~PWR_ON;
-
-	bfin_write_SDH_CFG(cfg);
-#endif
-	SSYNC();
-
-	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
-		unsigned char clk_div;
-		clk_div = (get_sclk() / ios->clock - 1) / 2;
-		clk_div = min_t(unsigned char, clk_div, 0xFF);
-		clk_ctl |= clk_div;
-		clk_ctl |= CLK_E;
-		host->clk_div = clk_div;
-		bfin_write_SDH_CLK_CTL(clk_ctl);
-	} else
-		sdh_stop_clock(host);
-
-	/* set up sdh interrupt mask*/
-	if (ios->power_mode == MMC_POWER_ON)
-		bfin_write_SDH_MASK0(DAT_END | DAT_TIME_OUT | DAT_CRC_FAIL |
-			RX_OVERRUN | TX_UNDERRUN | CMD_SENT | CMD_RESP_END |
-			CMD_TIME_OUT | CMD_CRC_FAIL);
-	else
-		bfin_write_SDH_MASK0(0);
-	SSYNC();
-
-	spin_unlock(&host->lock);
-
-	dev_dbg(mmc_dev(host->mmc), "SDH: clk_div = 0x%x actual clock:%ld expected clock:%d\n",
-		host->clk_div,
-		host->clk_div ? get_sclk() / (2 * (host->clk_div + 1)) : 0,
-		ios->clock);
-}
-
-static const struct mmc_host_ops sdh_ops = {
-	.request	= sdh_request,
-	.set_ios	= sdh_set_ios,
-};
-
-static irqreturn_t sdh_dma_irq(int irq, void *devid)
-{
-	struct sdh_host *host = devid;
-
-	dev_dbg(mmc_dev(host->mmc), "%s enter, irq_stat: 0x%04lx\n", __func__,
-		get_dma_curr_irqstat(host->dma_ch));
-	clear_dma_irqstat(host->dma_ch);
-	SSYNC();
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t sdh_stat_irq(int irq, void *devid)
-{
-	struct sdh_host *host = devid;
-	unsigned int status;
-	int handled = 0;
-
-	dev_dbg(mmc_dev(host->mmc), "%s enter\n", __func__);
-
-	spin_lock(&host->lock);
-
-	status = bfin_read_SDH_E_STATUS();
-	if (status & SD_CARD_DET) {
-		mmc_detect_change(host->mmc, 0);
-		bfin_write_SDH_E_STATUS(SD_CARD_DET);
-	}
-	status = bfin_read_SDH_STATUS();
-	if (status & (CMD_SENT | CMD_RESP_END | CMD_TIME_OUT | CMD_CRC_FAIL)) {
-		handled |= sdh_cmd_done(host, status);
-		bfin_write_SDH_STATUS_CLR(CMD_SENT_STAT | CMD_RESP_END_STAT | \
-				CMD_TIMEOUT_STAT | CMD_CRC_FAIL_STAT);
-		SSYNC();
-	}
-
-	status = bfin_read_SDH_STATUS();
-	if (status & (DAT_END | DAT_TIME_OUT | DAT_CRC_FAIL | RX_OVERRUN | TX_UNDERRUN))
-		handled |= sdh_data_done(host, status);
-
-	spin_unlock(&host->lock);
-
-	dev_dbg(mmc_dev(host->mmc), "%s exit\n\n", __func__);
-
-	return IRQ_RETVAL(handled);
-}
-
-static void sdh_reset(void)
-{
-#if defined(CONFIG_BF54x)
-	/* Secure Digital Host shares DMA with Nand controller */
-	bfin_write_DMAC1_PERIMUX(bfin_read_DMAC1_PERIMUX() | 0x1);
-#endif
-
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() | CLKS_EN);
-	SSYNC();
-
-	/* Disable card inserting detection pin. set MMC_CAP_NEEDS_POLL, and
-	 * mmc stack will do the detection.
-	 */
-	bfin_write_SDH_CFG((bfin_read_SDH_CFG() & 0x1F) | (PUP_SDDAT | PUP_SDDAT3));
-	SSYNC();
-}
-
-static int sdh_probe(struct platform_device *pdev)
-{
-	struct mmc_host *mmc;
-	struct sdh_host *host;
-	struct bfin_sd_host *drv_data = get_sdh_data(pdev);
-	int ret;
-
-	if (!drv_data) {
-		dev_err(&pdev->dev, "missing platform driver data\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	mmc = mmc_alloc_host(sizeof(struct sdh_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	mmc->ops = &sdh_ops;
-#if defined(CONFIG_BF51x)
-	mmc->max_segs = 1;
-#else
-	mmc->max_segs = PAGE_SIZE / sizeof(struct dma_desc_array);
-#endif
-#ifdef RSI_BLKSZ
-	mmc->max_seg_size = -1;
-#else
-	mmc->max_seg_size = 1 << 16;
-#endif
-	mmc->max_blk_size = 1 << 11;
-	mmc->max_blk_count = 1 << 11;
-	mmc->max_req_size = PAGE_SIZE;
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	mmc->f_max = get_sclk();
-	mmc->f_min = mmc->f_max >> 9;
-	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_NEEDS_POLL;
-	host = mmc_priv(mmc);
-	host->mmc = mmc;
-	host->sclk = get_sclk();
-
-	spin_lock_init(&host->lock);
-	host->irq = drv_data->irq_int0;
-	host->dma_ch = drv_data->dma_chan;
-
-	ret = request_dma(host->dma_ch, DRIVER_NAME "DMA");
-	if (ret) {
-		dev_err(&pdev->dev, "unable to request DMA channel\n");
-		goto out1;
-	}
-
-	ret = set_dma_callback(host->dma_ch, sdh_dma_irq, host);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to request DMA irq\n");
-		goto out2;
-	}
-
-	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE, &host->sg_dma, GFP_KERNEL);
-	if (host->sg_cpu == NULL) {
-		ret = -ENOMEM;
-		goto out2;
-	}
-
-	platform_set_drvdata(pdev, mmc);
-
-	ret = request_irq(host->irq, sdh_stat_irq, 0, "SDH Status IRQ", host);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to request status irq\n");
-		goto out3;
-	}
-
-	ret = peripheral_request_list(drv_data->pin_req, DRIVER_NAME);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to request peripheral pins\n");
-		goto out4;
-	}
-
-	sdh_reset();
-
-	mmc_add_host(mmc);
-	return 0;
-
-out4:
-	free_irq(host->irq, host);
-out3:
-	mmc_remove_host(mmc);
-	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-out2:
-	free_dma(host->dma_ch);
-out1:
-	mmc_free_host(mmc);
- out:
-	return ret;
-}
-
-static int sdh_remove(struct platform_device *pdev)
-{
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
-
-	if (mmc) {
-		struct sdh_host *host = mmc_priv(mmc);
-
-		mmc_remove_host(mmc);
-
-		sdh_stop_clock(host);
-		free_irq(host->irq, host);
-		free_dma(host->dma_ch);
-		dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
-
-		mmc_free_host(mmc);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int sdh_suspend(struct platform_device *dev, pm_message_t state)
-{
-	struct bfin_sd_host *drv_data = get_sdh_data(dev);
-
-	peripheral_free_list(drv_data->pin_req);
-
-	return 0;
-}
-
-static int sdh_resume(struct platform_device *dev)
-{
-	struct bfin_sd_host *drv_data = get_sdh_data(dev);
-	int ret = 0;
-
-	ret = peripheral_request_list(drv_data->pin_req, DRIVER_NAME);
-	if (ret) {
-		dev_err(&dev->dev, "unable to request peripheral pins\n");
-		return ret;
-	}
-
-	sdh_reset();
-	return ret;
-}
-#else
-# define sdh_suspend NULL
-# define sdh_resume  NULL
-#endif
-
-static struct platform_driver sdh_driver = {
-	.probe   = sdh_probe,
-	.remove  = sdh_remove,
-	.suspend = sdh_suspend,
-	.resume  = sdh_resume,
-	.driver  = {
-		.name = DRIVER_NAME,
-	},
-};
-
-module_platform_driver(sdh_driver);
-
-MODULE_DESCRIPTION("Blackfin Secure Digital Host Driver");
-MODULE_AUTHOR("Cliff Cai, Roy Huang");
-MODULE_LICENSE("GPL");
-- 
2.7.4
