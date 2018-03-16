Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeCPHRu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:17:50 -0400
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:51024
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753122AbeCPHRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:41 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 14/28] mtd: Remove Blackfin MTD support
Date: Fri, 16 Mar 2018 15:08:12 +0800
Message-ID: <1521184106-24475-12-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(438002)(189003)(199004)(54534003)(6666003)(23676004)(106002)(26005)(50226002)(77096007)(186003)(7696005)(59450400001)(76176011)(336012)(50466002)(2351001)(966005)(246002)(72206003)(36756003)(2906002)(478600001)(8676002)(2870700001)(8936002)(6916009)(86362001)(305945005)(53946003)(575784001)(5890100001)(5660300001)(316002)(2950100002)(5820100001)(7636002)(4326008)(107886003)(47776003)(106466001)(356003)(6306002)(426003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1474;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD009;1:1HnmwIzbrQSps+9kw0Gw2dJCOUK8q0uu6/K+ftxCtxdqOGAeMychPdPKZBFAjtWA6dQbhO5jfCrdUY131KnDm/4Puo548OGLUV0Ry/QfffPYlSpA6+vuNKmYh+gnh9vR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbff1156-06b3-4662-5e9e-08d58b0dffb8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BLUPR03MB1474;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1474;3:SOyTnnpkiddmIPjyHgSIOANU1LsyFqV32NpiGU2H0lKeleX8h/3yfwSn9bKANxCU6FtGeXyr1PtaKQL6e0ufLB2DoRdMBmejzlN23iMTGnE46qpalzusfm+JRuAHnGa/48Zkz8TLEMqlrn+hM79ZYG/yZmPVeIZxGZvwLkmntkJ4VwBd0K8hPXJkg0m43K/Ghdcz6PykR7ExlUG3gGKNRk5FgGjKhYuACF3vIDdQcKL6cfwOo1/yAl5jbsu3hSNMSOAtuwGzn8q/J85KxoQGZy5DNHF0eRd0EGtBtsPaMsTlfEez03d65nPqhy26rC+2dIuIHsD3/2cxlFHo/LZ3Dw==;25:/HncFc3I/0jqfvFKD9+4uie/gIVOtT8C+wS3V65AY6MqlFOY1Su6TIF+aCgwHYN/eljFNPCAduJGnm4BBAfqqx2xrRrjfA7yPpRUWDOuzsr13UXoQWwBxEJa4HXoFCg8fqRTUbEC1Z1LJGRFHR0un5ZT3vZysnYAsHiHbhSu2B3wm3J9tmtiV5S91j9rnxZ/c7Pwz1jq9QU0xt6ZkCIIXdxlngZUSTc21uLwrAJ0Wzal7xi7t4B65QnZ/0IoV388r/USv/MUcXYjGJxBuQIbFOJbEWJATyjiLaZh17K3yJvZE5uCiGDoPpaIV7T6z9HWF62fS/GTf/YPoj4irTFObA==;31:7rxyUtni1QDZtx365r4sgqW5K9oojSfdqjIJ1lvpX0BsGfBDgC0L2RjeGMxe6Ki/YybG5hiN71hkpwKqBhdx3eYxcwCg8jwRovGtYME8O7KjuY9VQLMTetrWmvU1J2FxXLzyx2bBG6Fu3Vy9I6lELkexOPB4T4OpFuK8p6tXHLXM4nXENlgHyIyIPmvZNJFRB8PwRRMWN9+wvo03wyVgKBPHOo02e5FFS/GcvdRP64Q=
X-MS-TrafficTypeDiagnostic: BLUPR03MB1474:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1474;20:shqePeKaW6ISVzrX/wIhAKHVSu14vkZ1s+ZxchiGX6MCDdJxVNPvmTiyey0CZIssEkRs0FDwNCzlVVhWnOqCesxfST8qQuLQnyj0XRuQbDaZDdh4iUAHFHkGUPgjaJapK/hy+qAoiRzbB/zxOjARCVHpRpSD70y0JzGQBXJ8tMCGE6I5TkzZJjTWylOATq0jlE4EZOqPfXjk/vYtWd94ZusZRJ6egQFDJ7slkOCduaD0ADgEjSUFagQbiCZIqAy7He3uo6pbdAr6kfHTNyLxJ2nlyVE+iWKICRt/uxABLKaXTCBSTuy+l6zsALHgOxCIo15I9TWpPAKH3L6iInbuMWnnCpbjwBrcO8OgVFxvKPJDTjk9cEqPaVZX99DapRlg4W/p8jZOLLosiEwUkJ5ZDIKOUkhTAEOYWB74UY4UhLoR0n9YnwVkOKZTRAbPsCNMO6ODnB99Yypw6Xu8SOXwyOALUaymTCROU6YhJC7gLsjH6Pjk7R769MzMglO5+nH7;4:wbBEAMRAObaIBiPrj2TXyNnZrVLNkhtaqPFIIKJhQbgjIAeF/s70A0JJpVwTQCPSdplsylC5Z9vwk3RgVjuf4u0LmcjqMejMGYZjQo320PcTz4YK+GW6mx2k1M5saJAnBWaI231g5XVfSLr1ZJ9s/f+K1XkrfO1FSc4puCzDn0u9FSJVecYeoyBL1GDDy8MElVbYJzolDUoQhnmgjas7PxIEWMjP95PTzLnJjwnUrAtKZU8MzzYmX/uD8LZrT/nix0hE168HLDvZ2xelPh2aLC6eAbI1egpvB7nJSg/a4LZi1XTAUadEHuKbxjVtJfzk
X-Microsoft-Antispam-PRVS: <BLUPR03MB1474227D2F0E4E416375CCCFE0D70@BLUPR03MB1474.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR03MB1474;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB1474;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzTUIxNDc0OzIzOjhVb1ZYaUtMNDNMMkphMU03aUZwRFJPUkc2?=
 =?utf-8?B?K1poTTJPTjZzaEVyOWJLdzhXWkgvYTY5b0xWRUhiUlNYWlpPSHdrL2JnbTdG?=
 =?utf-8?B?QXVsaExpMGQrMzZNeEVnK2k3NWNQajVkR3BWNXphcnJSM05GMFhvOXlYMzhS?=
 =?utf-8?B?REs3WXlLank0cm9RMW8yM1J0YUZJR3AwNXVXaHIrUGdaT2F1LzYrMU9GQldr?=
 =?utf-8?B?MEhPZmZnczdjL21zSDFBMVJkZmEweXdYeER0dFRoRytWYXJpTks0UzZRMWpm?=
 =?utf-8?B?cnJOeHphQXVwWC9xOTVDSHdYcDhEWWU4T1RZK3dsNTFvYmkwOEpuQVhMUExk?=
 =?utf-8?B?UkRzSnQ0RlBJb0hrMjZDcjJMaVhaMy9tN0RNdW5WNnN6dVZUM1dGZHc1UG9m?=
 =?utf-8?B?czd6OEFBS2RHMHYzUXcvRUt0QlBaWjkxZGZVTGs0aVZicldxbmhhRExUdm1P?=
 =?utf-8?B?dzlkb1JFdWJBMnpUaTJXZmRnSW9WZlA1VGhsZ09ka3ZLdmozbUVyZnV3R0p3?=
 =?utf-8?B?NEUzdEkyeGlVRy85dlJOVDZUc3owb1ZUL0hZMDhUajFDdzA3VHVlR3lBK0ZG?=
 =?utf-8?B?Z0swNTNTek1MOUd5UmMyV1gwUytEMWhvejlKalhMZHovUkdFa1NoaDlveTQ4?=
 =?utf-8?B?cXZaTjJPVUgvNzBrQklNT1VjemJDU2lTL2ZMN2VIalJnUXZjQzNVYWEyUUNl?=
 =?utf-8?B?dVJ2L2tQR1RWQkJwKysrcGNDV0liZUV5RDAwaE9sUGgybVg3TEJUVnRmVjFz?=
 =?utf-8?B?VXc1VGtyVCthVlNjNGRTVThwL2tURUhjNHhCM0ZXMWxRSTdDOTkydnRBOWQv?=
 =?utf-8?B?ZGVOWWxubUdLV05Kb2J6akJOUThaZHB3MnFxaDhpelR5OXZFN2VEcXdzcE5Q?=
 =?utf-8?B?clUvZGxkb05iK2JISmt6UmZWZHR5S3lGVGFpdkZXTXdLVGszTEhBTEluNTg3?=
 =?utf-8?B?WGloWGhoMEc2WitQRThTM2ZjdXkzUTFBczNRY1FBeXgxdG1BWFFlZkM5cUs0?=
 =?utf-8?B?UG9NbFVlYk9xcHhFK3FzNHJqOEt6cEMzNzEyU0NTMWNRRkpBZnVUT3JlMzEv?=
 =?utf-8?B?bmpyMWNlcnZZWFhQTDNSL3UzbkZGVDIzK3dMUkpqelZ5SU4rOHdOUXJBcStj?=
 =?utf-8?B?L0htaWdOTjBiL3p2VWN3K1hNeVlIN3gxUDk5aTUzblVEc0o0QnFGTFMzYnZj?=
 =?utf-8?B?WFpnbUc1c3Z3RUcwMFpISUFUV1J3Q29iTVdXeW03aDJnYTRlM2pBNG1IMUxh?=
 =?utf-8?B?YWxvTUZYSU9jbzJmUkc1OGE1ZzRxUzRHTmpOMDRxcURWYmt5VXgySHRuWlpG?=
 =?utf-8?B?aWQwd1ExbEQ2c082MUNjcGxjQk00dkU0cGd2bStmcW1DWVlRTEtYS1NkUGhB?=
 =?utf-8?B?WE9QbUtmRWZVcjJTQVA3L3pTQXl3TG42cm9BQTdpaFhVb05mQnBrTGNlaGRE?=
 =?utf-8?B?SlNSaXY4VVplZkp0OFpNTFBJOVhFL1NnOEM2L3krYXcvaEN6SWVZTERZRVNo?=
 =?utf-8?B?d3dRNW9yWHhmczZITTYvaDVUYmRiS1BHN1kxR0xud0U1NGlnMy9aeEhzMWJW?=
 =?utf-8?B?dzRLcU42aGVKSUNlR3hhcGxYVWIzalE9PQ==?=
X-Microsoft-Antispam-Message-Info: tdICjfM2xWwD7F/+KHDSN2vWqkT2+r78BThxJYvJZKtxD4Lbg4+eAAIuewH/f1abruVqQpThrAB14CKF+9qBQnM1kUtTKUpYxXtcy86k+DT492m3Duf74dgnu1xwBmLuBO2jzBRldcNICku2Lbq8bsk3/abLkN8oYNL2CoLXiRiApw/eV9WbJ9/ntwGEn6Y1
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1474;6:Z0z1QD9p1wxyFsPHVoPBNvKndmFBKrdxYUvpeKn2WI7NwPcPRRbTBVdv3mhd3yRxUQ+FZFE02hQRSYWIe1Dg+g1TW3kAkD+eCJ9FCNj4Mm03iZQqqbuI+pj6lT5+lYb1dxWP0NNF1eodjlLvDZjwGacnKApp6nlkq7i1ke9Sm1xSoCNj5scuYLeqHd4jNxm3MFBD32LAfyPcFv8HPfru+Q32n46AVWadRKbIh+xiLD1g0v1dWGjB/3JAIluOX7SHm0SYFIV2cqcbDEmvgNbzR1r1PAWRWraFLw9I2+BZAzcczHKYqFAGdWZ5YeDyK5vTeTEDjxi7HLiI166IX0S0p5qwtfA9JnGyNIfQFKZ9sOY=;5:AmXapc1LT7R9oQd/BQXRXSW89ewdn6iUAcFvzOGuPJ7mVXpx48V0fTvlqxROBVYniYAgVBU6fsuofrj+pvP3ZMgYc0nzpYXgRDCnuZ7TSox3N6+qt+zJapU8/z5FEr2J8Dy+GNBZWZZ0Ivsk4/iekrsJSzf1+DMQZFqqc4yCc9Y=;24:PuH6OEYmjd9UFwrZdgHfaq+RK5o3O0HHOhGFw6HvmNRZVUvwWvoj+dKM/PJO9nnPWoCv4sOjyE6gMaAaL7banikXoCZgbKFjbDKeSd0/S6A=;7:7HCW6ONcCSJDSt3wbW26E2S4KwlNbK0U5Ds7ggJSBHJo2Ib2zE6OQ8rBsHjUEkahE7sOYAlqjOqekjQ3oL3t8G6pw0xH2pfi8ejRvfh5Xq/jgPJK1uzth89OOXc+rD7J6FCR0JQTVloeSTrvUKabCRPhlvjeV4Us/SGT2V/AFTdJM8mh+BEO8D8sfQwFRg2jie6/NlsL2LoIOgYoXET9ofq9BCTM9y3LLcCO0om8NV2k8sBqmSNeal9GfbOZ8EE+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:38.2653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbff1156-06b3-4662-5e9e-08d58b0dffb8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB1474
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin MTD support
---
 drivers/mtd/maps/Kconfig            |  10 -
 drivers/mtd/maps/Makefile           |   1 -
 drivers/mtd/maps/bfin-async-flash.c | 196 --------
 drivers/mtd/nand/Kconfig            |  32 --
 drivers/mtd/nand/Makefile           |   1 -
 drivers/mtd/nand/bf5xx_nand.c       | 862 ------------------------------------
 6 files changed, 1102 deletions(-)
 delete mode 100644 drivers/mtd/maps/bfin-async-flash.c
 delete mode 100644 drivers/mtd/nand/bf5xx_nand.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 542fdf8..bdc1283 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -334,16 +334,6 @@ config MTD_PCMCIA_ANONYMOUS
 
 	  If unsure, say N.
 
-config MTD_BFIN_ASYNC
-	tristate "Blackfin BF533-STAMP Flash Chip Support"
-	depends on BFIN533_STAMP && MTD_CFI && MTD_COMPLEX_MAPPINGS
-	default y
-	help
-	  Map driver which allows for simultaneous utilization of
-	  ethernet and CFI parallel flash.
-
-	  If compiled as a module, it will be called bfin-async-flash.
-
 config MTD_GPIO_ADDR
 	tristate "GPIO-assisted Flash Chip Support"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index b849aaf..51acf1f 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -42,7 +42,6 @@ obj-$(CONFIG_MTD_SCB2_FLASH)	+= scb2_flash.o
 obj-$(CONFIG_MTD_IXP4XX)	+= ixp4xx.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
-obj-$(CONFIG_MTD_BFIN_ASYNC)	+= bfin-async-flash.o
 obj-$(CONFIG_MTD_RBTX4939)	+= rbtx4939-flash.o
 obj-$(CONFIG_MTD_VMU)		+= vmu-flash.o
 obj-$(CONFIG_MTD_GPIO_ADDR)	+= gpio-addr-flash.o
diff --git a/drivers/mtd/maps/bfin-async-flash.c b/drivers/mtd/maps/bfin-async-flash.c
deleted file mode 100644
index 41730fe..0000000
--- a/drivers/mtd/maps/bfin-async-flash.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * drivers/mtd/maps/bfin-async-flash.c
- *
- * Handle the case where flash memory and ethernet mac/phy are
- * mapped onto the same async bank.  The BF533-STAMP does this
- * for example.  All board-specific configuration goes in your
- * board resources file.
- *
- * Copyright 2000 Nicolas Pitre <nico@fluxnic.net>
- * Copyright 2005-2008 Analog Devices Inc.
- *
- * Enter bugs at http://blackfin.uclinux.org/
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-
-#include <asm/blackfin.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-#include <asm/unaligned.h>
-
-#define pr_devinit(fmt, args...) \
-		({ static const char __fmt[] = fmt; printk(__fmt, ## args); })
-
-#define DRIVER_NAME "bfin-async-flash"
-
-struct async_state {
-	struct mtd_info *mtd;
-	struct map_info map;
-	int enet_flash_pin;
-	uint32_t flash_ambctl0, flash_ambctl1;
-	uint32_t save_ambctl0, save_ambctl1;
-	unsigned long irq_flags;
-};
-
-static void switch_to_flash(struct async_state *state)
-{
-	local_irq_save(state->irq_flags);
-
-	gpio_set_value(state->enet_flash_pin, 0);
-
-	state->save_ambctl0 = bfin_read_EBIU_AMBCTL0();
-	state->save_ambctl1 = bfin_read_EBIU_AMBCTL1();
-	bfin_write_EBIU_AMBCTL0(state->flash_ambctl0);
-	bfin_write_EBIU_AMBCTL1(state->flash_ambctl1);
-	SSYNC();
-}
-
-static void switch_back(struct async_state *state)
-{
-	bfin_write_EBIU_AMBCTL0(state->save_ambctl0);
-	bfin_write_EBIU_AMBCTL1(state->save_ambctl1);
-	SSYNC();
-
-	gpio_set_value(state->enet_flash_pin, 1);
-
-	local_irq_restore(state->irq_flags);
-}
-
-static map_word bfin_flash_read(struct map_info *map, unsigned long ofs)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-	uint16_t word;
-	map_word test;
-
-	switch_to_flash(state);
-
-	word = readw(map->virt + ofs);
-
-	switch_back(state);
-
-	test.x[0] = word;
-	return test;
-}
-
-static void bfin_flash_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-
-	switch_to_flash(state);
-
-	memcpy(to, map->virt + from, len);
-
-	switch_back(state);
-}
-
-static void bfin_flash_write(struct map_info *map, map_word d1, unsigned long ofs)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-	uint16_t d;
-
-	d = d1.x[0];
-
-	switch_to_flash(state);
-
-	writew(d, map->virt + ofs);
-	SSYNC();
-
-	switch_back(state);
-}
-
-static void bfin_flash_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
-{
-	struct async_state *state = (struct async_state *)map->map_priv_1;
-
-	switch_to_flash(state);
-
-	memcpy(map->virt + to, from, len);
-	SSYNC();
-
-	switch_back(state);
-}
-
-static const char * const part_probe_types[] = {
-	"cmdlinepart", "RedBoot", NULL };
-
-static int bfin_flash_probe(struct platform_device *pdev)
-{
-	struct physmap_flash_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *memory = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *flash_ambctl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	struct async_state *state;
-
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return -ENOMEM;
-
-	state->map.name       = DRIVER_NAME;
-	state->map.read       = bfin_flash_read;
-	state->map.copy_from  = bfin_flash_copy_from;
-	state->map.write      = bfin_flash_write;
-	state->map.copy_to    = bfin_flash_copy_to;
-	state->map.bankwidth  = pdata->width;
-	state->map.size       = resource_size(memory);
-	state->map.virt       = (void __iomem *)memory->start;
-	state->map.phys       = memory->start;
-	state->map.map_priv_1 = (unsigned long)state;
-	state->enet_flash_pin = platform_get_irq(pdev, 0);
-	state->flash_ambctl0  = flash_ambctl->start;
-	state->flash_ambctl1  = flash_ambctl->end;
-
-	if (gpio_request(state->enet_flash_pin, DRIVER_NAME)) {
-		pr_devinit(KERN_ERR DRIVER_NAME ": Failed to request gpio %d\n", state->enet_flash_pin);
-		kfree(state);
-		return -EBUSY;
-	}
-	gpio_direction_output(state->enet_flash_pin, 1);
-
-	pr_devinit(KERN_NOTICE DRIVER_NAME ": probing %d-bit flash bus\n", state->map.bankwidth * 8);
-	state->mtd = do_map_probe(memory->name, &state->map);
-	if (!state->mtd) {
-		gpio_free(state->enet_flash_pin);
-		kfree(state);
-		return -ENXIO;
-	}
-
-	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
-				  pdata->parts, pdata->nr_parts);
-
-	platform_set_drvdata(pdev, state);
-
-	return 0;
-}
-
-static int bfin_flash_remove(struct platform_device *pdev)
-{
-	struct async_state *state = platform_get_drvdata(pdev);
-	gpio_free(state->enet_flash_pin);
-	mtd_device_unregister(state->mtd);
-	map_destroy(state->mtd);
-	kfree(state);
-	return 0;
-}
-
-static struct platform_driver bfin_flash_driver = {
-	.probe		= bfin_flash_probe,
-	.remove		= bfin_flash_remove,
-	.driver		= {
-		.name	= DRIVER_NAME,
-	},
-};
-
-module_platform_driver(bfin_flash_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MTD map driver for Blackfins with flash/ethernet on same async bank");
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 736ac88..c0bee1f0 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -116,38 +116,6 @@ config MTD_NAND_AU1550
 	  This enables the driver for the NAND flash controller on the
 	  AMD/Alchemy 1550 SOC.
 
-config MTD_NAND_BF5XX
-	tristate "Blackfin on-chip NAND Flash Controller driver"
-	depends on BF54x || BF52x
-	help
-	  This enables the Blackfin on-chip NAND flash controller
-
-	  No board specific support is done by this driver, each board
-	  must advertise a platform_device for the driver to attach.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called bf5xx-nand.
-
-config MTD_NAND_BF5XX_HWECC
-	bool "BF5XX NAND Hardware ECC"
-	default y
-	depends on MTD_NAND_BF5XX
-	help
-	  Enable the use of the BF5XX's internal ECC generator when
-	  using NAND.
-
-config MTD_NAND_BF5XX_BOOTROM_ECC
-	bool "Use Blackfin BootROM ECC Layout"
-	default n
-	depends on MTD_NAND_BF5XX_HWECC
-	help
-	  If you wish to modify NAND pages and allow the Blackfin on-chip
-	  BootROM to boot from them, say Y here.  This is only necessary
-	  if you are booting U-Boot out of NAND and you wish to update
-	  U-Boot from Linux' userspace.  Otherwise, you should say N here.
-
-	  If unsure, say N.
-
 config MTD_NAND_S3C2410
 	tristate "NAND Flash support for Samsung S3C SoCs"
 	depends on ARCH_S3C24XX || ARCH_S3C64XX
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 921634b..08fc018 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MTD_NAND_DENALI)		+= denali.o
 obj-$(CONFIG_MTD_NAND_DENALI_PCI)	+= denali_pci.o
 obj-$(CONFIG_MTD_NAND_DENALI_DT)	+= denali_dt.o
 obj-$(CONFIG_MTD_NAND_AU1550)		+= au1550nd.o
-obj-$(CONFIG_MTD_NAND_BF5XX)		+= bf5xx_nand.o
 obj-$(CONFIG_MTD_NAND_S3C2410)		+= s3c2410.o
 obj-$(CONFIG_MTD_NAND_TANGO)		+= tango_nand.o
 obj-$(CONFIG_MTD_NAND_DAVINCI)		+= davinci_nand.o
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
deleted file mode 100644
index 87bbd17..0000000
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ /dev/null
@@ -1,862 +0,0 @@
-/* linux/drivers/mtd/nand/bf5xx_nand.c
- *
- * Copyright 2006-2008 Analog Devices Inc.
- *	http://blackfin.uclinux.org/
- *	Bryan Wu <bryan.wu@analog.com>
- *
- * Blackfin BF5xx on-chip NAND flash controller driver
- *
- * Derived from drivers/mtd/nand/s3c2410.c
- * Copyright (c) 2007 Ben Dooks <ben@simtec.co.uk>
- *
- * Derived from drivers/mtd/nand/cafe.c
- * Copyright © 2006 Red Hat, Inc.
- * Copyright © 2006 David Woodhouse <dwmw2@infradead.org>
- *
- * Changelog:
- *	12-Jun-2007  Bryan Wu:  Initial version
- *	18-Jul-2007  Bryan Wu:
- *		- ECC_HW and ECC_SW supported
- *		- DMA supported in ECC_HW
- *		- YAFFS tested as rootfs in both ECC_HW and ECC_SW
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/bitops.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand_ecc.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/blackfin.h>
-#include <asm/dma.h>
-#include <asm/cacheflush.h>
-#include <asm/nand.h>
-#include <asm/portmux.h>
-
-#define DRV_NAME	"bf5xx-nand"
-#define DRV_VERSION	"1.2"
-#define DRV_AUTHOR	"Bryan Wu <bryan.wu@analog.com>"
-#define DRV_DESC	"BF5xx on-chip NAND FLash Controller Driver"
-
-/* NFC_STAT Masks */
-#define NBUSY       0x01  /* Not Busy */
-#define WB_FULL     0x02  /* Write Buffer Full */
-#define PG_WR_STAT  0x04  /* Page Write Pending */
-#define PG_RD_STAT  0x08  /* Page Read Pending */
-#define WB_EMPTY    0x10  /* Write Buffer Empty */
-
-/* NFC_IRQSTAT Masks */
-#define NBUSYIRQ    0x01  /* Not Busy IRQ */
-#define WB_OVF      0x02  /* Write Buffer Overflow */
-#define WB_EDGE     0x04  /* Write Buffer Edge Detect */
-#define RD_RDY      0x08  /* Read Data Ready */
-#define WR_DONE     0x10  /* Page Write Done */
-
-/* NFC_RST Masks */
-#define ECC_RST     0x01  /* ECC (and NFC counters) Reset */
-
-/* NFC_PGCTL Masks */
-#define PG_RD_START 0x01  /* Page Read Start */
-#define PG_WR_START 0x02  /* Page Write Start */
-
-#ifdef CONFIG_MTD_NAND_BF5XX_HWECC
-static int hardware_ecc = 1;
-#else
-static int hardware_ecc;
-#endif
-
-static const unsigned short bfin_nfc_pin_req[] =
-	{P_NAND_CE,
-	 P_NAND_RB,
-	 P_NAND_D0,
-	 P_NAND_D1,
-	 P_NAND_D2,
-	 P_NAND_D3,
-	 P_NAND_D4,
-	 P_NAND_D5,
-	 P_NAND_D6,
-	 P_NAND_D7,
-	 P_NAND_WE,
-	 P_NAND_RE,
-	 P_NAND_CLE,
-	 P_NAND_ALE,
-	 0};
-
-#ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-static int bootrom_ooblayout_ecc(struct mtd_info *mtd, int section,
-				 struct mtd_oob_region *oobregion)
-{
-	if (section > 7)
-		return -ERANGE;
-
-	oobregion->offset = section * 8;
-	oobregion->length = 3;
-
-	return 0;
-}
-
-static int bootrom_ooblayout_free(struct mtd_info *mtd, int section,
-				  struct mtd_oob_region *oobregion)
-{
-	if (section > 7)
-		return -ERANGE;
-
-	oobregion->offset = (section * 8) + 3;
-	oobregion->length = 5;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops bootrom_ooblayout_ops = {
-	.ecc = bootrom_ooblayout_ecc,
-	.free = bootrom_ooblayout_free,
-};
-#endif
-
-/*
- * Data structures for bf5xx nand flash controller driver
- */
-
-/* bf5xx nand info */
-struct bf5xx_nand_info {
-	/* mtd info */
-	struct nand_hw_control		controller;
-	struct nand_chip		chip;
-
-	/* platform info */
-	struct bf5xx_nand_platform	*platform;
-
-	/* device info */
-	struct device			*device;
-
-	/* DMA stuff */
-	struct completion		dma_completion;
-};
-
-/*
- * Conversion functions
- */
-static struct bf5xx_nand_info *mtd_to_nand_info(struct mtd_info *mtd)
-{
-	return container_of(mtd_to_nand(mtd), struct bf5xx_nand_info,
-			    chip);
-}
-
-static struct bf5xx_nand_info *to_nand_info(struct platform_device *pdev)
-{
-	return platform_get_drvdata(pdev);
-}
-
-static struct bf5xx_nand_platform *to_nand_plat(struct platform_device *pdev)
-{
-	return dev_get_platdata(&pdev->dev);
-}
-
-/*
- * struct nand_chip interface function pointers
- */
-
-/*
- * bf5xx_nand_hwcontrol
- *
- * Issue command and address cycles to the chip
- */
-static void bf5xx_nand_hwcontrol(struct mtd_info *mtd, int cmd,
-				   unsigned int ctrl)
-{
-	if (cmd == NAND_CMD_NONE)
-		return;
-
-	while (bfin_read_NFC_STAT() & WB_FULL)
-		cpu_relax();
-
-	if (ctrl & NAND_CLE)
-		bfin_write_NFC_CMD(cmd);
-	else if (ctrl & NAND_ALE)
-		bfin_write_NFC_ADDR(cmd);
-	SSYNC();
-}
-
-/*
- * bf5xx_nand_devready()
- *
- * returns 0 if the nand is busy, 1 if it is ready
- */
-static int bf5xx_nand_devready(struct mtd_info *mtd)
-{
-	unsigned short val = bfin_read_NFC_STAT();
-
-	if ((val & NBUSY) == NBUSY)
-		return 1;
-	else
-		return 0;
-}
-
-/*
- * ECC functions
- * These allow the bf5xx to use the controller's ECC
- * generator block to ECC the data as it passes through
- */
-
-/*
- * ECC error correction function
- */
-static int bf5xx_nand_correct_data_256(struct mtd_info *mtd, u_char *dat,
-					u_char *read_ecc, u_char *calc_ecc)
-{
-	struct bf5xx_nand_info *info = mtd_to_nand_info(mtd);
-	u32 syndrome[5];
-	u32 calced, stored;
-	int i;
-	unsigned short failing_bit, failing_byte;
-	u_char data;
-
-	calced = calc_ecc[0] | (calc_ecc[1] << 8) | (calc_ecc[2] << 16);
-	stored = read_ecc[0] | (read_ecc[1] << 8) | (read_ecc[2] << 16);
-
-	syndrome[0] = (calced ^ stored);
-
-	/*
-	 * syndrome 0: all zero
-	 * No error in data
-	 * No action
-	 */
-	if (!syndrome[0] || !calced || !stored)
-		return 0;
-
-	/*
-	 * sysdrome 0: only one bit is one
-	 * ECC data was incorrect
-	 * No action
-	 */
-	if (hweight32(syndrome[0]) == 1) {
-		dev_err(info->device, "ECC data was incorrect!\n");
-		return -EBADMSG;
-	}
-
-	syndrome[1] = (calced & 0x7FF) ^ (stored & 0x7FF);
-	syndrome[2] = (calced & 0x7FF) ^ ((calced >> 11) & 0x7FF);
-	syndrome[3] = (stored & 0x7FF) ^ ((stored >> 11) & 0x7FF);
-	syndrome[4] = syndrome[2] ^ syndrome[3];
-
-	for (i = 0; i < 5; i++)
-		dev_info(info->device, "syndrome[%d] 0x%08x\n", i, syndrome[i]);
-
-	dev_info(info->device,
-		"calced[0x%08x], stored[0x%08x]\n",
-		calced, stored);
-
-	/*
-	 * sysdrome 0: exactly 11 bits are one, each parity
-	 * and parity' pair is 1 & 0 or 0 & 1.
-	 * 1-bit correctable error
-	 * Correct the error
-	 */
-	if (hweight32(syndrome[0]) == 11 && syndrome[4] == 0x7FF) {
-		dev_info(info->device,
-			"1-bit correctable error, correct it.\n");
-		dev_info(info->device,
-			"syndrome[1] 0x%08x\n", syndrome[1]);
-
-		failing_bit = syndrome[1] & 0x7;
-		failing_byte = syndrome[1] >> 0x3;
-		data = *(dat + failing_byte);
-		data = data ^ (0x1 << failing_bit);
-		*(dat + failing_byte) = data;
-
-		return 1;
-	}
-
-	/*
-	 * sysdrome 0: random data
-	 * More than 1-bit error, non-correctable error
-	 * Discard data, mark bad block
-	 */
-	dev_err(info->device,
-		"More than 1-bit error, non-correctable error.\n");
-	dev_err(info->device,
-		"Please discard data, mark bad block\n");
-
-	return -EBADMSG;
-}
-
-static int bf5xx_nand_correct_data(struct mtd_info *mtd, u_char *dat,
-					u_char *read_ecc, u_char *calc_ecc)
-{
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret, bitflips = 0;
-
-	ret = bf5xx_nand_correct_data_256(mtd, dat, read_ecc, calc_ecc);
-	if (ret < 0)
-		return ret;
-
-	bitflips = ret;
-
-	/* If ecc size is 512, correct second 256 bytes */
-	if (chip->ecc.size == 512) {
-		dat += 256;
-		read_ecc += 3;
-		calc_ecc += 3;
-		ret = bf5xx_nand_correct_data_256(mtd, dat, read_ecc, calc_ecc);
-		if (ret < 0)
-			return ret;
-
-		bitflips += ret;
-	}
-
-	return bitflips;
-}
-
-static void bf5xx_nand_enable_hwecc(struct mtd_info *mtd, int mode)
-{
-	return;
-}
-
-static int bf5xx_nand_calculate_ecc(struct mtd_info *mtd,
-		const u_char *dat, u_char *ecc_code)
-{
-	struct bf5xx_nand_info *info = mtd_to_nand_info(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	u16 ecc0, ecc1;
-	u32 code[2];
-	u8 *p;
-
-	/* first 3 bytes ECC code for 256 page size */
-	ecc0 = bfin_read_NFC_ECC0();
-	ecc1 = bfin_read_NFC_ECC1();
-
-	code[0] = (ecc0 & 0x7ff) | ((ecc1 & 0x7ff) << 11);
-
-	dev_dbg(info->device, "returning ecc 0x%08x\n", code[0]);
-
-	p = (u8 *) code;
-	memcpy(ecc_code, p, 3);
-
-	/* second 3 bytes ECC code for 512 ecc size */
-	if (chip->ecc.size == 512) {
-		ecc0 = bfin_read_NFC_ECC2();
-		ecc1 = bfin_read_NFC_ECC3();
-		code[1] = (ecc0 & 0x7ff) | ((ecc1 & 0x7ff) << 11);
-
-		/* second 3 bytes in ecc_code for second 256
-		 * bytes of 512 page size
-		 */
-		p = (u8 *) (code + 1);
-		memcpy((ecc_code + 3), p, 3);
-		dev_dbg(info->device, "returning ecc 0x%08x\n", code[1]);
-	}
-
-	return 0;
-}
-
-/*
- * PIO mode for buffer writing and reading
- */
-static void bf5xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
-{
-	int i;
-	unsigned short val;
-
-	/*
-	 * Data reads are requested by first writing to NFC_DATA_RD
-	 * and then reading back from NFC_READ.
-	 */
-	for (i = 0; i < len; i++) {
-		while (bfin_read_NFC_STAT() & WB_FULL)
-			cpu_relax();
-
-		/* Contents do not matter */
-		bfin_write_NFC_DATA_RD(0x0000);
-		SSYNC();
-
-		while ((bfin_read_NFC_IRQSTAT() & RD_RDY) != RD_RDY)
-			cpu_relax();
-
-		buf[i] = bfin_read_NFC_READ();
-
-		val = bfin_read_NFC_IRQSTAT();
-		val |= RD_RDY;
-		bfin_write_NFC_IRQSTAT(val);
-		SSYNC();
-	}
-}
-
-static uint8_t bf5xx_nand_read_byte(struct mtd_info *mtd)
-{
-	uint8_t val;
-
-	bf5xx_nand_read_buf(mtd, &val, 1);
-
-	return val;
-}
-
-static void bf5xx_nand_write_buf(struct mtd_info *mtd,
-				const uint8_t *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		while (bfin_read_NFC_STAT() & WB_FULL)
-			cpu_relax();
-
-		bfin_write_NFC_DATA_WR(buf[i]);
-		SSYNC();
-	}
-}
-
-static void bf5xx_nand_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len)
-{
-	int i;
-	u16 *p = (u16 *) buf;
-	len >>= 1;
-
-	/*
-	 * Data reads are requested by first writing to NFC_DATA_RD
-	 * and then reading back from NFC_READ.
-	 */
-	bfin_write_NFC_DATA_RD(0x5555);
-
-	SSYNC();
-
-	for (i = 0; i < len; i++)
-		p[i] = bfin_read_NFC_READ();
-}
-
-static void bf5xx_nand_write_buf16(struct mtd_info *mtd,
-				const uint8_t *buf, int len)
-{
-	int i;
-	u16 *p = (u16 *) buf;
-	len >>= 1;
-
-	for (i = 0; i < len; i++)
-		bfin_write_NFC_DATA_WR(p[i]);
-
-	SSYNC();
-}
-
-/*
- * DMA functions for buffer writing and reading
- */
-static irqreturn_t bf5xx_nand_dma_irq(int irq, void *dev_id)
-{
-	struct bf5xx_nand_info *info = dev_id;
-
-	clear_dma_irqstat(CH_NFC);
-	disable_dma(CH_NFC);
-	complete(&info->dma_completion);
-
-	return IRQ_HANDLED;
-}
-
-static void bf5xx_nand_dma_rw(struct mtd_info *mtd,
-				uint8_t *buf, int is_read)
-{
-	struct bf5xx_nand_info *info = mtd_to_nand_info(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	unsigned short val;
-
-	dev_dbg(info->device, " mtd->%p, buf->%p, is_read %d\n",
-			mtd, buf, is_read);
-
-	/*
-	 * Before starting a dma transfer, be sure to invalidate/flush
-	 * the cache over the address range of your DMA buffer to
-	 * prevent cache coherency problems. Otherwise very subtle bugs
-	 * can be introduced to your driver.
-	 */
-	if (is_read)
-		invalidate_dcache_range((unsigned int)buf,
-				(unsigned int)(buf + chip->ecc.size));
-	else
-		flush_dcache_range((unsigned int)buf,
-				(unsigned int)(buf + chip->ecc.size));
-
-	/*
-	 * This register must be written before each page is
-	 * transferred to generate the correct ECC register
-	 * values.
-	 */
-	bfin_write_NFC_RST(ECC_RST);
-	SSYNC();
-	while (bfin_read_NFC_RST() & ECC_RST)
-		cpu_relax();
-
-	disable_dma(CH_NFC);
-	clear_dma_irqstat(CH_NFC);
-
-	/* setup DMA register with Blackfin DMA API */
-	set_dma_config(CH_NFC, 0x0);
-	set_dma_start_addr(CH_NFC, (unsigned long) buf);
-
-	/* The DMAs have different size on BF52x and BF54x */
-#ifdef CONFIG_BF52x
-	set_dma_x_count(CH_NFC, (chip->ecc.size >> 1));
-	set_dma_x_modify(CH_NFC, 2);
-	val = DI_EN | WDSIZE_16;
-#endif
-
-#ifdef CONFIG_BF54x
-	set_dma_x_count(CH_NFC, (chip->ecc.size >> 2));
-	set_dma_x_modify(CH_NFC, 4);
-	val = DI_EN | WDSIZE_32;
-#endif
-	/* setup write or read operation */
-	if (is_read)
-		val |= WNR;
-	set_dma_config(CH_NFC, val);
-	enable_dma(CH_NFC);
-
-	/* Start PAGE read/write operation */
-	if (is_read)
-		bfin_write_NFC_PGCTL(PG_RD_START);
-	else
-		bfin_write_NFC_PGCTL(PG_WR_START);
-	wait_for_completion(&info->dma_completion);
-}
-
-static void bf5xx_nand_dma_read_buf(struct mtd_info *mtd,
-					uint8_t *buf, int len)
-{
-	struct bf5xx_nand_info *info = mtd_to_nand_info(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
-	dev_dbg(info->device, "mtd->%p, buf->%p, int %d\n", mtd, buf, len);
-
-	if (len == chip->ecc.size)
-		bf5xx_nand_dma_rw(mtd, buf, 1);
-	else
-		bf5xx_nand_read_buf(mtd, buf, len);
-}
-
-static void bf5xx_nand_dma_write_buf(struct mtd_info *mtd,
-				const uint8_t *buf, int len)
-{
-	struct bf5xx_nand_info *info = mtd_to_nand_info(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
-	dev_dbg(info->device, "mtd->%p, buf->%p, len %d\n", mtd, buf, len);
-
-	if (len == chip->ecc.size)
-		bf5xx_nand_dma_rw(mtd, (uint8_t *)buf, 0);
-	else
-		bf5xx_nand_write_buf(mtd, buf, len);
-}
-
-static int bf5xx_nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-		uint8_t *buf, int oob_required, int page)
-{
-	nand_read_page_op(chip, page, 0, NULL, 0);
-
-	bf5xx_nand_read_buf(mtd, buf, mtd->writesize);
-	bf5xx_nand_read_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	return 0;
-}
-
-static int bf5xx_nand_write_page_raw(struct mtd_info *mtd,
-		struct nand_chip *chip,	const uint8_t *buf, int oob_required,
-		int page)
-{
-	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
-	bf5xx_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
-
-	return nand_prog_page_end_op(chip);
-}
-
-/*
- * System initialization functions
- */
-static int bf5xx_nand_dma_init(struct bf5xx_nand_info *info)
-{
-	int ret;
-
-	/* Do not use dma */
-	if (!hardware_ecc)
-		return 0;
-
-	init_completion(&info->dma_completion);
-
-	/* Request NFC DMA channel */
-	ret = request_dma(CH_NFC, "BF5XX NFC driver");
-	if (ret < 0) {
-		dev_err(info->device, " unable to get DMA channel\n");
-		return ret;
-	}
-
-#ifdef CONFIG_BF54x
-	/* Setup DMAC1 channel mux for NFC which shared with SDH */
-	bfin_write_DMAC1_PERIMUX(bfin_read_DMAC1_PERIMUX() & ~1);
-	SSYNC();
-#endif
-
-	set_dma_callback(CH_NFC, bf5xx_nand_dma_irq, info);
-
-	/* Turn off the DMA channel first */
-	disable_dma(CH_NFC);
-	return 0;
-}
-
-static void bf5xx_nand_dma_remove(struct bf5xx_nand_info *info)
-{
-	/* Free NFC DMA channel */
-	if (hardware_ecc)
-		free_dma(CH_NFC);
-}
-
-/*
- * BF5XX NFC hardware initialization
- *  - pin mux setup
- *  - clear interrupt status
- */
-static int bf5xx_nand_hw_init(struct bf5xx_nand_info *info)
-{
-	int err = 0;
-	unsigned short val;
-	struct bf5xx_nand_platform *plat = info->platform;
-
-	/* setup NFC_CTL register */
-	dev_info(info->device,
-		"data_width=%d, wr_dly=%d, rd_dly=%d\n",
-		(plat->data_width ? 16 : 8),
-		plat->wr_dly, plat->rd_dly);
-
-	val = (1 << NFC_PG_SIZE_OFFSET) |
-		(plat->data_width << NFC_NWIDTH_OFFSET) |
-		(plat->rd_dly << NFC_RDDLY_OFFSET) |
-		(plat->wr_dly << NFC_WRDLY_OFFSET);
-	dev_dbg(info->device, "NFC_CTL is 0x%04x\n", val);
-
-	bfin_write_NFC_CTL(val);
-	SSYNC();
-
-	/* clear interrupt status */
-	bfin_write_NFC_IRQMASK(0x0);
-	SSYNC();
-	val = bfin_read_NFC_IRQSTAT();
-	bfin_write_NFC_IRQSTAT(val);
-	SSYNC();
-
-	/* DMA initialization  */
-	if (bf5xx_nand_dma_init(info))
-		err = -ENXIO;
-
-	return err;
-}
-
-/*
- * Device management interface
- */
-static int bf5xx_nand_add_partition(struct bf5xx_nand_info *info)
-{
-	struct mtd_info *mtd = nand_to_mtd(&info->chip);
-	struct mtd_partition *parts = info->platform->partitions;
-	int nr = info->platform->nr_partitions;
-
-	return mtd_device_register(mtd, parts, nr);
-}
-
-static int bf5xx_nand_remove(struct platform_device *pdev)
-{
-	struct bf5xx_nand_info *info = to_nand_info(pdev);
-
-	/* first thing we need to do is release all our mtds
-	 * and their partitions, then go through freeing the
-	 * resources used
-	 */
-	nand_release(nand_to_mtd(&info->chip));
-
-	peripheral_free_list(bfin_nfc_pin_req);
-	bf5xx_nand_dma_remove(info);
-
-	return 0;
-}
-
-static int bf5xx_nand_scan(struct mtd_info *mtd)
-{
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret;
-
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
-
-	if (hardware_ecc) {
-		/*
-		 * for nand with page size > 512B, think it as several sections with 512B
-		 */
-		if (likely(mtd->writesize >= 512)) {
-			chip->ecc.size = 512;
-			chip->ecc.bytes = 6;
-			chip->ecc.strength = 2;
-		} else {
-			chip->ecc.size = 256;
-			chip->ecc.bytes = 3;
-			chip->ecc.strength = 1;
-			bfin_write_NFC_CTL(bfin_read_NFC_CTL() & ~(1 << NFC_PG_SIZE_OFFSET));
-			SSYNC();
-		}
-	}
-
-	return	nand_scan_tail(mtd);
-}
-
-/*
- * bf5xx_nand_probe
- *
- * called by device layer when it finds a device matching
- * one our driver can handled. This code checks to see if
- * it can allocate all necessary resources then calls the
- * nand layer to look for devices
- */
-static int bf5xx_nand_probe(struct platform_device *pdev)
-{
-	struct bf5xx_nand_platform *plat = to_nand_plat(pdev);
-	struct bf5xx_nand_info *info = NULL;
-	struct nand_chip *chip = NULL;
-	struct mtd_info *mtd = NULL;
-	int err = 0;
-
-	dev_dbg(&pdev->dev, "(%p)\n", pdev);
-
-	if (!plat) {
-		dev_err(&pdev->dev, "no platform specific information\n");
-		return -EINVAL;
-	}
-
-	if (peripheral_request_list(bfin_nfc_pin_req, DRV_NAME)) {
-		dev_err(&pdev->dev, "requesting Peripherals failed\n");
-		return -EFAULT;
-	}
-
-	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
-	if (info == NULL) {
-		err = -ENOMEM;
-		goto out_err;
-	}
-
-	platform_set_drvdata(pdev, info);
-
-	nand_hw_control_init(&info->controller);
-
-	info->device     = &pdev->dev;
-	info->platform   = plat;
-
-	/* initialise chip data struct */
-	chip = &info->chip;
-	mtd = nand_to_mtd(&info->chip);
-
-	if (plat->data_width)
-		chip->options |= NAND_BUSWIDTH_16;
-
-	chip->options |= NAND_CACHEPRG | NAND_SKIP_BBTSCAN;
-
-	chip->read_buf = (plat->data_width) ?
-		bf5xx_nand_read_buf16 : bf5xx_nand_read_buf;
-	chip->write_buf = (plat->data_width) ?
-		bf5xx_nand_write_buf16 : bf5xx_nand_write_buf;
-
-	chip->read_byte    = bf5xx_nand_read_byte;
-
-	chip->cmd_ctrl     = bf5xx_nand_hwcontrol;
-	chip->dev_ready    = bf5xx_nand_devready;
-
-	nand_set_controller_data(chip, mtd);
-	chip->controller   = &info->controller;
-
-	chip->IO_ADDR_R    = (void __iomem *) NFC_READ;
-	chip->IO_ADDR_W    = (void __iomem *) NFC_DATA_WR;
-
-	chip->chip_delay   = 0;
-
-	/* initialise mtd info data struct */
-	mtd->dev.parent = &pdev->dev;
-
-	/* initialise the hardware */
-	err = bf5xx_nand_hw_init(info);
-	if (err)
-		goto out_err;
-
-	/* setup hardware ECC data struct */
-	if (hardware_ecc) {
-#ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-		mtd_set_ooblayout(mtd, &bootrom_ooblayout_ops);
-#endif
-		chip->read_buf      = bf5xx_nand_dma_read_buf;
-		chip->write_buf     = bf5xx_nand_dma_write_buf;
-		chip->ecc.calculate = bf5xx_nand_calculate_ecc;
-		chip->ecc.correct   = bf5xx_nand_correct_data;
-		chip->ecc.mode	    = NAND_ECC_HW;
-		chip->ecc.hwctl	    = bf5xx_nand_enable_hwecc;
-		chip->ecc.read_page_raw = bf5xx_nand_read_page_raw;
-		chip->ecc.write_page_raw = bf5xx_nand_write_page_raw;
-	} else {
-		chip->ecc.mode	    = NAND_ECC_SOFT;
-		chip->ecc.algo	= NAND_ECC_HAMMING;
-	}
-
-	/* scan hardware nand chip and setup mtd info data struct */
-	if (bf5xx_nand_scan(mtd)) {
-		err = -ENXIO;
-		goto out_err_nand_scan;
-	}
-
-#ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-	chip->badblockpos = 63;
-#endif
-
-	/* add NAND partition */
-	bf5xx_nand_add_partition(info);
-
-	dev_dbg(&pdev->dev, "initialised ok\n");
-	return 0;
-
-out_err_nand_scan:
-	bf5xx_nand_dma_remove(info);
-out_err:
-	peripheral_free_list(bfin_nfc_pin_req);
-
-	return err;
-}
-
-/* driver device registration */
-static struct platform_driver bf5xx_nand_driver = {
-	.probe		= bf5xx_nand_probe,
-	.remove		= bf5xx_nand_remove,
-	.driver		= {
-		.name	= DRV_NAME,
-	},
-};
-
-module_platform_driver(bf5xx_nand_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR(DRV_AUTHOR);
-MODULE_DESCRIPTION(DRV_DESC);
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.7.4
