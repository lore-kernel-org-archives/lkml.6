Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeEGVoz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:44:55 -0400
Received: from mail-dm3nam03on0068.outbound.protection.outlook.com ([104.47.41.68]:6285
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752389AbeEGVox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:44:53 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC: "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
Thread-Topic: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
Thread-Index: AQHT5exoi/22xDkBE0+o4Ny8pzDRlKQkzTYA
Date: Mon, 7 May 2018 21:44:48 +0000
Message-ID: <BN6PR12MB1809A66A78024F2E519A1A34F79B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
 <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1905;7:zoM9CcdvZSLkcPESwWpTbXVLsCw1bo4OgETCc965ArLi2op7KQGuOX/pcYTXtB3UkPd8UbxvZTZlO+60A+79CNdHxyzDThiqosEXrieqz0QqQtw6Uj9moeb03itpsx3l/RqVDj+j1qs9D/8bHWTS8Az0K+4nhUGvNy/kkfM6O4Au5gs2NZLEQAlP4LUg9X2gIlWndUHcs+oif1U28tSHN4oPPAvIGoG8mr4bnArcBHaVM108zK6Nj3svCPB+k0z3;20:+4lLUVDDeo/WBMoNTXXTzwqaK9Hl/kUBfY09zlPR4niBceU5JCDcsHzC8RcZId5BBGQbWyLNGYgsBrwlwlBIELtjeclJAVBrG/7psxc9sWVCtnP3w78GNnq/y3yNB6O+J6pdSDzY1SFjgjg3oaPHJ4UZPidAF6JUx3ruoThTkK42GLtIQmeS4glCngvhse/Q2H3lqKBwLq+B90lAqwkVQXXTp6y5+eGH8uBZ0VGLwoUSm9afZJeQCSROhRXSZUjy
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(366004)(396003)(13464003)(189003)(199004)(9686003)(55016002)(486006)(11346002)(5660300001)(2900100001)(446003)(5250100002)(105586002)(106356001)(8936002)(72206003)(6636002)(476003)(478600001)(25786009)(305945005)(316002)(68736007)(4326008)(7736002)(102836004)(66066001)(6862004)(26005)(74316002)(86362001)(54906003)(229853002)(14454004)(59450400001)(53936002)(81166006)(8676002)(97736004)(2906002)(81156014)(33656002)(3660700001)(99286004)(7696005)(3280700002)(76176011)(6506007)(6246003)(3846002)(6116002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
x-ms-traffictypediagnostic: BN6PR12MB1905:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com;
x-microsoft-antispam-prvs: <BN6PR12MB190591AB5AC8AECCB22C9D4EF79B0@BN6PR12MB1905.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
x-forefront-prvs: 066517B35B
x-microsoft-antispam-message-info: +/dMkJ+mxpyY6u51H+cCa7PycPEe3rUBc3E0z4DfehToAadv7TcfDUi+hD/uFJCme81TLWFSOBTARz2ue9hG3PUXZGKhviUcbw+Oz72gZ5akz/veStMhokMppCHA1dk458M0/8iBBxdQfCpl6HKFZvnUiEvzDNa/wr76eVcUGHst7RuC0XL7VszyuVSmsFRI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9632d458-0ea4-4156-e183-08d5b463c1e4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9632d458-0ea4-4156-e183-08d5b463c1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2018 21:44:48.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47Lj0v7021114

> -----Original Message-----
> From: Agrawal, Akshu
> Sent: Monday, May 7, 2018 6:14 AM
> Cc: djkurtz@chromium.org; Agrawal, Akshu <Akshu.Agrawal@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>;
> mturquette@baylibre.com; sboyd@kernel.org; Koenig, Christian
> <Christian.Koenig@amd.com>; airlied@redhat.com; Liu, Shaoyun
> <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
> acpi@vger.kernel.org
> Subject: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
> 
> Stoney SoC provides oscout clock. This clock can support 25Mhz and 48Mhz
> of frequency.
> The clock is available for general system use.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: config change, added SPDX tag and used clk_hw_register_.
> v3: Fix kbuild warning for checking of NULL pointer
> v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
>  drivers/clk/x86/Makefile             |  3 +-
>  drivers/clk/x86/clk-st.c             | 85
> ++++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/clk-st.h | 17 ++++++++
>  3 files changed, 104 insertions(+), 1 deletion(-)  create mode 100644
> drivers/clk/x86/clk-st.c  create mode 100644
> include/linux/platform_data/clk-st.h
> 
> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile index
> 1367afb..00303bc 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
>  clk-x86-lpss-objs		:= clk-lpt.o
>  obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
> -obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c new file mode
> 100644 index 0000000..8a7795c
> --- /dev/null
> +++ b/drivers/clk/x86/clk-st.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0

Should this be MIT?  The original license was MIT.

Alex

> +/*
> + * clock framework for AMD Stoney based clocks
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_data/clk-st.h> #include
> +<linux/platform_device.h>
> +
> +/* Clock Driving Strength 2 register */
> +#define CLKDRVSTR2	0x28
> +/* Clock Control 1 register */
> +#define MISCCLKCNTL1	0x40
> +/* Auxiliary clock1 enable bit */
> +#define OSCCLKENB	2
> +/* 25Mhz auxiliary output clock freq bit */
> +#define OSCOUT1CLK25MHZ	16
> +
> +#define ST_CLK_48M	0
> +#define ST_CLK_25M	1
> +#define ST_CLK_MUX	2
> +#define ST_CLK_GATE	3
> +#define ST_MAX_CLKS	4
> +
> +static const char * const clk_oscout1_parents[] = { "clk48MHz",
> +"clk25MHz" };
> +
> +static int st_clk_probe(struct platform_device *pdev) {
> +	struct st_clk_data *st_data;
> +	struct clk_hw **hws;
> +
> +	st_data = dev_get_platdata(&pdev->dev);
> +	if (!st_data || !st_data->base)
> +		return -EINVAL;
> +
> +	hws = devm_kzalloc(&pdev->dev, sizeof(*hws) * ST_MAX_CLKS,
> GFP_KERNEL);
> +	if (!hws)
> +		return -ENOMEM;
> +
> +	hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
> NULL, 0,
> +						     48000000);
> +	hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
> NULL, 0,
> +						     25000000);
> +
> +	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
> +		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
> +		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0,
> NULL);
> +
> +	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
> +
> +	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
> "oscout1_mux",
> +		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
> +		CLK_GATE_SET_TO_DISABLE, NULL);
> +
> +	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
> +
> +	platform_set_drvdata(pdev, hws);
> +	return 0;
> +}
> +
> +static int st_clk_remove(struct platform_device *pdev) {
> +	struct clk_hw **hws;
> +	int i;
> +
> +	hws = platform_get_drvdata(pdev);
> +
> +	for (i = 0; i < ST_MAX_CLKS; i++)
> +		clk_hw_unregister(hws[i]);
> +	return 0;
> +}
> +
> +static struct platform_driver st_clk_driver = {
> +	.driver = {
> +		.name = "clk-st",
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = st_clk_probe,
> +	.remove = st_clk_remove,
> +};
> +builtin_platform_driver(st_clk_driver);
> diff --git a/include/linux/platform_data/clk-st.h
> b/include/linux/platform_data/clk-st.h
> new file mode 100644
> index 0000000..188184d
> --- /dev/null
> +++ b/include/linux/platform_data/clk-st.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * clock framework for AMD Stoney based clock
> + *
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __CLK_ST_H
> +#define __CLK_ST_H
> +
> +#include <linux/compiler.h>
> +
> +struct st_clk_data {
> +	void __iomem *base;
> +};
> +
> +#endif /* __CLK_ST_H */
> --
> 1.9.1
