Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEFGEU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:04:20 -0400
Received: from mail-ve1eur01on0043.outbound.protection.outlook.com ([104.47.1.43]:31680
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750824AbeEFGER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:04:17 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Haibo Chen <haibo.chen@freescale.com>, Andy Duan <fugang.duan@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
Thread-Topic: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
Thread-Index: AQHT5Eu+7BQKgbFdhEu7laYNHJH8aKQhB4KAgAEu1TA=
Date: Sun, 6 May 2018 06:04:11 +0000
Message-ID: <AM3PR04MB1315A1673823C8B2BAA3169AF5840@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5D1H4+w=FGh+8icBziunDzM4jN7peA=mirGb9RBHHqMsg@mail.gmail.com>
In-Reply-To: <CAOMZO5D1H4+w=FGh+8icBziunDzM4jN7peA=mirGb9RBHHqMsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB276;7:6qVhDhuTYgktcpgK9WG+2G9TdNA5dzy0RR7Wp1/5W5mVze9AOZKDdtY/oGpknaDZvdXvkRlL86RdN7tGdn0s3CVHww6gjtN8d6/f1xFg6/5H0sG2RC69CyhawVDfdInQOl0rdTrALPPZd104TcRvUdlfJq3iQ5Eu4c1koAUnSI5twUXY7nOk+fM0JVCCpKn4UHtURiuJ86PXxuiqCNJ8pUv81ilSB5DMoS2qhGCP6DsGo67HQwFTvAsVoMcG1eAU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB276;
x-ms-traffictypediagnostic: AM3PR04MB276:
x-microsoft-antispam-prvs: <AM3PR04MB2760930011E4B83FCD053E3F5840@AM3PR04MB276.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(101931422205132)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB276;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB276;
x-forefront-prvs: 06640999CA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(366004)(396003)(39860400002)(376002)(199004)(189003)(13464003)(6506007)(1411001)(446003)(44832011)(105586002)(53546011)(66066001)(2900100001)(11346002)(76176011)(478600001)(5660300001)(486006)(2906002)(7736002)(106356001)(102836004)(33656002)(8676002)(55016002)(9686003)(99286004)(7696005)(14454004)(305945005)(39060400002)(81156014)(6916009)(81166006)(6436002)(68736007)(229853002)(25786009)(6116002)(3846002)(8936002)(575784001)(476003)(3660700001)(53936002)(86362001)(54906003)(97736004)(26005)(3280700002)(4326008)(74316002)(186003)(5250100002)(316002)(6246003)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB276;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pXTJSiHUIeGlLAtu5iyuAkb1LgEueYoaAimrqK1pENaT1JjhnF0vezVsq3oItZYNOSNc/zU4g63Lhv/UUAsHAggIw10uu6TRLEiF1UYaf3+JDt9Jywr04QQAgVP34M4IyxUx9ZmAYHFoKhrOxy8+9Wc76NYjy+KKvumOIwd9Nf8j2ftfx11A6DP5hEF/WjTP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 026c56a3-b4ff-48ba-3771-08d5b3173005
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026c56a3-b4ff-48ba-3771-08d5b3173005
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2018 06:04:11.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4664RXi006191

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Saturday, May 5, 2018 7:56 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Haibo Chen <haibo.chen@freescale.com>; Andy Duan
> <fugang.duan@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; Robin Gong
> <yibin.gong@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
> screen support
> 
> Hi Anson,
> 
> On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add egalax touch screen support on i2c2 bus.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> 
> Is Haibo the author of this patch? If so, his name should appear in the From field.

I made this patch based on NXP kernel tree, Haibo is the original author of this
feature, but the original patch can NOT be applied directly, I have to refine the patch
to meet the upstream requirement, so I added him as another signed-off tag,
to avoid confuse, I can remove this sign-off in next patch version. Same story
for other patches in this series.

> 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V5:
> >         improve pinctrl node name and touchscreen node name.
> >  arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 1dc5b58..3fe41d3 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -122,6 +122,12 @@
> >  };
> >
> >  &iomuxc {
> > +       pinctrl_egalax_int: egalax-intgrp {
> > +               fsl,pins = <
> > +                       MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22
> 0x80000000
> > +               >;
> > +       };
> > +
> >         pinctrl_enet1: enet1grp {
> >                 fsl,pins = <
> >                         MX6SX_PAD_ENET1_MDIO__ENET1_MDIO
> 0xa0b1
> > @@ -264,6 +270,16 @@
> >         pinctrl-0 = <&pinctrl_i2c2>;
> >         status = "okay";
> >
> > +       egalax_touchscreen@4 {
> 
> Should be touchscreen@4.
 
Will improve it in next patch version.

Anson.
