Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755009AbeCSCGY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:06:24 -0400
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:40960
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754383AbeCSCGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:06:20 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
Thread-Topic: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
Thread-Index: AQHTvdYyxJUAoQnkQkGbwl91uXL3xqPWaiGAgABngKA=
Date: Mon, 19 Mar 2018 02:06:16 +0000
Message-ID: <AM3PR04MB1315193720D4160F00FF0590F5D40@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521272215-22514-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DJ5-AdudGhk6VfTazJXBpReGHW-bxKM1=bLZO90PnXsg@mail.gmail.com>
In-Reply-To: <CAOMZO5DJ5-AdudGhk6VfTazJXBpReGHW-bxKM1=bLZO90PnXsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB404;7:H6Un/MsDHRvQBfEApWj0+pI+zXmtxr80sIB15jhprrWE/RPeYHkEh9D3uxTdaYTRMT4BolJvmrE1pRPs3yapowpWHNHdxCSALynVeMLyXnvp9ck8vvqlyXxeyXNud6s4Es3AAuXcnpyURRBbKcCYy6DD3Ara7FGB/hJecj5Kq26E8IMgvYhf7q7DOSlKPeV+R6pi0Y8mpJJh/j7c+9ynsHVu6ORYteaRHTOB1ekbSfdROAIR39XuPS4uTx/TLmDZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7870ca39-3d6e-4d52-d50f-08d58d3dffd4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB404;
x-ms-traffictypediagnostic: AM3PR04MB404:
x-microsoft-antispam-prvs: <AM3PR04MB404231C681C42507DE16D45F5D40@AM3PR04MB404.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB404;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB404;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(13464003)(3846002)(6116002)(7736002)(74316002)(305945005)(99286004)(2906002)(3280700002)(5250100002)(106356001)(3660700001)(6246003)(66066001)(68736007)(5660300001)(105586002)(86362001)(54906003)(55016002)(316002)(8676002)(25786009)(81156014)(81166006)(1411001)(229853002)(9686003)(6916009)(6436002)(2900100001)(97736004)(8936002)(186003)(2950100002)(26005)(14454004)(6506007)(53546011)(76176011)(39060400002)(478600001)(102836004)(4326008)(33656002)(53936002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB404;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: gOiiHWUyuIpZVJNYgNpM+lSBIqPaeMREIYs/jjfbZndOhKW/zZAbkfNhRYut05q11odg/Vt9nmeT7VpoA7wqWJS9z8/3abR6MsXQzpL9SIj/QwHU+qtft3XbOHubBHk6kdehPu8hQuM7+NqBcpoFQQpOLlA65GbNSqlazEowyFvutKXfuW4N1Pr39jfCYK/5exvnNdh8uG58dCbzm7Sv7TjlS3UERIU78FALhU/D3k+csjIRRiS/8VWrVVkVttFPewoDYgwi7Et2WOXm1UxQG51Exp2fFIcc1q9A9z7A/3WdgMsJs8mF8w3qTxMCtX+jZ5sWTiLTE8VUcznbYaCWNA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7870ca39-3d6e-4d52-d50f-08d58d3dffd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 02:06:16.6515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB404
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2J26U80025093

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Monday, March 19, 2018 3:54 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; dl-linux-imx
> <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
> 
> Hi Anson,
> 
> On Sat, Mar 17, 2018 at 4:36 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add i.MX7S/D anatop vdd1p2 regulator.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx7s.dtsi | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi index cd6964f..1210028 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -565,6 +565,21 @@
> >                                         anatop-max-voltage =
> <1200000>;
> >                                         anatop-enable-bit = <0>;
> >                                 };
> > +
> > +                               reg_1p2:
> regulator-vdd1p2@30360220 {
> > +                                       reg = <0x30360220>;
> > +                                       compatible =
> "fsl,anatop-regulator";
> > +                                       regulator-name = "vdd1p2";
> > +                                       regulator-min-microvolt =
> <1100000>;
> > +                                       regulator-max-microvolt =
> <1300000>;
> > +                                       anatop-reg-offset =
> <0x220>;
> > +                                       anatop-vol-bit-shift = <8>;
> > +                                       anatop-vol-bit-width = <5>;
> > +                                       anatop-min-bit-val =
> <0x14>;
> > +                                       anatop-min-voltage =
> <1100000>;
> > +                                       anatop-max-voltage =
> <1300000>;
> > +                                       anatop-enable-bit = <0>;
> > +                               };
> 
> Do you also plan to add a consumer for it?
 
This regulator is mainly for USB HSIC, the consumer will be added when HSIC
do upstream.

Anson.
