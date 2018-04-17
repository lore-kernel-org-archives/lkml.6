Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeDQJcs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:32:48 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:8706 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751211AbeDQJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:32:45 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="278446844"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
CC: Phil Edworthy <phil.edworthy@renesas.com>,
        "buserror+upstream@gmail.com" <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Andy Gross <andy.gross@linaro.org>, Carlo Caione <carlo@endlessm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Frank Rowand <frank.rowand@sony.com>, Juri Lelli <juri.lelli@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 3/3] arm: shmobile: Add the RZ/N1D SMP enabler driver.
Thread-Topic: [RFC 3/3] arm: shmobile: Add the RZ/N1D SMP enabler driver.
Thread-Index: AQHT1WbxqfAd88rvl0+AlwtJKjWx4KQD7eMAgADDtJA=
Date: Tue, 17 Apr 2018 09:32:38 +0000
Message-ID: <OSBPR01MB2054A677AE2DA04684D51468D2B70@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523871304-48517-5-git-send-email-michel.pollet@bp.renesas.com>
 <9f33a1d2-3c55-2485-a1f2-909def69e5b0@gmail.com>
In-Reply-To: <9f33a1d2-3c55-2485-a1f2-909def69e5b0@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1687;7:vWficu/DxJPTtQ5E3Lb2IXa2AhhjHGlotcUPJWh2BILfu2Gq9oqUh2sEpLIvP79FU+AlB+r5jAWyFHwmO8/TM7Cmst0LPJXkfnjH0uoGQUxhpcm3fO/AjGPfhtHev/Q/6ChnTPaUpmxcSc1AE46e8PZZa0spaJQHYUKseJLJAkx5sfEnVqgdfrYcl5s1nEN/7YL9inrN21G3P9doxZ5XAFt2imMO7kP0zCrADcic4L5ealXao0w/afZ/0KnzDdOH;20:vJegxQgggU9pNf7XDktpRuNw0axvR867s6CE9o65un029CoVMUf/laLY+85it3dJgg3gWIYnoJZoyN0opTRcexRTccakIXtAmybOYHOazVg3QW/Hj061FtWaJR6jkh+2i0La8URWovPpPL01n9lWiDioZpXcg/kKpKh252ggTHY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1687;
x-ms-traffictypediagnostic: OSBPR01MB1687:
x-microsoft-antispam-prvs: <OSBPR01MB168736BA84892D9785F308C9D2B70@OSBPR01MB1687.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:OSBPR01MB1687;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1687;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(2900100001)(26005)(11346002)(7696005)(446003)(76176011)(6436002)(5660300001)(55016002)(6246003)(105586002)(6506007)(53546011)(4326008)(106356001)(54906003)(476003)(86362001)(6116002)(44832011)(3846002)(8656006)(2906002)(99286004)(110136005)(3280700002)(186003)(59450400001)(5250100002)(305945005)(74316002)(2501003)(8936002)(97736004)(25786009)(68736007)(316002)(53936002)(486006)(33656002)(3660700001)(14454004)(7736002)(7416002)(229853002)(66066001)(478600001)(9686003)(81166006)(102836004)(8676002)(39060400002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1687;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: OuXR+Kk7K3tZdJ1VKjNK8ONiUEwpbmmep4hGGgspt+Z/cePG/FXZWORs9WmLb7aZRxrB0LWhE4NOWQtlzooO+oVeVBg/kHDQlyRf1iOX7B4qdf7IfqPk+wREcfUIWqPonpYe+IUI/ZkMcFGmys4s4h8FyK119aahmEsny0iDdk+BiV5lrPXSTagi5dzm50rk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 93ed78c5-b0ae-453b-4330-08d5a44628f9
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ed78c5-b0ae-453b-4330-08d5a44628f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 09:32:38.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1687
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3H9WrSI000639

Hi Florian,

On 16 April 2018 22:46, Florian Fainelli:
> Hi Michel,
>
> On 04/16/2018 02:34 AM, Michel Pollet wrote:
> > The Renesas RZ/N1D second CA7 is parked in a ROM pen at boot time, it
> > requires a special enable method to get it started at boot time.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>
> Some few comments below. This patch should probably be re-ordered in
> your patch series, I would expect you to have this become patch 2 and have
> patch 2 be patch 3 (first you add infrastructure for using something, then you
> make use of it).

Thanks, took that onboard for v2

>
> > +static int rzn1_smp_boot_secondary(unsigned int cpu, struct
> > +task_struct *idle) {
> > +if (!cpu_bootaddr)
> > +return -ENODEV;
> > +
> > +spin_lock(&cpu_lock);
> > +
> > +writel(virt_to_phys(secondary_startup), cpu_bootaddr);
>
> Consider using __pa_symbol() instead of virt_to_phys() since
> secondary_startup is part of the kernel's linear memory map.

Agreed.

>
> > +arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> > +
> > +spin_unlock(&cpu_lock);
> > +
> > +return 0;
> > +}
> > +
> > +static void __init rzn1_smp_prepare_cpus(unsigned int max_cpus) {
> > +struct device_node *dn;
> > +int ret;
> > +u32 bootaddr;
> > +
> > +dn = of_get_cpu_node(1, NULL);
> > +if (!dn) {
> > +pr_err("CPU#1: missing device tree node\n");
> > +return;
> > +}
> > +/*
> > + * Determine the address from which the CPU is polling.
> > + */
> > +ret = of_property_read_u32(dn, "cpu-release-addr", &bootaddr);
> > +if (ret)
> > +pr_err("CPU#1: invalid cpu-release-addr property\n");
> > +
> > +of_node_put(dn);
> > +/* The bootloader *does* change this property */
>
> This comment should probably be moved above the function that fetches
> "cpu-release-addr"

Thanks, I've simplified that bit too..
>
> > +pr_info("CPU#1: cpu-release-addr %08x\n", (u32)bootaddr);
> > +
> > +if (!bootaddr)
> > +return;
>
> Would not you want to show a message here to help catch such conditions
>
> > +
> > +cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));
>
> Relying on ioremap() to reject values that might be outside of the allowed
> range may be a little fragile, but I can't suggest any better alternative.

It's difficult, I'd have to add a memory map header I've been trying not to
use so far for KISS reason...

>
> > +if (!cpu_bootaddr)
> > +pr_err("CPU#1: cpu-release-addr map failed\n"); }
> > +
> > +static const struct smp_operations rzn1_smp_ops __initconst = {
> > +.smp_prepare_cpus = rzn1_smp_prepare_cpus,
> > +.smp_boot_secondary = rzn1_smp_boot_secondary, };
> > +CPU_METHOD_OF_DECLARE(rzn1_smp, "renesas,r9a06g032-smp",
> > +&rzn1_smp_ops);
> >
>

Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
