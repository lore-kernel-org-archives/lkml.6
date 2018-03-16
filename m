Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeCPHUo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:20:44 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:61888
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753182AbeCPHR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:59 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 26/28] samples: Remove Blackfin gptimers sample code
Date: Fri, 16 Mar 2018 15:08:24 +0800
Message-ID: <1521184106-24475-24-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(6916009)(2950100002)(6666003)(6306002)(305945005)(106002)(7636002)(16586007)(15188155005)(4326008)(2906002)(86362001)(47776003)(8676002)(8936002)(107886003)(50226002)(356003)(59450400001)(478600001)(246002)(186003)(72206003)(26005)(48376002)(77096007)(966005)(16799955002)(2351001)(36756003)(426003)(316002)(5660300001)(336012)(51416003)(7696005)(76176011)(50466002)(106466001)(19623215001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2623;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD018;1:O8GiXSHcUwZ0rynRJGNPrQgNZBTV5bcc2N1+fXmcQbdsKcC5HM/vSe3HaXlQTtv5D7vfyMK5+53dv1a7o5vE4y2fzd3YjEx3w/Hpvr4JMQHrEobYP2Nexk3Nc9wEicUI
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9014b9af-53c0-47f3-5bc7-08d58b0e0ae3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB2623;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2623;3:3j0Llq9kF1YpS8JRzpyGJXNMtHMBHomjZNejIEQqsN6pHRYGO/QKRF5mYGC5PZN6w7VFNpB7Crn5uerGH1hcTmGU7gI2vF8/tsrlPhDgT6qW2obrGmDDOTbMSf5xMypid+LGlIjF9yY5HliJkaTULCPJUPT3MInjTMSzSqeS6wv7ybCO0qJnd/b/sbOsBZVKDdmbrfIv2S1j3Yxd3A1hpOfQPB1cDVA4UJFCZZFKWsllhPZo0EWVWO1R30pAs8NwP28DpLESyMygdjetfDpJiVv7SypR2sZDjrpTUd6SdTMDy2a4g/FjEEnqGEUuhkFDsikTcnQchv3pjVsWMmLAmQ==;25:ErEULZzAPRdVcsF5C3j51I9T3ielV+32i/S3/zRbbGWsw+gP6WizEXhmk/63JlHhJLGGHb3/VFtn4VIqvZORWTHhf65ByQ5aW5h7wCh3oWbeb6gnJbn7ejx9Mw8DkyihFNw9iW7F2uRUaoQVoS/WCyOCHuWW6Y4c5VT79Df1SGuLvWK4x2K8ltqZVUkMOt098U/t7V66Mhv9RW8I9ttI2zbovFM6NVoIMafcAmslYInlSHpZoOrXWU+x2ZoY8VcjaCmZ7r9l/6BEor372HO76NpUwJIwevN1BebupJD2ODY5I2XxoE6RReZIoaokdU9QK6DALWmG98OTPTeA2iTtsA==;31:8vBo4Wyz0Yj2bkxGO1SoQmKkegIUtzQB2ru04K3QFyUrV+YYplAzUdMJ0FA8JG+5BCnWnXPEZmWHrVRKPXu1WJkcI9ghDoFqTCa2O38yhvNkTC5XlfW/Al747fgVMmTDAVUND0z2NTcUwnYcR9dt6jutv2nw/Tjwxrki4LQ8sw6u+GvyTBMVkquD1Fk94aYMcNZRN/nJTFcdIshOARL4Z3ofswFLc42dQ+zcYA4wH2Y=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2623:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2623;20:lqBCLOpPjmnuGsWHAK1IqWw75qvsg6/cnnlF/0FAIch6P6aEEuB4rgZ/FHtGU/xSfVcHoicxbPno/cShYGt2nkeAx4SF+zwAoUDtqHgnIxyydOke9eDBjgHqH3L5Glp7ZrpmJgie0mzIUAqssjLW1RfCraCO6kgRBk/2V9dzxArlsoyJBxHLji6m71Pd0UOpchwRGzgz5pzcD2A9cNmm9NeCGfCqw3nhzCGvFstl9AGz2qqHvu0+VvqgQIIk2435wgfLudA1rOXKoJKqzW4+x5yZKSfe+tLO+ks6nwjCNuae/TV30nLYRK7rmrhQAMLEZWs1QTU/6FzLfVQoty2Kro21w/RGuI7VXFGW+qKH/y5ZHueztyi2T9Q/jkC9AbV3FyAvJqlHrQbUQQXQtZdaTohMbHGBBx3aNrtxf9dQ/o9wpwDN2jSTlllyy3zTIvE/uZOaaVtv3u2zhkcq1rLeEtEDwjiWzTfko1HvGSwxFTCZyH2yOzeWsPEsWTGoUqNb;4:oNTuaJzRYQVF98SvW0chGsvA+EEjuWpWkFP9P+vK/K9TkbcDFn9j+vc1y4JbePgCyoVhjggrnktaUyG8I7N+AC2jR+sIjC1qiJmh5Estw0eCku6BxnJ/FidAlaSygk/UH/JIwQeyESz/4TeRhmuWbynGPA5uyjzEtRcNtZLqlUNRuDTyBt5mkPfVTidTNh3VipNwveUrAfsajq2rKrg4yHF3vRc4rtsPNghw/p19Ge1Lu3ogmd7VBlGAzmaM3ETleuE7HNREvTiw7/pa58YsXTdi548erheS53FWSQ7ZQ1wXRhqVqdyrcjewP74IKxXX
X-Microsoft-Antispam-PRVS: <MWHPR03MB26238141483D74797CEA4586E0D70@MWHPR03MB2623.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR03MB2623;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2623;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2623;23:lz09lnpiw+PL5jpl0HEbnvnB9c8ark5k9FtmyXoqn?=
 =?us-ascii?Q?BAUACUSOQorbQH6e5+BwBYI6uhgsP57MNPJqcukLYukxEkpFvWWucv1mwgl8?=
 =?us-ascii?Q?JV536dZSWhdyWZlyt4DJ9KW+g6rD1z5nRXPPCrvNY1SvHNXFd0nhBmIm0G1u?=
 =?us-ascii?Q?B3Rytkx9G14HDW+XMGhXxkOnQhRna6hXmeEJlFn+8d0DG0HVcGLER9KEJMUV?=
 =?us-ascii?Q?xyYA+mU/UcNps32hKYlMUvI/AdZkmyg42XzfRBWp6tbgQ5vHOTpRx/usXv0M?=
 =?us-ascii?Q?K6y3lBh3/WFpPhXN0YrQ+7B5022DsS86ARcbN3Dgs/+7CoQG4yOSCkEXTOpM?=
 =?us-ascii?Q?KvwUMvAUnKhBj2vSpxf3zVYt5Y2k/MQMZgnowYLmnINS5CCgM1TinNFobRkT?=
 =?us-ascii?Q?Wpavmqjzjs89ORdoIq9XzatpW+DvfFmuyUP0152ueFgZiJnwlTE1c7IPl331?=
 =?us-ascii?Q?qfZ7rCPU1q7ODgodpenYUQvx89omIJixp6biABVSpsDu7tBmmfrTu+PfN9Ma?=
 =?us-ascii?Q?TcizWtTnaH92IfSkt847DhfKLv2trO99CWDU3TlbiSzZKgkPs7Ehb6Rp8cKm?=
 =?us-ascii?Q?JbjS6lNb5zB6P4OLihVkrSt4os+pyEw5EG70jT8ZlVzU6yQZ0BfNsuOgrV71?=
 =?us-ascii?Q?kuRnCMuPVDcwRQ86FWZVxRRwPpzTbACtmX6XXiizoHxDbwdULTPKfKW+1AZn?=
 =?us-ascii?Q?1KEo9Qlx1XHfmJmBffuBWBdKJ/ABEcUunP1h/pxeDk/1fIAyezPHi5XMgq7X?=
 =?us-ascii?Q?Z5+JqpR4A/2mO1Rg2/qNBpKXf4jR6P3bhPc1TJAIOmwyVxFs5oo87VEufN1G?=
 =?us-ascii?Q?FcY6KGOZRl2T/D4H8yeTGH/2bYHv4oGEls+wcsOQPy7x2o/RNq9pefhXE856?=
 =?us-ascii?Q?vLRaLOchE5+EX80Iyk0kD5L0CRzBMo4Gtse6YD9yJ8Sn81P3OGgg8RZt2Mm/?=
 =?us-ascii?Q?Olvdb+FulTs+Et2+HJ9bsQcNkpdYw1xtvj0pnLP59UAoIxBZ+6JydHFzaX/m?=
 =?us-ascii?Q?cYyCFuSLgB2G8Rp08RS0oQHzp7soHmJuI2V75jB/QrGe4c0D/bqWw5Sx7CWT?=
 =?us-ascii?Q?YiC22uVqix7xlOKQt3BAQZ1VBVatGrjSX2zqyLvtgRomO47boiEVF4C2R1t2?=
 =?us-ascii?Q?lOzTyWDw2o=3D?=
X-Microsoft-Antispam-Message-Info: YdFvuJfVxU+SsxqTP+Oo7Jj1N9n3y0sm/0KxMXQJN87GbjCrQQdzN53KNTfZFxLDHETtWoK3nlVAYIzNh5htf0Ub5Rd6yCeM+tETgxNLx66AMrN+wD07C8HqjxpqBfIDozQjWCTZuM/kz0GfVwNYCUpkHubcOk5g/joX7x8/+LHho55zxfrXrZ6N+NUVe+hW
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2623;6:2D1ESCPXnxt/4YvuQENA9MYaD0dXQx9BVcB5nTlLO6lnDoutQ7PBPgFcVb6HjXYX0npb2euDBowH5Sj0tywErMvb3V3CAcm7thd3PWoN3AV/J4pqhbgzyoH2QXsOctuEM0uolDKaukwrcOoAWxgRFEyXUD+5XkHmVDEc7zKQQTI0sIeJGM4no7AcIrFQ9+A3xpMi+6twaLKQTleN6c120T03T8oC9gETD5oyplvTrVFrtVZhKdLF3tbgXFXJ8s/iGNLsVqV6L8gwX4DwqOXUfH8t8mBuvUMmNQF34SiTwY1hYSojMbgCBhcOHWgwBPjLkh0PKSGN7nXvHxjLVRxU+WSPuc6rrYbwYjCAPnG3PgM=;5:i0N6kLhNz3O6X/gZ7HcoroYoXcoBrAJJigXOWiG/ArlAM8PMSd6QS+4hzlamOlIwrjejJAulL49j0tSv2glUGqO6viAnCYfZrr7sYu2z0Am7+Kwzz1KQ2PTx2kav21t8fJZRTWJiuzAxcaZaAfmruy3xEGR+9mo3OC2UZWjmhZw=;24:Pdww+dW+cuCSkZUPkiJARAuLjuB/5lYsWsnuDT3z3WzAdsBBpsZGZh6UyCNZOjCxyc8agrjghZV0px8xyfvr3IO0YCElS+MOR2liXN86RM0=;7:PB5lgrp9IOtZTY+MvJNDJ5tSG67+B6qYPYWI1MKFEh5WxxGJRuf0ILMqb70/dc5nh650xkKZV3hv6KdcA1XbA81vxNLGdnNiyTa/+B1UpXYB5+B1yg3Gx+3coLe2JyMgDvzcIYBVPIhvdBt4KWzLsbfxIIPPjW2bImncKfGc0v+zUHM7iSd96JRjB5qHAkN0rFuRFQdoYnF+nBExBXqPk/bJXeOhzZZFllIph5PJB+MoKuOJKwT5cPJCTVBASSvk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:56.9552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9014b9af-53c0-47f3-5bc7-08d58b0e0ae3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2623
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin gptimers sample code
---
 samples/Kconfig                     |  6 ---
 samples/Makefile                    |  2 +-
 samples/blackfin/Makefile           |  1 -
 samples/blackfin/gptimers-example.c | 91 -------------------------------------
 4 files changed, 1 insertion(+), 99 deletions(-)
 delete mode 100644 samples/blackfin/Makefile
 delete mode 100644 samples/blackfin/gptimers-example.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c332a3b..f524f55 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -98,12 +98,6 @@ config SAMPLE_SECCOMP
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
 
-config SAMPLE_BLACKFIN_GPTIMERS
-	tristate "Build blackfin gptimers sample code -- loadable modules only"
-	depends on BLACKFIN && BFIN_GPTIMERS && m
-	help
-	  Build samples of blackfin gptimers sample module.
-
 config SAMPLE_VFIO_MDEV_MTTY
 	tristate "Build VFIO mtty example mediated device sample code -- loadable modules only"
 	depends on VFIO_MDEV_DEVICE && m
diff --git a/samples/Makefile b/samples/Makefile
index db54e76..70cf375 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -2,5 +2,5 @@
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
-			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
+			   configfs/ connector/ v4l/ trace_printk/ \
 			   vfio-mdev/ statx/
diff --git a/samples/blackfin/Makefile b/samples/blackfin/Makefile
deleted file mode 100644
index 89b86cf..0000000
--- a/samples/blackfin/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_SAMPLE_BLACKFIN_GPTIMERS) += gptimers-example.o
diff --git a/samples/blackfin/gptimers-example.c b/samples/blackfin/gptimers-example.c
deleted file mode 100644
index 283eba9..0000000
--- a/samples/blackfin/gptimers-example.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Simple gptimers example
- *	http://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:drivers:gptimers
- *
- * Copyright 2007-2009 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/interrupt.h>
-#include <linux/module.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-/* ... random driver includes ... */
-
-#define DRIVER_NAME "gptimer_example"
-
-#ifdef IRQ_TIMER5
-#define SAMPLE_IRQ_TIMER IRQ_TIMER5
-#else
-#define SAMPLE_IRQ_TIMER IRQ_TIMER2
-#endif
-
-struct gptimer_data {
-	uint32_t period, width;
-};
-static struct gptimer_data data;
-
-/* ... random driver state ... */
-
-static irqreturn_t gptimer_example_irq(int irq, void *dev_id)
-{
-	struct gptimer_data *data = dev_id;
-
-	/* make sure it was our timer which caused the interrupt */
-	if (!get_gptimer_intr(TIMER5_id))
-		return IRQ_NONE;
-
-	/* read the width/period values that were captured for the waveform */
-	data->width = get_gptimer_pwidth(TIMER5_id);
-	data->period = get_gptimer_period(TIMER5_id);
-
-	/* acknowledge the interrupt */
-	clear_gptimer_intr(TIMER5_id);
-
-	/* tell the upper layers we took care of things */
-	return IRQ_HANDLED;
-}
-
-/* ... random driver code ... */
-
-static int __init gptimer_example_init(void)
-{
-	int ret;
-
-	/* grab the peripheral pins */
-	ret = peripheral_request(P_TMR5, DRIVER_NAME);
-	if (ret) {
-		printk(KERN_NOTICE DRIVER_NAME ": peripheral request failed\n");
-		return ret;
-	}
-
-	/* grab the IRQ for the timer */
-	ret = request_irq(SAMPLE_IRQ_TIMER, gptimer_example_irq,
-			IRQF_SHARED, DRIVER_NAME, &data);
-	if (ret) {
-		printk(KERN_NOTICE DRIVER_NAME ": IRQ request failed\n");
-		peripheral_free(P_TMR5);
-		return ret;
-	}
-
-	/* setup the timer and enable it */
-	set_gptimer_config(TIMER5_id,
-			WDTH_CAP | PULSE_HI | PERIOD_CNT | IRQ_ENA);
-	enable_gptimers(TIMER5bit);
-
-	return 0;
-}
-module_init(gptimer_example_init);
-
-static void __exit gptimer_example_exit(void)
-{
-	disable_gptimers(TIMER5bit);
-	free_irq(SAMPLE_IRQ_TIMER, &data);
-	peripheral_free(P_TMR5);
-}
-module_exit(gptimer_example_exit);
-
-MODULE_LICENSE("BSD");
-- 
2.7.4
