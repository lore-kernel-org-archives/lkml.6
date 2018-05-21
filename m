Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeEUB6b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 21:58:31 -0400
Received: from mail-ve1eur01on0058.outbound.protection.outlook.com ([104.47.1.58]:22336
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751837AbeEUB60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 21:58:26 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx7d: use operating-points-v2 for cpu
Thread-Topic: [PATCH] ARM: dts: imx7d: use operating-points-v2 for cpu
Thread-Index: AQHT7NGhvm49ZHWYj0e/fDj7/+3s8KQ4mLgAgADb76A=
Date: Mon, 21 May 2018 01:58:21 +0000
Message-ID: <AM3PR04MB1315E332CBFDA4151F6F3FA8F5950@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526446097-7111-1-git-send-email-Anson.Huang@nxp.com>
 <20180520125048.GX26863@dragon>
In-Reply-To: <20180520125048.GX26863@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1409;7:H9zGOFlr6pt2kJLgm6Lmfx1/Y49G42DTRPFGx406GLEbOT4Wf9/70Pmh/+I+oDvriDUYpsd2PMQy+MF+q6PSWulf5xk6F8a+De5UWUZSjk0Ib8Ul+E9GyHLXZpjiIUnGj76bieF+jEwv4/Q9XBJBwsWvuHPscIkNaiR2t8O0Beu73OIE6Gjeyhq0BVaVMwCI2iR5YGhJFSMaWZwe04tiT7QM5Llcx0C0/cP0Mv+3dum0dOnOnQQWeN2z0DNJyXzm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1409;
x-ms-traffictypediagnostic: AM3PR04MB1409:
x-microsoft-antispam-prvs: <AM3PR04MB140912A410858A96B7754AEDF5950@AM3PR04MB1409.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1409;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1409;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(366004)(39860400002)(396003)(199004)(189003)(13464003)(486006)(446003)(11346002)(106356001)(97736004)(478600001)(316002)(25786009)(105586002)(5660300001)(14454004)(66066001)(476003)(86362001)(54906003)(74316002)(53936002)(53546011)(8936002)(102836004)(6246003)(9686003)(76176011)(3846002)(3280700002)(7696005)(6506007)(59450400001)(2906002)(7736002)(2900100001)(44832011)(8676002)(3660700001)(55016002)(81166006)(81156014)(6916009)(68736007)(99286004)(6116002)(33656002)(6436002)(5250100002)(186003)(305945005)(229853002)(4326008)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1409;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vBqmdfNxPKYHpOvR2HokLbaqw5o1c8SCX9BzhVHNvIZajZsYvEcaJmZ2MtHNvssEuewYkxeeyAWSu87/bZs7/FNn2BRvqau9ISmL0VYpo3LzPLZCvTVXnqlD6tjDMYgu5U/fphfWwuBokTjpKgdPpW7QmT1xK4Oo1KrdSqBA3KRzIb+t+w4XmWtjV6HAGJ8E
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 82259c91-c130-4586-64e0-08d5bebe54b8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82259c91-c130-4586-64e0-08d5bebe54b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 01:58:21.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1409
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4L1wbjI030330



Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Sunday, May 20, 2018 8:51 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> robh+dt@kernel.org; mark.rutland@arm.com; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ARM: dts: imx7d: use operating-points-v2 for cpu
> 
> On Wed, May 16, 2018 at 12:48:17PM +0800, Anson Huang wrote:
> > This patch uses "operating-points-v2" instead of "operating-points" to
> > be more fit with cpufreq-dt driver.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx7d.dtsi | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx7d.dtsi
> > b/arch/arm/boot/dts/imx7d.dtsi index 4c9877e..28980c8 100644
> > --- a/arch/arm/boot/dts/imx7d.dtsi
> > +++ b/arch/arm/boot/dts/imx7d.dtsi
> > @@ -9,12 +9,8 @@
> >  / {
> >  	cpus {
> >  		cpu0: cpu@0 {
> > -			operating-points = <
> > -				/* KHz	uV */
> > -				996000	1075000
> > -				792000	975000
> > -			>;
> >  			clock-frequency = <996000000>;
> > +			operating-points-v2 = <&cpu0_opp_table>;
> >  		};
> >
> >  		cpu1: cpu@1 {
> > @@ -22,6 +18,24 @@
> >  			device_type = "cpu";
> >  			reg = <1>;
> >  			clock-frequency = <996000000>;
> > +			operating-points-v2 = <&cpu0_opp_table>;
> > +		};
> > +	};
> > +
> > +	cpu0_opp_table: opp_table0 {
> 
> Hyphen is recommended in node name.  Also the suffix 0 doesn't mean too
> much here.  That said, a better node name would be 'opp-table'.
> 
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +
> > +		opp-792000000 {
> > +			opp-hz = /bits/ 64 <792000000>;
> > +			opp-microvolt = <975000>;
> > +			clock-latency-ns = <150000>;
> > +		};
> 
> We recommend to have a newline between nodes.
> 
> I fixed them all and applied the patch.
> 
> Shawn
 
Thanks Shawn.

Anson.



> 
> > +		opp-996000000 {
> > +			opp-hz = /bits/ 64 <996000000>;
> > +			opp-microvolt = <1075000>;
> > +			clock-latency-ns = <150000>;
> > +			opp-suspend;
> >  		};
> >  	};
> >
> > --
> > 2.7.4
> >
