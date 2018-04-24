Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeDXCKG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:10:06 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:48096
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932733AbeDXCKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:10:02 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Topic: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Index: AQHT2vNvaoueJMByHUOpWSeGxuLWrqQPLIng
Date: Tue, 24 Apr 2018 02:09:58 +0000
Message-ID: <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB337;7:j1h+9+R1wB7tEu55Skr4z7X41nQLGZN9aC11ul2yeGLDaS1HCU+uUue7KYT+fbXkFOpW0T1QDOvyKByHQjw/KZQrwtAh6ncMnmS2Qz7qo2apJ9CmSJhn4I55Mco32nimqV8x6hnQONSzYfsnRRAAT1cGR2yyYK2m/CnXWUMGIqfuoRcJeCnSEa2chPU/8fmLAhqGO3+XLoMXpVPLXfYqK//HpC0PQfKJdSfnc+MJ33PRSdL4hG7pJHOYgC544YzF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB337;
x-ms-traffictypediagnostic: AM3PR04MB337:
x-microsoft-antispam-prvs: <AM3PR04MB3373FDE2387C24005E4E721F5880@AM3PR04MB337.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB337;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB337;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(13464003)(11346002)(86362001)(66066001)(6506007)(53546011)(102836004)(476003)(8936002)(9686003)(54906003)(55016002)(81166006)(8676002)(26005)(6246003)(316002)(53936002)(99286004)(39060400002)(5660300001)(186003)(7696005)(446003)(25786009)(76176011)(1411001)(305945005)(74316002)(7736002)(6436002)(4326008)(3280700002)(33656002)(3660700001)(5250100002)(229853002)(44832011)(2900100001)(2906002)(14454004)(6116002)(3846002)(6916009)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB337;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: 2UetQmUkBBiIJkSpbxpb4iVtbY4BnPl9eXktA4q2x8sjLOAoVBQc+5f+iNJmWwFHwMaN+Ff+g4XYO4ogJ8eFDnCd+S5ATQJomyhlVCTc/mW3ihP7qp3JG8OPAoFOewL3z077EGV/l8G5IVlQFv+WFEdgQTEM8voPud3HBSRjbsJyfPxhPZIngXJs8gHPhIhn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 20240c26-3035-43ea-0618-08d5a9887b2b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20240c26-3035-43ea-0618-08d5a9887b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 02:09:58.8315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB337
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3O2ACbs026834

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Monday, April 23, 2018 7:09 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> 
> Hi Anson,
> 
> On Mon, Apr 23, 2018 at 12:46 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add FEC support on i.MX6SX Sabre Auto board.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6sx-sabreauto.dts | 70
> ++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 812f40b..eadd483 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -41,6 +41,40 @@
> >         clock-frequency = <24576000>;
> >  };
> >
> > +&fec1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_enet1_1>;
> > +       phy-mode = "rgmii";
> > +       phy-handle = <&ethphy1>;
> > +       pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
> 
> This property does not exist in mainline, only in the NXP vendor kernel.

Ah, yes, thanks for pointing out this issue, I just removed it and the function is still working,
already sent out V2 patch set, thanks.

Anson.
 
