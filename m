Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeEFGJK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:09:10 -0400
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:2304
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750824AbeEFGJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:09:08 -0400
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
Subject: RE: [PATCH V6 4/7] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Topic: [PATCH V6 4/7] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Index: AQHT5Eu1n/JnsdEyrU6qizQFDpqnI6QhC6CAgAEr55A=
Date: Sun, 6 May 2018 06:08:57 +0000
Message-ID: <AM3PR04MB1315664F28DCADA2448C1FFAF5840@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5B8xrnjyoPoj0J_+WM6TBbE1Gbq8HChdTCQ=UpKYyRBmQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B8xrnjyoPoj0J_+WM6TBbE1Gbq8HChdTCQ=UpKYyRBmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1171;7:NVgbNc353iUcA/62gi7fc3AgXMEG0KiUz4rTy2Tym3QdmDfLjLnjxf5rHsamgig+Eu3hfgzRwCBtgHRVKlHgBs+Z/PKXHbdi+et/L8fRAdbZnYU2Lrll/4C1BaQEdszqFrkwLdDjcaz5jTiyxBQ7R0iFW6r+fqVo091EZTmosbd/46jziQsLQT9bQJpgplYLCpVcdsj8FhyLAAhwlF4/MbCcGl9E6KFs+kMgcWWbYYp8DxIoZDUfmaT8LuHNh8eP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1171;
x-ms-traffictypediagnostic: AM3PR04MB1171:
x-microsoft-antispam-prvs: <AM3PR04MB1171463C0069BEA3E3DF42D4F5840@AM3PR04MB1171.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(101931422205132)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM3PR04MB1171;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1171;
x-forefront-prvs: 06640999CA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(13464003)(189003)(199004)(33656002)(316002)(6116002)(3846002)(1411001)(7736002)(76176011)(102836004)(2900100001)(186003)(106356001)(7696005)(14454004)(74316002)(53546011)(26005)(6506007)(68736007)(105586002)(6916009)(53936002)(44832011)(97736004)(66066001)(86362001)(478600001)(3660700001)(6436002)(6246003)(3280700002)(476003)(39060400002)(2906002)(54906003)(486006)(11346002)(5660300001)(446003)(5250100002)(8936002)(9686003)(8676002)(55016002)(4326008)(99286004)(81166006)(81156014)(305945005)(229853002)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1171;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 00nOBgFo8Smgk3+1w5YlvXDveeHKD+2ymlZlZBVR/B1ieKNzHxhouTBl3LOAwN5t6kkf5Voi7mVre8C8OVEWMOC1up1+zw/Ujdr8bIDZbTqQg8RznYn4knu3OIpdwKXE6ctuhRQe4V+LkOty4RE3Gw6CmWbPjOTMxpa1HStV77BEEzIg4+c/uUACU/JPq0VJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: df0cda12-0a17-46e9-9ccd-08d5b317da72
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0cda12-0a17-46e9-9ccd-08d5b317da72
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2018 06:08:57.2575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1171
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4669JCf006200

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Saturday, May 5, 2018 8:11 PM
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
> Subject: Re: [PATCH V6 4/7] ARM: dts: imx6sx-sabreauto: add fec support
> 
> On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add FEC support on i.MX6SX Sabre Auto board.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> 
> Again, it is not clear who is the author here. Is it Fugang or yourself?
 
Same story explained in patch V6 7/7.

> 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V5:
> >         use "gpios" instead of "enable-gpio".
> >  arch/arm/boot/dts/imx6sx-sabreauto.dts | 80
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 4d41b4d..7dda741 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -18,6 +18,17 @@
> >                 reg = <0x80000000 0x80000000>;
> >         };
> >
> > +       reg_fec: fec_io_supply {
> > +               compatible = "regulator-gpio";
> > +               regulator-name = "1.8V_1.5V_FEC";
> > +               regulator-min-microvolt = <1500000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               states = <1500000 0x0 1800000 0x1>;
> > +               gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
> > +               vin-supply = <&sw2_reg>;
> > +               enable-active-high;
> > +       };
> 
> I still find this confusing.
> 
> There is no consumer for reg_fec in, so it seems you are relying on the fact that
> the kernel regulator core will disable reg_fec to put the regulator in the state
> you require.

Adding consumer for reg_fec in NOT available in this patch, as FEC driver itself
does NOT support setting IO voltage based on setting of dtb, so if want to add
consumer, need to patch FEC driver as well.

As I explained before, this reg is for adjusting IO voltage between 1.5V and 1.8V,
and FEC driver can work on both of them, current FEC driver can work well no matter
if it is 1.5V or 1.8V, to avoid confusion, I think I can remove this reg_fec in this patch series,
let FEC driver work with default setting of this GPIO regulator, we can add reg_fec support
after FEC driver supports adjusting IO voltage. Thanks.

Anson.
