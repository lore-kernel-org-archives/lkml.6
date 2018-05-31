Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbeEaAw0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:52:26 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:30240
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932451AbeEaAwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:52:23 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
Thread-Topic: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
 idle driver
Thread-Index: AQHT9+Yb0pJVGY124Emum6rx24XNYaRINSiAgADN1qA=
Date: Thu, 31 May 2018 00:52:17 +0000
Message-ID: <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
In-Reply-To: <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0694;7:Xsq1E0YFw1PoagaG/m9S3QQvJ6OVG3u1KmDVclEqRYGMGvEEp38F0PbV3vRD0ZId0xrucYc7GIRuyGiV5VxFjF6HZbSWSBo46bGr8kVlAuSJ2y2sA0uWXtZtiLxVpHUkbFxteYY/AMiV/hSk1C/0wh86bUUXo0fWP47u/R/sFXfiMzXZ3bJrYrxAgzmn8b6WUqZCl0+n0F3TnoKOdPmpP4o3+DfD/OihOcQvQLUivfSQzZLA/pupMmd7003qIfRw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0694;
x-ms-traffictypediagnostic: AM3PR04MB0694:
x-microsoft-antispam-prvs: <AM3PR04MB069477A8F575ABD6A3F33AE5F5630@AM3PR04MB0694.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB0694;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0694;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(13464003)(199004)(189003)(6506007)(33656002)(102836004)(2900100001)(4326008)(99286004)(66066001)(316002)(8936002)(11346002)(7696005)(14454004)(105586002)(106356001)(44832011)(39060400002)(305945005)(55016002)(25786009)(476003)(486006)(7736002)(86362001)(74316002)(6916009)(6116002)(68736007)(229853002)(3846002)(446003)(9686003)(5660300001)(478600001)(81156014)(53936002)(81166006)(1411001)(3280700002)(186003)(6246003)(2906002)(53546011)(54906003)(97736004)(26005)(5250100002)(6436002)(76176011)(8676002)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0694;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gUCVm3s/MFbeF9BDy2lDVPFvUIRE/VnQb/IT04kTN3i2zop7XOjHRDNQ2YHxcYT6yV0xOu3nUiur0a1WT61cP4V4JPPWa3xZWMGMc/SZS37dAd7ZMuAyppbf/lZJu62qnb7fnWcaRyTP4ncyCOmYEOWBwqBrEVAK/kGVFEWUtDyBWi/V+oHKYO16obulssiz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1605ec2f-36a1-4733-30f0-08d5c690c25f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1605ec2f-36a1-4733-30f0-08d5c690c25f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 00:52:18.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4V0qjET032133

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Wednesday, May 30, 2018 8:34 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Russell King - ARM Linux
> <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
> idle driver
> 
> Hi Anson,
> 
> On Wed, May 30, 2018 at 4:12 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > i.MX6SLL supports ARM power off in cpu idle, better to reuse i.MX6SX
> > cpu idle driver instead of i.MX6SL which does NOT support ARM power
> > off.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/mach-imx/cpuidle-imx6sl.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c
> > b/arch/arm/mach-imx/cpuidle-imx6sl.c
> > index fa8ead1..8d866fb 100644
> > --- a/arch/arm/mach-imx/cpuidle-imx6sl.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
> > @@ -12,7 +12,6 @@
> >
> >  #include "common.h"
> >  #include "cpuidle.h"
> > -#include "hardware.h"
> 
> The removal of this header file seems to be an unrelated change.
 
This header file is no longer needed since no " cpu_is_imx6sl()" used in this file.

Anson.
