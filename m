Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeBBPdz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:33:55 -0500
Received: from mail-he1eur01on0073.outbound.protection.outlook.com ([104.47.0.73]:54912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751470AbeBBPdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:33:46 -0500
From: Frank Li <frank.li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
CC: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Ian Ray <ian.ray@ge.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx6q-bx50v3: Enable secure-reg-access
Thread-Topic: [PATCH] ARM: dts: imx6q-bx50v3: Enable secure-reg-access
Thread-Index: AQHTjhrzoCixc+F7oE+0g5P6QUGo66OQz8sAgACKJ9A=
Date: Fri, 2 Feb 2018 15:33:40 +0000
Message-ID: <HE1PR04MB2091FB16A11EE4A02940EB6088F90@HE1PR04MB2091.eurprd04.prod.outlook.com>
References: <20180115160722.17206-1-sebastian.reichel@collabora.co.uk>
 <20180202071819.GE25699@dragon>
In-Reply-To: <20180202071819.GE25699@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.88.168.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1020;7:YHNdZOt2MwdTiBBLBy1JsnkYVzTXPrcjtpuKXCCYE12QAeEOZPXQaYLbj61bPllEP+IIUnoQ+PmqYgTtYL7emkcoEQ5pCUQvfX4L+YMZeIShdZDwBYfIsMOpvgq3KC8k2xulpzTgYWDJMTGHICpdBRwVGyyH/i38nCX+utb5K0/IcmKArq+9W2yDILFNFfhrE6btU3oKNh3NuUgk+7/3vGD6+3HXV5RqTit97Xh5QB0z0fv2L+pfnU5WzkNhI2Nz
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(396003)(366004)(39860400002)(189003)(13464003)(199004)(2950100002)(99286004)(33656002)(55016002)(9686003)(5660300001)(6436002)(316002)(68736007)(110136005)(4326008)(54906003)(2900100001)(6246003)(229853002)(5250100002)(97736004)(53546011)(6506007)(7696005)(76176011)(102836004)(59450400001)(14454004)(478600001)(53936002)(8936002)(106356001)(25786009)(3660700001)(3280700002)(81166006)(81156014)(66066001)(86362001)(105586002)(8676002)(2906002)(7736002)(305945005)(6116002)(74316002)(26005)(3846002)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1020;H:HE1PR04MB2091.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efb28c92-abfc-46f7-c274-08d56a5255f8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:HE1PR04MB1020;
x-ms-traffictypediagnostic: HE1PR04MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com;
x-microsoft-antispam-prvs: <HE1PR04MB10209E20097718CA7476A86688F90@HE1PR04MB1020.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(106981052589767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB1020;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1020;
x-forefront-prvs: 05715BE7FD
x-microsoft-antispam-message-info: JG5w5otdlhKrAbLRz0tS8eAxEYGPxo9ll7fUGJnuN6pRPBOATJh5L891NupjukorKgX4XWlmpQHEBoA0Qwr0Fg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb28c92-abfc-46f7-c274-08d56a5255f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 15:33:40.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1020
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w12FXwJv018868



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, February 02, 2018 1:18 AM
> To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Cc: Sascha Hauer <kernel@pengutronix.de>; Frank Li <frank.li@nxp.com>;
> Fabio Estevam <fabio.estevam@nxp.com>; Ian Ray <ian.ray@ge.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ARM: dts: imx6q-bx50v3: Enable secure-reg-access
> 
> + Frank
> 
> On Mon, Jan 15, 2018 at 05:07:22PM +0100, Sebastian Reichel wrote:
> > From: Peter Senna Tschudin <peter.senna@collabora.com>
> >
> > Add secure-reg-access on device tree include file for Bx50 devices to
> > enable PMU and hardware counters for perf.
> >
> > Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  arch/arm/boot/dts/imx6q-bx50v3.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> > b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> > index 86cfd4481e72..ccaaee83e2fa 100644
> > --- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> > +++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> > @@ -43,6 +43,13 @@
> >  #include "imx6q-ba16.dtsi"
> >
> >  / {
> > +	soc {
> > +		pmu {
> > +			compatible = "arm,cortex-a9-pmu";
> > +			secure-reg-access;
> 
> I'm not sure this could be a board level configuration.  Shouldn't this property
> just be added into pmu node in imx6qdl.dtsi?

I agree. It should be in imx6qdl.dtsi

Frank Li

> 
> Shawn
> 
> > +		};
> > +	};
> > +
> >  	clocks {
> >  		mclk: clock@0 {
> >  			compatible = "fixed-clock";
> > --
> > 2.15.1
> >
