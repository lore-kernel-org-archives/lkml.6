Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeCRCXY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 22:23:24 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:38240
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752913AbeCRCXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 22:23:21 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
Thread-Topic: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
Thread-Index: AQHTvecGA2WAr97bW0y2mrrIxoc0m6PUg4QAgAC/RZA=
Date: Sun, 18 Mar 2018 02:23:18 +0000
Message-ID: <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
In-Reply-To: <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1506;7:OgSbfjLyPsHwuJhE8gNNhLNrEIYJSTzPnDRs5Y9owUp3Sfi95l07O+n90DJ7iBjMPa8ImLEVifECOsn1E268LvIjIra5HvV4vxNkz6cdNIrkev/3jtibBlp06m06P/+rUIGYLjlDqMSoUeLKNJhR/LOQnNZhDaD62Kh9rpY+07BzNRHDPrrU11lueR/ZLvxGlRdXvpfdcdoHtdoZrqsO5QL9GwodEh2Z13UWd2UcqsGSnpydp6X2GW3p9W2GRB6w
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4db024ea-fdf4-44fc-620a-08d58c773669
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1506;
x-ms-traffictypediagnostic: AM3PR04MB1506:
x-microsoft-antispam-prvs: <AM3PR04MB1506A63B8C95D70BB47E64A7F5D50@AM3PR04MB1506.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(101931422205132)(258649278758335)(45079756050767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM3PR04MB1506;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1506;
x-forefront-prvs: 06157D541C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(85664002)(13464003)(6436002)(9686003)(3846002)(33656002)(39060400002)(68736007)(6916009)(2950100002)(102836004)(53936002)(478600001)(45080400002)(966005)(2900100001)(6246003)(97736004)(25786009)(5660300001)(6116002)(6306002)(81156014)(81166006)(8676002)(316002)(229853002)(1411001)(15650500001)(55016002)(59450400001)(8936002)(4326008)(7416002)(5250100002)(186003)(14454004)(66066001)(2906002)(76176011)(575784001)(86362001)(99286004)(106356001)(54906003)(74316002)(53546011)(7736002)(105586002)(6506007)(26005)(3660700001)(7696005)(3280700002)(305945005)(32563001)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1506;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qQXHrK91QIQ0Qs+YkpkKKzWbOik8mwEEABxOXMbB4m0f1jURPfiidc1jHiH3sjyTBU+j9ddjdXLACTpUBcWAm8EwS8VJlrvhOdG96DDHZNGZDzFpjvYvCFjLORAW1SeblSt/L9pshD5sFCtLxAUp06pT9q+pNB7BB4b3GnLAzVcMx4PNe/tJPP0ltH24gzVCnx1Iq1nU0mlIUfwdvS6O2BaM4UvjDbo0zuKkff2wRxMtnHxD04NgY55gLWHPWEqD4hiWneXcskTNGw3VH3PnQWK/CjFH2s/SR9YgusYrD6AbfRR8r3uBKtvDSjfujceVEpdUszP0fg/2gZ8KhVxhIA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db024ea-fdf4-44fc-620a-08d58c773669
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2018 02:23:18.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1506
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2I2NY5j013651



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Saturday, March 17, 2018 10:53 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Russell King - ARM Linux <linux@armlinux.org.uk>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
> 
> Hi Anson,
> 
> On Sat, Mar 17, 2018 at 3:57 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Update sw1a/vldo4's voltage range according to latest pfuze3000
> > datasheet from:
> >
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcach
> >
> e.freescale.com%2Ffiles%2Fanalog%2Fdoc%2Fdata_sheet%2FPF3000.pdf%3Ffsr
> >
> ch%3D1%26sr%3D1%26pageNum%3D1&data=02%7C01%7CAnson.Huang%40n
> xp.com%7Cc
> >
> 9614ae26f9443c2d0ae08d58c16cd8a%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0
> > %7C1%7C636568951923456037&sdata=OeM%2B3xPNlm9OETpZcrvG65LjH%
> 2Fp4CRZvyD
> > HT819kuPk%3D&reserved=0
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi  | 2 +-
> > arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
> >  arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
> >  arch/arm/boot/dts/imx7d-sdb.dts         | 6 +++---
> >  arch/arm/boot/dts/imx7s-warp.dts        | 2 +-
> >  5 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > index 53b3eac..1de0a0f 100644
> > --- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > +++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> > @@ -142,7 +142,7 @@
> >                 regulators {
> >                         sw1a_reg: sw1a {
> >                                 regulator-min-microvolt = <700000>;
> > -                               regulator-max-microvolt = <1475000>;
> > +                               regulator-max-microvolt =
> <3300000>;
> 
> This change does not look like a safe thing to do without carefully checking each
> one of the board schematics.
> 
> Even if the regulator itself is capable of driving a higher voltage, it does not
> mean that the circuitry that consumes such regulator is allowed to receive the
> higher voltages.
 
I thought the max value here means the capability of regulator itself, like the internal
anatop LDO regulator VDD_CORE, the max value defined in dtsi is 1.45V, but out i.MX6
SoCs can NOT receive to voltage higher than 1.3V.

The default setting of PMIC output is controlled by its OTP and the OTP value should
consider the board design, the rest of voltage setting should be taken care by device driver.
Here I think the max means PMIC's capability.

Anson.
