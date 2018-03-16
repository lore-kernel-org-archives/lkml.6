Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeCPHSP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:18:15 -0400
Received: from mail-sn1nam02on0058.outbound.protection.outlook.com ([104.47.36.58]:3584
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753114AbeCPHRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:51 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 21/28] pcmcia: Remove Blackfin PCMCIA support
Date: Fri, 16 Mar 2018 15:08:19 +0800
Message-ID: <1521184106-24475-19-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(376002)(396003)(2980300002)(438002)(189003)(199004)(356003)(966005)(36756003)(51416003)(8676002)(7696005)(72206003)(16586007)(478600001)(76176011)(107886003)(426003)(2950100002)(6666003)(6916009)(47776003)(336012)(8936002)(26005)(316002)(2906002)(77096007)(5660300001)(6306002)(48376002)(4326008)(186003)(305945005)(7636002)(59450400001)(50226002)(246002)(106466001)(106002)(50466002)(86362001)(2351001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1480;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD008;1:wHVGZlloypLQnLEQyEEwPd2JlqMCpm978UqZoT1Duk6GI9AmB4HVys9GAoXFckDo/kd6m18i1tTZ6KSt7hMJdu3LpCthVlzvx6ahprvlboRA0l5tUqO6w7IYwld+ouGJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4b3d9c-1b9c-4dc5-56ca-08d58b0e05f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN3PR03MB1480;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1480;3:uITdkGyNse/7z7l0TH0K23AcmCp2GRP9rW93S6CcDFWjVy72uhxvWL1/uIWSKKwVo855H3Bw+bU1+333/bbsmEa4J6FnGNuPA6MsSzIsOk6vELMMjbW/IE/E3PYOZ8xOkB/9cKGgYTzhZpNp0DvwSIihrVd4e/++JMIsDc1GgNAVFobHu2Jj81m5aoP1r64tQSqJvUMYTDJgQ0dqIM70Q4jJJQj7leNNYx85cvG7pKo62GQK3ShnyjLE+/dndp0g8QgQwXoTXO0MQ3vZzYyRsMwoLS4M3ZgypWcHXBTXnvfYbaXzI02525LiyJXjyAaDXO+8rMnKc2PeaipTcdg1Hg==;25:8UNNAhCj1M44xWMqvvKfi4fymD4d5QRjZippu3uqLR1jbIVRFvrmiIM/0qdot82ueXKUK1eRvJKYa2/mcqG71jlw1qgV223q8smZMeefntnfZ289uRxVUBHIDZe814WXTMTnXebd8qMOVHHF42gP6kDOmwM2BkQyZBAUJRh9OAaVvW/RZLzQK3NQpGLfUMIYBJ0YErS9K+faxgU0g18QqbKj+QBcWuScOX/j2fFCNJBA4PESbJ3yNj+ffE2wqnKOoROhApncqi3VlTUrDpz3Ll/EV7GmRa7S7mnYuAg/jTUQaFZujPbqDy5zolPEOuWP2m03373e5isyWYy4a7ODSQ==;31:Bb+0PIkAP2zNeOja7fozSEYQ35Hxmu0DgEBhqc0IEXI4tcpkMDptPlNQSkABbo94p7lURcEaJeblvPmdypGILhR+0ebm2SsyIcoIkK4sOi8s75x/aK/oNbe6ay6zhTaECjIw+OmI/niGedLHDBDAp20XnnX+41/4OI6egtcF+FunCEef/1XvGFl+0cDHL+cVPsagqD83LA+NYKyzmsyTK4/1syym1g0+tqcR3hv5J1Y=
X-MS-TrafficTypeDiagnostic: BN3PR03MB1480:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1480;20:6U/K+0DMzUEf9qsjoshYHchfl2/vUcElaIwLeQ5an/eSJoR/b4RmCeN5p0NxbHCMUQpsbaM4Ea4omaM8cvAVAicVc3uMZHatyJ06/TKuAFOigpHHlBNE4efPVSw+AQj6HC3eAVotOHDgna7oCHieWnwZM77yKtzKhsOvV/mYXQqDFcHNNC4G9oHFMzbqtm0QQFfMbWPIrkaO8DFey28nf1+iYzWARABHPZ8CvHC+THAongzLBAqaGx6h72JXLodR5chqohBOnbmBuijGZavcdVgl1wv85V6Az5FaIkNDzJYds8mudP0GsCsadeuQ5K8vGTQKIgy2rS190KDajhqOmpQT2nyOSulXTCbEyBha0YU1iGouaLHppPWAoFNoliLtUqFAzEy0BSh132MAdjASjI4S/WIArdEvpk0bSwcFHJjmoc+HKsJrY6EbJyOf4MHNbbdlARQxTl360RDdx7BRUScJhGU/MAPgLvKgbXALcVFj5jhxarpOS0oqr6kHDH7v;4:Z10+FAV7HroSohZbpL97f6QITr6I2K3yWQ8YwRG7PSitX/kXLsgzMhhIYREA2DSn3Y8/hDeQN9/LDPTPU4KRauXzHtyVSWYy2MV/VaCJfj/CAsTmd0qo8QlaFlI9nTYHV5+GBq+yfva7YyVsZPTzwuMFRgvWXYHNnlASR2fecFlMWdcHhym/Pt42daBTSVrgmi0FUFhV5+peJxo/CWtg3fK2O2ysZScO1+178+4SLGn3lTmpfghEha0fmwqpfGYC1oyo+SyYBU+nFyKI1w0vCn2gS941EKX/UWSGoW7nnpRJwAnEY0NRlFC28ERedDrF
X-Microsoft-Antispam-PRVS: <BN3PR03MB1480CA7559AEE8B70DB28AEFE0D70@BN3PR03MB1480.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN3PR03MB1480;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB1480;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1480;23:7zkw0Q/LQusAdxQbCTvmOwq56ekRMCrXa3HJtHr6R?=
 =?us-ascii?Q?bVLT+T+cTg8dl1jGAYJLjq8LEiC8l6zJBlVFYwc25lFOhDTRF/5TJGtgTZ1H?=
 =?us-ascii?Q?+aG6tjubwctt5Wh/r87QHA3ruN536dwoDjzyuQo7ZwNx8zAmESM/d3XDwatr?=
 =?us-ascii?Q?IY0OOpbr72FizGmQim7e1E+lhc0YvmxVkMj7FTEtbZjLZpRe4QuBOdvDzlvT?=
 =?us-ascii?Q?vrJYSqp6ZWMzOqfgfx8ovYzGwQ2ftDsTKgDXWoEyb3FSu2mtH4egBC88hNwn?=
 =?us-ascii?Q?LheqCmW0bei/IfJj6SbEcG8W8wxZvcc8Mki9rKXMnI5p5K8U4Mx1V5WFb55H?=
 =?us-ascii?Q?uFLXG0Nx753DaQFdK4Fmk9W7jAy4OqX5hAxE/LeMpXB/lzqZJeqGfQjymmtM?=
 =?us-ascii?Q?+uUEPkhQFKN3GLT74thUlQTLO2hvR/XStBKb1ngbc+5iL5a0JvItroVWP2cE?=
 =?us-ascii?Q?dhvBA1wK0jWH5Zb1ukDNkKaXV6uKwfZidiD1O5CH6QCQ2QU10Iz305qNUzk4?=
 =?us-ascii?Q?+ov52E2xfd4PBcBBV9LQKxWrWJYfOnIDK0odxdTIHOdon15uJjJBlw5XzMeT?=
 =?us-ascii?Q?YCD30mCN5xMgWK8FqhlBtsiOOeiDtXvoRZRX9B0ZNb7mJ8Up+P3rA+vzoqFC?=
 =?us-ascii?Q?+PkK7i8Q6rkjEYKxOPlOZdkmZT5RlF0xoUKKLlLhPGos46qoUkEBuC44mBce?=
 =?us-ascii?Q?qHhVzJkATq3slvwCFvBARQlnJeW19ut0fDsT7mSKNlQMt6jYbQb3IXgqM6bh?=
 =?us-ascii?Q?o+fIsM5nj8nkJ51ySn7ZKTLPO4q0SlHtNF1tMME0G60ygNvu9k/84EnkqK4T?=
 =?us-ascii?Q?UIr5ZAPEesknxzMzQMBjOA92Z7TUAB7w0yYwCJUQGAdcLVvvGPRdBata/LqI?=
 =?us-ascii?Q?y1UeqFO4pqoHRpzfhJbQlKOWOfP21p4QEfC5alkBAVhiE1O/J5D8Yz1QMy01?=
 =?us-ascii?Q?PNpyVmLQrssvBKUqIK1MM6nFNyS91rvzBm9uHGNJ8iRQjlFxTpROZtPI/y8Z?=
 =?us-ascii?Q?u1+Ru7VA9Wxr5VvmDuigBPwF+JJZOLgE97+xUGIp7DN87cZkIbwIcvTFZAdW?=
 =?us-ascii?Q?ljKK4w=3D?=
X-Microsoft-Antispam-Message-Info: tJ1fiylkiZlZszDF9vp0TTO5HDd13yNpCmOIaEQbu0qGrYYg6dURlF6TYGe0xglzhnQQ6LC9XFaV/64I2eN3TWgrf63bTkJvCjQNV4aphP61zMmvCVr+2XZjXpnvC5pM1ijw9m3OAC9NsSRw1OoHVGAJ1lNFKdvGrHN/MstZbCxbYeL3TU6FWKEIcORUwl/1
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1480;6:8mt7lmFCc05sxXb4CItpTGjKDPl6l0KZYvPxbK8Bfs5vFyvMMt3FvrWCxXS4Lx0KmWQ7XJmy5OFJqRsG+TR3pZyhZ2Yg+mKdSF26vuEg/QMRdM7R/X0kICrhhZlRpy4Cvx5VVT9hDQ/3RrLHRENdCNl8+jcj3+dJ9GN5I+sPXUFMDFil5FFWBLKoXtGnG2obOh8ei6qT/XmGPP5q6bGqR1SImbYuMQPs2KMtgdLJH+jeoaBc1/a3Gbw8zWDpaoNbvouyiUHMCoLmucpZkDFbBK7LaWpYBgohM0rdRbKMR6mH2IrvmVZuyUy3pNDQPc+ydEIgBBSoe6Xb7V8L8J3GlWwsaiL4gztbUEdeddy9wM8=;5:4MU5Mkj/usef642wdRvtzbDLbu3pgJ+w7xfHGfhTVv6pRWPX/BjJeWsii3yik4w4AjYVC3oFREVQWktygIQIkAlwP22pLRtejw5GJLgvzu7CrVYiYRW3M5uE7dHyQTn+M5Yum+KQasCHUbBFztCWnf7nFP6MqaLIVLfGjPQU05s=;24:/Ej5lwmg6aXGzaOHJsPLsR4v+ReGSqPLdcmuo/N7jihSEewvt8InXbLLji+B7/eUxBnuNmSsoeBu+yJCCwe1TX8IbIecU7yYc9p+jkdjkYg=;7:XcsLR3L8OGlXxBFBqbT8hFQNebwGHIBe2XGm0PRgLUFF6nW1mYQ2UG/uJxpFTt7KdsESe25QQO97A9JGFQTqLkDlJESpIPU2toaW/aZ1W9xDsz0fb+lfcJA4lUepF7kf3WinsgJUoUSlLK6S2gb7kN3Yq+CCdMRPTjV2Ih8mgpWZIc5/3XIl7UngfkAL2mV7Tuuk6+83yT74eb34Lo/NTRIZUc/MxhLeCoSLa2RRgCYckRa8WbtJYR9Jc2qUoQNJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:48.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4b3d9c-1b9c-4dc5-56ca-08d58b0e05f7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1480
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin PCMCIA support
---
 drivers/pcmcia/Kconfig          |   7 -
 drivers/pcmcia/Makefile         |   1 -
 drivers/pcmcia/bfin_cf_pcmcia.c | 316 ----------------------------------------
 3 files changed, 324 deletions(-)
 delete mode 100644 drivers/pcmcia/bfin_cf_pcmcia.c

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d3c378b..9f63c66 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -266,13 +266,6 @@ config OMAP_CF
 	  Say Y here to support the CompactFlash controller on OMAP.
 	  Note that this doesn't support "True IDE" mode.
 
-config BFIN_CFPCMCIA
-	tristate "Blackfin CompactFlash PCMCIA Driver"
-	depends on PCMCIA && BLACKFIN
-	help
-	  Say Y here to support the CompactFlash PCMCIA driver for Blackfin.
-
-
 config AT91_CF
 	tristate "AT91 CompactFlash Controller"
 	depends on PCI
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index e7dae16..55a2268 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_PCMCIA_BCM63XX)			+= bcm63xx_pcmcia.o
 obj-$(CONFIG_PCMCIA_VRC4171)			+= vrc4171_card.o
 obj-$(CONFIG_PCMCIA_VRC4173)			+= vrc4173_cardu.o
 obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
-obj-$(CONFIG_BFIN_CFPCMCIA)			+= bfin_cf_pcmcia.o
 obj-$(CONFIG_AT91_CF)				+= at91_cf.o
 obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
 obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
diff --git a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
deleted file mode 100644
index 00a296d..0000000
--- a/drivers/pcmcia/bfin_cf_pcmcia.c
+++ /dev/null
@@ -1,316 +0,0 @@
-/*
- * file: drivers/pcmcia/bfin_cf.c
- *
- * based on: drivers/pcmcia/omap_cf.c
- * omap_cf.c -- OMAP 16xx CompactFlash controller driver
- *
- * Copyright (c) 2005 David Brownell
- * Copyright (c) 2006-2008 Michael Hennerich Analog Devices Inc.
- *
- * bugs:         enter bugs at http://blackfin.uclinux.org/
- *
- * this program is free software; you can redistribute it and/or modify
- * it under the terms of the gnu general public license as published by
- * the free software foundation; either version 2, or (at your option)
- * any later version.
- *
- * this program is distributed in the hope that it will be useful,
- * but without any warranty; without even the implied warranty of
- * merchantability or fitness for a particular purpose.  see the
- * gnu general public license for more details.
- *
- * you should have received a copy of the gnu general public license
- * along with this program; see the file copying.
- * if not, write to the free software foundation,
- * 59 temple place - suite 330, boston, ma 02111-1307, usa.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/platform_device.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-
-#include <pcmcia/ss.h>
-#include <pcmcia/cisreg.h>
-
-#define	SZ_1K	0x00000400
-#define	SZ_8K	0x00002000
-#define	SZ_2K	(2 * SZ_1K)
-
-#define	POLL_INTERVAL	(2 * HZ)
-
-#define	CF_ATASEL_ENA 	0x20311802	/* Inverts RESET */
-#define	CF_ATASEL_DIS 	0x20311800
-
-#define bfin_cf_present(pfx) (gpio_get_value(pfx))
-
-/*--------------------------------------------------------------------------*/
-
-static const char driver_name[] = "bfin_cf_pcmcia";
-
-struct bfin_cf_socket {
-	struct pcmcia_socket socket;
-
-	struct timer_list timer;
-	unsigned present:1;
-	unsigned active:1;
-
-	struct platform_device *pdev;
-	unsigned long phys_cf_io;
-	unsigned long phys_cf_attr;
-	u_int irq;
-	u_short cd_pfx;
-};
-
-/*--------------------------------------------------------------------------*/
-static int bfin_cf_reset(void)
-{
-	outw(0, CF_ATASEL_ENA);
-	mdelay(200);
-	outw(0, CF_ATASEL_DIS);
-
-	return 0;
-}
-
-static int bfin_cf_ss_init(struct pcmcia_socket *s)
-{
-	return 0;
-}
-
-/* the timer is primarily to kick this socket's pccardd */
-static void bfin_cf_timer(struct timer_list *t)
-{
-	struct bfin_cf_socket *cf = from_timer(cf, t, timer);
-	unsigned short present = bfin_cf_present(cf->cd_pfx);
-
-	if (present != cf->present) {
-		cf->present = present;
-		dev_dbg(&cf->pdev->dev, ": card %s\n",
-			 present ? "present" : "gone");
-		pcmcia_parse_events(&cf->socket, SS_DETECT);
-	}
-
-	if (cf->active)
-		mod_timer(&cf->timer, jiffies + POLL_INTERVAL);
-}
-
-static int bfin_cf_get_status(struct pcmcia_socket *s, u_int *sp)
-{
-	struct bfin_cf_socket *cf;
-
-	if (!sp)
-		return -EINVAL;
-
-	cf = container_of(s, struct bfin_cf_socket, socket);
-
-	if (bfin_cf_present(cf->cd_pfx)) {
-		*sp = SS_READY | SS_DETECT | SS_POWERON | SS_3VCARD;
-		s->pcmcia_irq = 0;
-		s->pci_irq = cf->irq;
-
-	} else
-		*sp = 0;
-	return 0;
-}
-
-static int
-bfin_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
-{
-
-	struct bfin_cf_socket *cf;
-	cf = container_of(sock, struct bfin_cf_socket, socket);
-
-	switch (s->Vcc) {
-	case 0:
-	case 33:
-		break;
-	case 50:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (s->flags & SS_RESET) {
-		disable_irq(cf->irq);
-		bfin_cf_reset();
-		enable_irq(cf->irq);
-	}
-
-	dev_dbg(&cf->pdev->dev, ": Vcc %d, io_irq %d, flags %04x csc %04x\n",
-		 s->Vcc, s->io_irq, s->flags, s->csc_mask);
-
-	return 0;
-}
-
-static int bfin_cf_ss_suspend(struct pcmcia_socket *s)
-{
-	return bfin_cf_set_socket(s, &dead_socket);
-}
-
-/* regions are 2K each:  mem, attrib, io (and reserved-for-ide) */
-
-static int bfin_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
-{
-	struct bfin_cf_socket *cf;
-
-	cf = container_of(s, struct bfin_cf_socket, socket);
-	io->flags &= MAP_ACTIVE | MAP_ATTRIB | MAP_16BIT;
-	io->start = cf->phys_cf_io;
-	io->stop = io->start + SZ_2K - 1;
-	return 0;
-}
-
-static int
-bfin_cf_set_mem_map(struct pcmcia_socket *s, struct pccard_mem_map *map)
-{
-	struct bfin_cf_socket *cf;
-
-	if (map->card_start)
-		return -EINVAL;
-	cf = container_of(s, struct bfin_cf_socket, socket);
-	map->static_start = cf->phys_cf_io;
-	map->flags &= MAP_ACTIVE | MAP_ATTRIB | MAP_16BIT;
-	if (map->flags & MAP_ATTRIB)
-		map->static_start = cf->phys_cf_attr;
-
-	return 0;
-}
-
-static struct pccard_operations bfin_cf_ops = {
-	.init = bfin_cf_ss_init,
-	.suspend = bfin_cf_ss_suspend,
-	.get_status = bfin_cf_get_status,
-	.set_socket = bfin_cf_set_socket,
-	.set_io_map = bfin_cf_set_io_map,
-	.set_mem_map = bfin_cf_set_mem_map,
-};
-
-/*--------------------------------------------------------------------------*/
-
-static int bfin_cf_probe(struct platform_device *pdev)
-{
-	struct bfin_cf_socket *cf;
-	struct resource *io_mem, *attr_mem;
-	int irq;
-	unsigned short cd_pfx;
-	int status = 0;
-
-	dev_info(&pdev->dev, "Blackfin CompactFlash/PCMCIA Socket Driver\n");
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -EINVAL;
-
-	cd_pfx = platform_get_irq(pdev, 1);	/*Card Detect GPIO PIN */
-
-	if (gpio_request(cd_pfx, "pcmcia: CD")) {
-		dev_err(&pdev->dev,
-		       "Failed ro request Card Detect GPIO_%d\n",
-		       cd_pfx);
-		return -EBUSY;
-	}
-	gpio_direction_input(cd_pfx);
-
-	cf = kzalloc(sizeof *cf, GFP_KERNEL);
-	if (!cf) {
-		gpio_free(cd_pfx);
-		return -ENOMEM;
-	}
-
-	cf->cd_pfx = cd_pfx;
-
-	timer_setup(&cf->timer, bfin_cf_timer, 0);
-
-	cf->pdev = pdev;
-	platform_set_drvdata(pdev, cf);
-
-	cf->irq = irq;
-	cf->socket.pci_irq = irq;
-
-	irq_set_irq_type(irq, IRQF_TRIGGER_LOW);
-
-	io_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	attr_mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-
-	if (!io_mem || !attr_mem)
-		goto fail0;
-
-	cf->phys_cf_io = io_mem->start;
-	cf->phys_cf_attr = attr_mem->start;
-
-	/* pcmcia layer only remaps "real" memory */
-	cf->socket.io_offset = (unsigned long)
-	    ioremap(cf->phys_cf_io, SZ_2K);
-
-	if (!cf->socket.io_offset)
-		goto fail0;
-
-	dev_err(&pdev->dev, ": on irq %d\n", irq);
-
-	dev_dbg(&pdev->dev, ": %s\n",
-		 bfin_cf_present(cf->cd_pfx) ? "present" : "(not present)");
-
-	cf->socket.owner = THIS_MODULE;
-	cf->socket.dev.parent = &pdev->dev;
-	cf->socket.ops = &bfin_cf_ops;
-	cf->socket.resource_ops = &pccard_static_ops;
-	cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP
-	    | SS_CAP_MEM_ALIGN;
-	cf->socket.map_size = SZ_2K;
-
-	status = pcmcia_register_socket(&cf->socket);
-	if (status < 0)
-		goto fail2;
-
-	cf->active = 1;
-	mod_timer(&cf->timer, jiffies + POLL_INTERVAL);
-	return 0;
-
-fail2:
-	iounmap((void __iomem *)cf->socket.io_offset);
-	release_mem_region(cf->phys_cf_io, SZ_8K);
-
-fail0:
-	gpio_free(cf->cd_pfx);
-	kfree(cf);
-	platform_set_drvdata(pdev, NULL);
-
-	return status;
-}
-
-static int bfin_cf_remove(struct platform_device *pdev)
-{
-	struct bfin_cf_socket *cf = platform_get_drvdata(pdev);
-
-	gpio_free(cf->cd_pfx);
-	cf->active = 0;
-	pcmcia_unregister_socket(&cf->socket);
-	del_timer_sync(&cf->timer);
-	iounmap((void __iomem *)cf->socket.io_offset);
-	release_mem_region(cf->phys_cf_io, SZ_8K);
-	platform_set_drvdata(pdev, NULL);
-	kfree(cf);
-	return 0;
-}
-
-static struct platform_driver bfin_cf_driver = {
-	.driver = {
-		   .name = driver_name,
-		   },
-	.probe = bfin_cf_probe,
-	.remove = bfin_cf_remove,
-};
-
-module_platform_driver(bfin_cf_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("BFIN CF/PCMCIA Driver");
-MODULE_LICENSE("GPL");
-- 
2.7.4
