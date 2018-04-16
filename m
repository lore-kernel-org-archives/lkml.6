Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeDPJpd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:45:33 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:37551 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751840AbeDPJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:45:30 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517842800";
   d="scan'208";a="278332080"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
CC: Phil Edworthy <phil.edworthy@renesas.com>,
        "buserror+upstream@gmail.com" <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "Rajendra Nayak" <rnayak@codeaurora.org>,
        Frank Rowand <frank.rowand@sony.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Carlo Caione <carlo@endlessm.com>, "Juri Lelli" <juri.lelli@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Please ignore this one [Was: RE: [PATCH 1/1] arm: rzn1: Add support
 for the second CPU.]
Thread-Topic: Please ignore this one [Was: RE: [PATCH 1/1] arm: rzn1: Add
 support for the second CPU.]
Thread-Index: AdPVZ5ztPG+5AoPqTfKTnBJY/CL1ZQ==
Date: Mon, 16 Apr 2018 09:45:24 +0000
Message-ID: <OSBPR01MB2054176E3A198C64A2F0A8B0D2B00@OSBPR01MB2054.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1591;7:gjeM/zj3Ak8YhY7EVcY9cS0zo1UV697iOCcU1z4wMja9oYWfxt7RK8/98xQk8gvVSJDLaTzMPj9E6wbu3M3DJeL3w+h/pA0haS0Fc9cJrEXIHsqKB4yB8/rJA3YCAOJ9fM2IhtnkxhYDHtfW73R01ukRduMVX7YHzxPh0w3yhGRKFFnsgFPzLLhtqMGiQe0l4hi7mXunKZdL/2yLGdBWKrEg+1vwQ4Xr3L1xhV2V8wo04bybc12YDMSKTe81G/YP;20:KWmmGdyUjERglbq5Xg5xZSITz0PUufP70vJO0qrWBnFRE4QJY54ORA+gD3NI/k0CFct6unsn3QUIh5DCxWgUxGTwQ+JbRbCYC47wAFvebwKPA3yvhX7Dp2GaSrHVqkHXMs+XCqojmnMPt/zryZBayl144R6DNVpbrVoocHhiF+M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1591;
x-ms-traffictypediagnostic: OSBPR01MB1591:
x-microsoft-antispam-prvs: <OSBPR01MB15918EC7EC2C77E9B47F8081D2B00@OSBPR01MB1591.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:OSBPR01MB1591;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1591;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(2501003)(110136005)(3660700001)(4326008)(25786009)(7736002)(6116002)(53936002)(5660300001)(86362001)(305945005)(575784001)(2900100001)(2906002)(3846002)(7416002)(99286004)(3280700002)(6436002)(5250100002)(74316002)(55016002)(9686003)(486006)(8936002)(476003)(81156014)(14454004)(8676002)(81166006)(478600001)(33656002)(44832011)(8656006)(26005)(97736004)(59450400001)(102836004)(39060400002)(54906003)(7696005)(66066001)(68736007)(6506007)(316002)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1591;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
x-microsoft-antispam-message-info: JJ5rnHwq/KydKDQ4P29MltUjM7fNowJ+vlwff1IMBcH/ZWcmNVObdNA2nNMrX8n1DYx9xMfkbE1fLh2Uzj6rvIdVyqHM7f+2ZpW9dZ7Mm/oTity+HRzEdBj+woFEu0aliqrgIn2zoFM+Z+iC0APTz2gFilSoxP17ohNJdDWqIkOu5TzDAfBV9YbMnGPGKLS2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7a704da6-1570-4a70-5362-08d5a37ec75f
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a704da6-1570-4a70-5362-08d5a37ec75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 09:45:24.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1591
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3G9jd4K019249

Please ignore this one... it's rebase junk 😊

Michel

>
> This enables starting the second CA7 core. Also handles the case the
> bootloader has had to change the second CPU parking address to allow
> booting in NONSEC/HYP.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  arch/arm/mach-shmobile/Makefile          |  1 +
>  arch/arm/mach-shmobile/r9a06g032.h       |  7 +++
>  arch/arm/mach-shmobile/setup-r9a06g032.c |  2 +
>  arch/arm/mach-shmobile/smp-r9a06g032.c   | 88
> ++++++++++++++++++++++++++++++++
>  4 files changed, 98 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/r9a06g032.h
>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
>
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-
> shmobile/Makefile index a63e5c2..e0f8c97 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -36,6 +36,7 @@ smp-$(CONFIG_ARCH_R8A7779)+= smp-r8a7779.o
> headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7790)+= smp-r8a7790.o
>  smp-$(CONFIG_ARCH_R8A7791)+= smp-r8a7791.o
>  smp-$(CONFIG_ARCH_EMEV2)+= smp-emev2.o headsmp-scu.o
> platsmp-scu.o
> +smp-$(CONFIG_ARCH_R9A06G032)+= smp-r9a06g032.o
>
>  # PM objects
>  obj-$(CONFIG_SUSPEND)+= suspend.o
> diff --git a/arch/arm/mach-shmobile/r9a06g032.h b/arch/arm/mach-
> shmobile/r9a06g032.h
> new file mode 100644
> index 0000000..3992e97
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/r9a06g032.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __R9A06G032_H__
> +#define __R9A06G032_H__
> +
> +extern const struct smp_operations rzn1_smp_ops;
> +
> +#endif /* __R9A06G032_H__ */
> diff --git a/arch/arm/mach-shmobile/setup-r9a06g032.c b/arch/arm/mach-
> shmobile/setup-r9a06g032.c
> index 65288e1..7bc6216 100644
> --- a/arch/arm/mach-shmobile/setup-r9a06g032.c
> +++ b/arch/arm/mach-shmobile/setup-r9a06g032.c
> @@ -11,6 +11,7 @@
>  #include <asm/mach/arch.h>
>  #include <dt-bindings/soc/renesas,rzn1-map.h>
>  #include <soc/rzn1/sysctrl.h>
> +#include "r9a06g032.h"
>
>  static void __iomem *sysctrl_base_addr;
>
> @@ -50,6 +51,7 @@ static const char *rzn1_boards_compat_dt[] __initconst
> = {  };
>
>  DT_MACHINE_START(RZN1_DT, "Renesas RZ/N1 (Device Tree)")
> +.smp= smp_ops(rzn1_smp_ops),
>  .dt_compat      = rzn1_boards_compat_dt,
>  .restart= rzn1_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c b/arch/arm/mach-
> shmobile/smp-r9a06g032.c
> new file mode 100644
> index 0000000..e441188
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SMP support for Renesas RZ/N1D
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + *
> + * Based on code
> + *  Copyright (C) 2012-2013 Allwinner Ltd.
> + *
> + */
> +
> +#include <linux/of.h>
> +#include <soc/rzn1/sysctrl.h>
> +#include "r9a06g032.h"
> +
> +#define BOOTADDR2_CANARY0x525a4e31
> +
> +static void __iomem *pen2_base;
> +
> +static DEFINE_SPINLOCK(cpu_lock);
> +
> +/*
> + * The alternate boot address for the second core can be overridden in
> +the DT,
> + * typically this will happen if the bootloader decides to park the
> +second
> + * core somewhere else than the fixed ALT_BOOTADDR address.
> + *
> + * This use case is required for NONSEC, as the SYSCTRL BOOTADDR
> +register isn't
> + * available after switching mode, so the bootloader parks the CPU#2 in
> +a pen
> + * is SRAM to await on an alternate address (followed by a canary) then
> +the
> + * bootloader switches mode, and finaly starts the kernel...
> + * The address of that alternate 'register' is passed in /chosen.
> + */
> +static void __init rzn1_smp_prepare_cpus(unsigned int max_cpus) {
> +u32 bootaddr = 0;
> +struct device_node *np = of_find_node_by_path("/chosen");
> +
> +if (np)
> +of_property_read_u32(np, "rzn1,bootaddr", &bootaddr);
> +
> +if (bootaddr &&
> +bootaddr != RZN1_SYSCTRL_REG_BOOTADDR &&
> +bootaddr !=
> (RZN1_SYSTEM_CTRL_BASE+RZN1_SYSCTRL_REG_BOOTADDR)) {
> +
> +pr_info("RZ/N1 CPU#2 boot address %08x\n", bootaddr);
> +pen2_base = ioremap(bootaddr, 8);
> +
> +if (!pen2_base)
> +pr_warn("Couldn't map RZ/N1 CPU#2 PEN2\n");
> +return;
> +}
> +pr_info("RZ/N1 CPU#2 boot address not specified - using SYSCTRL
> +reg\n"); }
> +
> +static int __init rzn1_smp_boot_secondary(unsigned int cpu,
> +    struct task_struct *idle)
> +{
> +u32 t = (u32)virt_to_phys(secondary_startup);
> +
> +/* Inform on what is the second CPU boot address */
> +if (pen2_base && (readl(pen2_base + 4) == BOOTADDR2_CANARY))
> +pr_info("RZ/N1 CPU#%d writing %08x to boot address\n",
> cpu, t);
> +else
> +pr_info("RZ/N1 CPU#%d writing %08x to SYSCTRL reg\n",
> cpu, t);
> +
> +spin_lock(&cpu_lock);
> +
> +/* Set CPU boot address */
> +if (pen2_base && (readl(pen2_base + 4) == BOOTADDR2_CANARY))
> +writel(virt_to_phys(secondary_startup), pen2_base);
> +else
> +rzn1_sysctrl_writel(virt_to_phys(secondary_startup),
> +RZN1_SYSCTRL_REG_BOOTADDR);
> +
> +arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +spin_unlock(&cpu_lock);
> +
> +return 0;
> +}
> +
> +const struct smp_operations rzn1_smp_ops __initconst = {
> +.smp_prepare_cpus= rzn1_smp_prepare_cpus,
> +.smp_boot_secondary= rzn1_smp_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(rzn1_smp, "renesas,r9a06g032",
> &rzn1_smp_ops);
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
