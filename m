Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeCPKx6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:53:58 -0400
Received: from mail-he1eur01on0071.outbound.protection.outlook.com ([104.47.0.71]:21064
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeCPKx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:53:56 -0400
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: RE: [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
Thread-Index: AQHTpM6UtGdK8HYWVEWSUtB/xbhjRqPS4CHA
Date: Fri, 16 Mar 2018 10:53:50 +0000
Message-ID: <AM3PR04MB306A4A43EDD03EC199BFD6D80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1345;7:Sius9sXUD4XzCJSRG/lUEqpYiHAV/g3KEZDUOBjzIGuydb76yyA5XhoTN+UDDLBiO/L23TZL5Q8cw2PRzZqHz/8vpEK8sVQMMQKkdSs9SUPa0HZeD5L+8uk9nfdG8MSdQvqO3BwW87qFz50aillrBVQem+uZQBi9+2LtYTMyFsMAJ1HrJMI7nWB8MTxfNotmbCvGdCoRPI8pYxMQfClh/lBSyJQFjhLUSabwE9vZW3Mr3en+M6f5S1KW+1z5eRuB
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(199004)(189003)(54534003)(13464003)(6436002)(53936002)(25786009)(55016002)(14454004)(305945005)(33656002)(7736002)(3660700001)(45080400002)(478600001)(229853002)(68736007)(2950100002)(966005)(97736004)(2501003)(5250100002)(81166006)(8676002)(81156014)(316002)(8936002)(66066001)(74316002)(4326008)(26005)(5660300001)(105586002)(102836004)(53546011)(6506007)(59450400001)(86362001)(76176011)(2906002)(7696005)(3280700002)(54906003)(110136005)(6116002)(99286004)(106356001)(3846002)(6306002)(6246003)(9686003)(2900100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1345;H:AM3PR04MB306.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07eb46e9-9c2a-4c8a-e838-08d58b2c33d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1345;
x-ms-traffictypediagnostic: AM3PR04MB1345:
x-microsoft-antispam-prvs: <AM3PR04MB1345A1DE4DA021F0AC6FFF1980D70@AM3PR04MB1345.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1345;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1345;
x-forefront-prvs: 0613912E23
x-microsoft-antispam-message-info: H+svME9s0Lq9tg8EayVATGFV0YnUSqnmoM9vZ13GcxDcNZTDPbZJV9dE+QKCUyW9uENwskzuBzOW27k1WuB+AvdqK5pS1XmLuXtnRYlwvNkBo/qc11WzbqCIEWdsLQ6LcgfWcrF7/NOrFKrv6CBKyGFOdX38cqZXCgctAwzvx9lYkQ6yho0gY2IrcM5LV3O9XJYSw4YOdYAQQPMjZ6GixQU0/7n4KLqAs1rMi5VLVNBT3GYg6m8dbRcepTNWKnCC8ur2Dn4NcB6EHdqYO1L1/x8pAvrUYjUtjmvPZuxFBA7FwfmjawWHuvPc8lTLxxhK+fsGgG9/715134l4K8Om4A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07eb46e9-9c2a-4c8a-e838-08d58b2c33d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 10:53:50.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1345
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2GAs5UR021503

Hi Shawn & Stephen,

Would you help review this series? It's pending for a long time.

Regards
Dong Aisheng

> -----Original Message-----
> From: Dong Aisheng [mailto:aisheng.dong@nxp.com]
> Sent: Tuesday, February 13, 2018 9:28 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> sboyd@codeaurora.org; mturquette@baylibre.com; shawnguo@kernel.org;
> Anson Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; A.s.
> Dong <aisheng.dong@nxp.com>
> Subject: [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
> 
> This is a resend patch series.
> See the original one from here:
> [PATCH V3 00/10] clk: add imx7ulp clk support
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flk
> ml.org%2Flkml%2F2018%2F1%2F19%2F351&data=02%7C01%7Caisheng.dong
> %40nxp.com%7C2158b9d83b9442c6fa8208d572e5b5f5%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C636541253280073434&sdata=VQ7%2Fx08X5
> 9AQ8SoYna%2Bw4HnErty3vR5Zwh2dp7FzJqU%3D&reserved=0
> No function changes but remove the last one which is used for the test.
> Rebased against clk-next branch.
> 
> This patch series intends to add imx7ulp clk support.
> 
> i.MX7ULP Clock functions are under joint control of the System Clock
> Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> Core Mode Controller (CMC)1 blocks
> 
> The clocking scheme provides clear separation between M4 domain and A7
> domain. Except for a few clock sources shared between two domains, such
> as the System Oscillator clock, the Slow IRC (SIRC), and and the Fast IRC clock
> (FIRCLK), clock sources and clock management are separated and contained
> within each domain.
> 
> M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> 
> Note: this series only adds A7 clock domain support as M4 clock domain will
> be handled by M4 seperately.
> 
> Change Log:
> v2->v3:
>  * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible racy
>    Others no changes.
> 
> v1->v2:
>  * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
>  * use clk_hw apis to register clocks
>  * use of_clk_add_hw_provider
>  * split the clocks register process into two parts: early part for possible
>    timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
>    the left normal peripheral clocks registered by a platform driver.
> 
> 
> Dong Aisheng (9):
>   clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
>   clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
>   clk: imx: add pllv4 support
>   clk: imx: add pfdv2 support
>   clk: imx: add composite clk support
>   dt-bindings: clock: add imx7ulp clock binding doc
>   clk: imx: make mux parent strings const
>   clk: imx: implement new clk_hw based APIs
>   clk: imx: add imx7ulp clk driver
> 
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++
>  drivers/clk/clk-divider.c                          | 152 ++++++++++++++
>  drivers/clk/clk-fractional-divider.c               |  10 +
>  drivers/clk/imx/Makefile                           |   6 +-
>  drivers/clk/imx/clk-busy.c                         |   2 +-
>  drivers/clk/imx/clk-composite.c                    |  90 ++++++++
>  drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
>  drivers/clk/imx/clk-imx7ulp.c                      | 232 +++++++++++++++++++++
>  drivers/clk/imx/clk-pfdv2.c                        | 207 ++++++++++++++++++
>  drivers/clk/imx/clk-pllv4.c                        | 188 +++++++++++++++++
>  drivers/clk/imx/clk.c                              |  22 ++
>  drivers/clk/imx/clk.h                              |  92 +++++++-
>  include/dt-bindings/clock/imx7ulp-clock.h          | 108 ++++++++++
>  include/linux/clk-provider.h                       |  17 ++
>  14 files changed, 1180 insertions(+), 10 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 drivers/clk/imx/clk-composite.c  create mode 100644
> drivers/clk/imx/clk-imx7ulp.c  create mode 100644 drivers/clk/imx/clk-
> pfdv2.c  create mode 100644 drivers/clk/imx/clk-pllv4.c  create mode 100644
> include/dt-bindings/clock/imx7ulp-clock.h
> 
> --
> 2.7.4
