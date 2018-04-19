Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeDSDXp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:23:45 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:56486
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752241AbeDSDXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:23:43 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
 clock source
Thread-Topic: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
 clock source
Thread-Index: AQHTvz6eUo2AHPcapEeqRU+EBJWG0qQFMG6AgAJrAYCAAAFuAA==
Date: Thu, 19 Apr 2018 03:23:39 +0000
Message-ID: <AM3PR04MB1315FCBBAFCE808BD35FF2CFF5B50@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
 <20180417142203.GM25429@dragon>
 <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
In-Reply-To: <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1299;7:+xVuY3418OQvjJtS0nXOCne7IwUNEetPKyy/BbzmzJ5y5SXxJUl+knirssItssEjDqG84XfQGpH2OgNX8oM1v9CImCOwsIgDxAPhcK1IQ9LgKTJl0TZ2ZpAr00iYuMT/sWNOpFrbSJ0Et1pzivZDmKYJqulWVc6XdeOWDFPWlr/Tg3EQj46csUzOJAZ5IcsqZYy6Mb+5qD4Lr1C3deykS6iQSvyiGfoHacDJZLAsFU+r8BGhfqI5EJ+PLWVyCXDQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1299;
x-ms-traffictypediagnostic: AM3PR04MB1299:
x-microsoft-antispam-prvs: <AM3PR04MB1299240F593EE6EA7769C754F5B50@AM3PR04MB1299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM3PR04MB1299;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1299;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(346002)(376002)(39860400002)(377424004)(8936002)(305945005)(66066001)(7736002)(2900100001)(26005)(5660300001)(6506007)(53546011)(6116002)(44832011)(76176011)(6436002)(2906002)(33656002)(7696005)(3846002)(476003)(14454004)(102836004)(186003)(53936002)(446003)(229853002)(25786009)(8676002)(478600001)(11346002)(81166006)(110136005)(54906003)(5250100002)(7416002)(55016002)(86362001)(316002)(4326008)(99286004)(9686003)(74316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1299;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: naXUKwjZHONxidtGDMIl2I9Di4twkfWxwkTQsX8JPJDWS5EpGUm/TjyWSu01BtrHUac5yR5DiWCfRLoID/90bPylu3Ts0PRCNIv6hismUWuSzrqAhQODoTOfpnA6dADJYIHwkGBMjxwrEAvud8qIqdby9hGSCWGflTHRaDp4fFCica6rJFbn9AejhEK0778i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e978174b-9f7f-425c-5ae4-08d5a5a4f20f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e978174b-9f7f-425c-5ae4-08d5a5a4f20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 03:23:39.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1299
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3J3NprS022488



Anson Huang
Best Regards!


> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Thursday, April 19, 2018 11:18 AM
> To: Anson Huang <anson.huang@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>
> Cc: mark.rutland@arm.com; devicetree@vger.kernel.org;
> mturquette@baylibre.com; linux-clk@vger.kernel.org; linux@armlinux.org.uk;
> linux-kernel@vger.kernel.org; robh+dt@kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; S.j. Wang <shengjiu.wang@nxp.com>;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
> clock source
> 
> Quoting Shawn Guo (2018-04-17 07:22:05)
> > On Mon, Mar 19, 2018 at 10:30:45AM +0800, Anson Huang wrote:
> > > On i.MX6SX SabreAuto board, there is external 24MHz clock source for
> > > analog clock2, add this clock source to clock tree.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > changes since V1:
> > >       remove unnecessary clocks container.
> >
> > I understand this is suggested by Fabio, but I'm afraid that it's not
> > going to work with imx_obtain_fixed_clock() call, which is coded to
> > look for clocks under /clocks node.
> >
> 
> Should patch #1 be dropped from clk tree?

If so, I think we should use V1 patch to keep clocks container?
 
Anson.
