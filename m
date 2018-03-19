Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754941AbeCSCJq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:09:46 -0400
Received: from mail-he1eur01on0071.outbound.protection.outlook.com ([104.47.0.71]:64757
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754417AbeCSCJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:09:43 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
 source
Thread-Topic: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
 source
Thread-Index: AQHTvn3WGbhVBV9tE0ety9UiOZu6CKPV9hmAgADa90A=
Date: Mon, 19 Mar 2018 02:09:39 +0000
Message-ID: <AM3PR04MB1315E9D8E8C4492876E6CFF3F5D40@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521342853-2941-1-git-send-email-Anson.Huang@nxp.com>
 <1521342853-2941-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CG6XuJ7N8W--zEwEVd9JHj887_7aNp+K8D-Xt1OnKh7A@mail.gmail.com>
In-Reply-To: <CAOMZO5CG6XuJ7N8W--zEwEVd9JHj887_7aNp+K8D-Xt1OnKh7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB404;6:DVeIEQxAzImcDLFmCjHU1epCkX0r7b2x/bjzAUVcMU5AuNzQ0mxCSZ2I2ka5ne3902z3bYs3pxAlqIa+LoVfM8USxOpgOvz95hrr6dZsq2xfhoq9Q9PoiF1vD/Tbmvbl/IO/b+s91xUzGlCZARMhR5v453ILJZptcr/YvcbvV1aj9KceAhvbsJS5iUP//bHLaTCfMmKAh4G89U7o/ARwWt9L1KGUyYaY2JxoVvrPJR3jVf1Vuj0FjV9kiEuw2HwYuXwMB0RUwUJ1dXwYBycue8VmwnkErjD4u9/mz0bKZne6fO/CeRKHhXJ/UZLTJJqUuaBZqplBJWpe5E8Rk1npmFq8zm7TQ7VrtbNed41g5noO8nTYutZyEVjeppIAUKfJ;5:9F6qg5Gnp5vqNpxT3x+4ZscnwKpri7MOpE2eslwaPv5Yf+otTuXRgnL4Kvmc56TVCbCXE2p6Zrvxpzd//YySHynCJWqymwWSW471BnXLnn6bMe0IhwzN4piP9WiOX0t+Vg6ryUDn1gGsmZOJ98PnsPRooGE2oPKlot1XThnopkY=;24:UlVOj06uLbQAFrW6NA+AI38WmOOC6LVdVlb7pH3cCp0rsOogkXYoVi8r6VvW2SIVDaRUqpzT3WGBBp9GrHiw/qZuW7SD5sYNV9PuUg2L0pQ=;7:G1ktcItX7hcp1+ZfMghQ5ow8SACo+yGOhyG/hsxpd7FmsSZrqWoNWIMXzXHauwanMoWKnX+ew4q55undBQ70rEV5myYaCR6kvK3OmNG+BxRB3ErtgO3KLgMBc4rwtqrhqfLit3obgaMS2B8LVE6i24JaUm0p5EXB/cE54D7SpezbD0oZTEdKtcPo/jgCE6bpAZybxuo0b+jO0Z+6XI2N2sAHGcC7uBs5q7aV16EJKnVmw7/Zq9PCVr5FECFhOITS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e7ad773-972a-4027-0062-08d58d3e7876
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB404;
x-ms-traffictypediagnostic: AM3PR04MB404:
x-microsoft-antispam-prvs: <AM3PR04MB4047A55BDABA5F37B10BD59F5D40@AM3PR04MB404.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB404;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB404;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(13464003)(3846002)(6116002)(7736002)(74316002)(305945005)(99286004)(2906002)(3280700002)(5250100002)(106356001)(3660700001)(6246003)(66066001)(68736007)(5660300001)(105586002)(7416002)(86362001)(54906003)(55016002)(316002)(8676002)(25786009)(81156014)(81166006)(1411001)(229853002)(9686003)(6916009)(6436002)(2900100001)(97736004)(8936002)(186003)(2950100002)(26005)(14454004)(6506007)(53546011)(76176011)(39060400002)(478600001)(102836004)(4326008)(33656002)(53936002)(7696005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB404;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: PpaUAbkSY5bYa2SYVtlli6J/oqqdp0A9/6LdRWMkLZ+R4K12i1a6LcH41PwEbby5UDD1HIznEWYs/ytk8GjLQXHrqDF0QNzhl9NBvWIfYLRADZ5Z3snmXDeZ1GWoKlyzWqmQoiA1oqCnX1qgTvAQ7gWzCuNMqrv7d4CTx8m4PNllHbFPfDo8S4J6hgzYOeJxBfiza8hfCph5IrrRIfjFh31ZofystMGDHrdscM4Qw6wIWAszGXtJMqbGwy9l1AqHztZ+gpksIduiDu8xBP665VYxQpYvQD+EivcodkFtIgL4Kw96MiUnJls1PaHjEVbM6mqxk2eza3j3ldiXfGXb+g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7ad773-972a-4027-0062-08d58d3e7876
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 02:09:39.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB404
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2J29tT9025101

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Sunday, March 18, 2018 9:04 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; S.j. Wang
> <shengjiu.wang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>; linux-clk <linux-clk@vger.kernel.org>
> Subject: Re: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
> source
> 
> On Sun, Mar 18, 2018 at 12:14 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 72da5ac..83f7cac 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -18,6 +18,14 @@
> >                 reg = <0x80000000 0x80000000>;
> >         };
> >
> > +       clocks {
> > +               codec_osc: anaclk2 {
> > +                       #clock-cells = <0>;
> > +                       compatible = "fixed-clock";
> > +                       clock-frequency = <24576000>;
> > +               };
> > +       };
> 
> The clocks container should be removed and the clock node could be put directly
> into the root node.
> 
> Also, I do not see 'codec_osc' being used in this dts.
 
This clock will be used by cs42888 codec, this patch is only to add basic clock source
to complete the clock tree. Thanks.

Anson.
