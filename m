Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeB1Lco (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:32:44 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:62069
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752147AbeB1Lcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:32:42 -0500
From: Anson Huang <anson.huang@nxp.com>
To: Dong Aisheng <dongas86@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx: imx7d: correct video pll clock tree
Thread-Topic: [PATCH] clk: imx: imx7d: correct video pll clock tree
Thread-Index: AQHThHXQiYkci3prfU6KqlHJfu2UX6Np0XqAgFA0iYA=
Date: Wed, 28 Feb 2018 11:32:37 +0000
Message-ID: <VI1PR04MB132809996C5C2BFCF0B482B8F5C70@VI1PR04MB1328.eurprd04.prod.outlook.com>
References: <1514999361-2723-1-git-send-email-Anson.Huang@nxp.com>
 <20180108104111.GE32635@b29396-OptiPlex-7040>
In-Reply-To: <20180108104111.GE32635@b29396-OptiPlex-7040>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1630;7:tccAMRce24jgHk9cPUHyoXQvq/U3O+4D8sEXsybMQc6iUmadHO+l4usNRE7KC/MgkmJk27UVPHIUsJq3CZvBtS4KFVrJxgsgsqb8qNGa87pjPJ9sAgyCNYMkyg/rH7rM1bfqeoZEgtggDemhjbjbC3ET9lWAxSU2kqxZyV0YXQbCqeqH/d8cATnKAInVcGU8y1aVxVKGNAhFuWT3n4x13pt1OTrfgyXLAsH6K59NWU+GZXGx8fKb25KiTjsBT0Ss
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fce4a34-e771-475c-97a0-08d57e9ef821
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB1630;
x-ms-traffictypediagnostic: VI1PR04MB1630:
x-microsoft-antispam-prvs: <VI1PR04MB16306BBC75A3725FEFBA9A4FF5C70@VI1PR04MB1630.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501161)(52105095)(3002001)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1630;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1630;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(39380400002)(189003)(13464003)(199004)(3280700002)(2900100001)(3660700001)(86362001)(14454004)(9686003)(3846002)(478600001)(81166006)(55016002)(1411001)(33656002)(5250100002)(305945005)(81156014)(2906002)(6116002)(229853002)(74316002)(5660300001)(6246003)(8936002)(8676002)(26005)(186003)(6436002)(7736002)(6506007)(53546011)(66066001)(2950100002)(53936002)(102836004)(6916009)(54906003)(7696005)(68736007)(97736004)(76176011)(25786009)(105586002)(106356001)(4326008)(99286004)(39060400002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1630;H:VI1PR04MB1328.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: THY308VdwiqJw6Ug2T3jBrBvdBZZxSUdTCT56NhLDrhVhNIy5fzCS6V6MzwjpbD40tFbF8l4KKfuWpUDtgm01qtADIYkLvR20vxvfUaaoI/WW3e2Z4Qj25EL/saSasvFgcexKxGGD33VUpT9/BjquXJ8wXief4WNCLF+dQieStg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fce4a34-e771-475c-97a0-08d57e9ef821
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 11:32:37.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1630
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1SBWptt023325

Ping...

Looks like this patch is missed on latest tree, so ping it.

Anson Huang
Best Regards!


> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86@gmail.com]
> Sent: Monday, January 8, 2018 6:41 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; sboyd@codeaurora.org;
> mturquette@baylibre.com; Fabio Estevam <fabio.estevam@nxp.com>;
> kernel@pengutronix.de; shawnguo@kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH] clk: imx: imx7d: correct video pll clock tree
> 
> On Thu, Jan 04, 2018 at 01:09:21AM +0800, Anson Huang wrote:
> > There is a test divider and post divider in video PLL, test divider is
> > placed before post divider, all clocks that can select parent from
> > video PLL should be from post divider, NOT from pll_video_main, below
> > are clock tree dump before and after this patch:
> >
> > Before:
> > pll_video_main
> >    pll_video_main_bypass
> >       pll_video_main_clk
> >          lcdif_pixel_src
> >             lcdif_pixel_cg
> >                lcdif_pixel_pre_div
> >                   lcdif_pixel_post_div
> >                      lcdif_pixel_root_clk
> > After:
> > pll_video_main
> >    pll_video_main_bypass
> >       pll_video_main_clk
> >          pll_video_test_div
> >             pll_video_post_div
> >                lcdif_pixel_src
> >                   lcdif_pixel_cg
> >                      lcdif_pixel_pre_div
> >                         lcdif_pixel_post_div
> >                            lcdif_pixel_root_clk
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Regards
> Dong Aisheng
