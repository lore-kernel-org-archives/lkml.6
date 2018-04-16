Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbeDPIZ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:25:58 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:52480
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752145AbeDPIZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:25:56 -0400
From: Anson Huang <anson.huang@nxp.com>
To: "A.s. Dong" <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
Thread-Topic: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
Thread-Index: AQHTvQz2YhmgOP+1hkyYZfneeN1cTKPSqJ3ggDCWR2A=
Date: Mon, 16 Apr 2018 08:25:48 +0000
Message-ID: <AM3PR04MB1315677CAB91C4236AFAB03EF5B00@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521190471-25242-1-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB306ED8D196C18858B5B368480D70@AM3PR04MB306.eurprd04.prod.outlook.com>
In-Reply-To: <AM3PR04MB306ED8D196C18858B5B368480D70@AM3PR04MB306.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0583;7:D6n2VodTGk5u69G0DsV+EmwthHmqFYpsQzB5v2NQuIk8eDbwogl8Vkwq+8nigj/OnFxDgUG7ZSqngAllPZUCqo8miHpJpkAOg4zb1McT6XdtMCKX7npFiZiCdctjYO9wWJW16OGRJJhBDSyZbM2KXC8Yk+XnGpnfAUDqVD1EjuSe3dVRDDAKcgph8nOqpK0aJdK0zpZnsQeies/J3yIY9C0fD4yaAx1238PVuzXO3WiYys26GHZ2iUIT07ubbdi4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0583;
x-ms-traffictypediagnostic: AM3PR04MB0583:
x-microsoft-antispam-prvs: <AM3PR04MB0583367961E5FE37BE062B0BF5B00@AM3PR04MB0583.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB0583;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0583;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(39860400002)(376002)(346002)(13464003)(189003)(199004)(6116002)(2201001)(74316002)(25786009)(2906002)(26005)(53936002)(6436002)(2900100001)(5250100002)(68736007)(8936002)(102836004)(305945005)(6506007)(53546011)(44832011)(7696005)(7736002)(3846002)(97736004)(316002)(76176011)(81166006)(8676002)(81156014)(99286004)(476003)(446003)(33656002)(3280700002)(2501003)(486006)(11346002)(478600001)(106356001)(105586002)(229853002)(66066001)(4326008)(9686003)(55016002)(5660300001)(110136005)(14454004)(54906003)(6246003)(86362001)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0583;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mztHiNkDYgD2m7KdmKYnNXrp2krVNsA0s9c4CztZJrl4tnajZxGVHE+fmwYVhXW1xh+xVTKlUGsJugb8NbmOCYQ3u/T0Fdv0yfhfdUeMV1fVKO2v120jfQouelcQ+47iF1OeO6sg4GZDg/aIq0vvkwQbRP7tfGGK5LpXMOfrX81o14Kn3BffnxWjxQ9CwSJ2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c7fb6ca8-66f9-4d12-39d0-08d5a373a848
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fb6ca8-66f9-4d12-39d0-08d5a373a848
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 08:25:48.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0583
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3G8Q4E9015301

Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: A.s. Dong
> Sent: Friday, March 16, 2018 6:28 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> robh+dt@kernel.org; mark.rutland@arm.com; linux@armlinux.org.uk
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
> 
> > -----Original Message-----
> > From: Anson Huang [mailto:Anson.Huang@nxp.com]
> > Sent: Friday, March 16, 2018 4:55 PM
> > To: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > linux@armlinux.org.uk
> > Cc: dl-linux-imx <linux-imx@nxp.com>;
> > linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
> >
> > Add support for imx7d-sdb board's gpio keys:
> >
> > S1(FUNC1): KEY_VOLUMEUP
> > S3(FUNC2): KEY_VOLUMEDOWN
> >
> 
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Regards
> Dong Aisheng
> 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx7d-sdb.dts | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-sdb.dts
> > b/arch/arm/boot/dts/imx7d- sdb.dts index 7f241af..e47b5b2 100644
> > --- a/arch/arm/boot/dts/imx7d-sdb.dts
> > +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> > @@ -52,6 +52,24 @@
> >  		reg = <0x80000000 0x80000000>;
> >  	};
> >
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > +
> > +		volume-up {
> > +			label = "Volume Up";
> > +			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_VOLUMEUP>;
> > +		};
> > +
> > +		volume-down {
> > +			label = "Volume Down";
> > +			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_VOLUMEDOWN>;
> > +		};
> > +	};
> > +
> >  	spi4 {
> >  		compatible = "spi-gpio";
> >  		pinctrl-names = "default";
> > @@ -519,6 +537,12 @@
> >  			>;
> >  		};
> >
> > +		pinctrl_gpio_keys: gpio_keysgrp {
> > +			fsl,pins = <
> > +				MX7D_PAD_SD2_RESET_B__GPIO5_IO11
> > 	0x59
> > +				MX7D_PAD_SD2_WP__GPIO5_IO10
> > 	0x59
> > +			>;
> > +		};
> >
> >  		pinctrl_hog: hoggrp {
> >  			fsl,pins = <
> > --
> > 2.7.4
