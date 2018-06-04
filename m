Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeFDBLh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:11:37 -0400
Received: from mail-he1eur01on0073.outbound.protection.outlook.com ([104.47.0.73]:4096
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751795AbeFDBLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:11:34 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] clk: imx6q: remove clks_init_on array
Thread-Topic: [PATCH 1/4] clk: imx6q: remove clks_init_on array
Thread-Index: AQHT+ueX6hYt01LFM028YAG/S2bHiKROe18AgAABC1uAAAGoAIAAzcgw
Date: Mon, 4 Jun 2018 01:11:29 +0000
Message-ID: <AM3PR04MB1315DA5AC8F4F2AC5425A47BF5670@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
 <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
 <CAOMZO5ANz-B-s93+R_xnF0LOux1zTY3E8Ky4KvrZ8EX1ZKmpAQ@mail.gmail.com>
In-Reply-To: <CAOMZO5ANz-B-s93+R_xnF0LOux1zTY3E8Ky4KvrZ8EX1ZKmpAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1299;7:K8N1cjM7ANvHbqDZd6OtTCi7elEB7laPsFnEPWaYmRjdH3gUSwVHEeeQRFcXxlDf5i1hBhzclUp69WGk2q2CB7p1G4baUTOTBAX13hPJ8VC207UCaY4J2b/eCpSjpHoUbd0xPhT9tDHrLwE3BBHlbPk/Ei1/6dWYzujgD+Axr78+2/1tEJA71U80IN/MPLTbTphUgMm7wKhlD7V5PNm4PxFK9bMtcuFAvyAttLwA40EGliZoStdOQs+feZyQNiVI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1299;
x-ms-traffictypediagnostic: AM3PR04MB1299:
x-microsoft-antispam-prvs: <AM3PR04MB12998F1448B2B93B9E547F58F5670@AM3PR04MB1299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1299;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1299;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(13464003)(189003)(199004)(51914003)(8936002)(66066001)(44832011)(4326008)(26005)(11346002)(476003)(76176011)(6246003)(229853002)(316002)(446003)(7696005)(6436002)(97736004)(6116002)(105586002)(486006)(68736007)(102836004)(93886005)(86362001)(2900100001)(6506007)(106356001)(53546011)(7736002)(74316002)(5660300001)(99286004)(3660700001)(3846002)(81166006)(33656002)(14454004)(39060400002)(8676002)(305945005)(1411001)(3280700002)(2906002)(53936002)(5250100002)(186003)(55016002)(6916009)(9686003)(81156014)(478600001)(54906003)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1299;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8YYINEy633l7UbQQyDXG37GneTFh6XvELTQ88TRyiVtk9Nf0NCWKx9fLMMgaKuNFfpCTlSwMJ6aFl+AYsVM5ECP6OvD1j/hXHqPqX4q9ZP0tB48pBe3HQcG3m93BOiryRRBI/QHZ1rWt1UnNmIVCeevJtKTWgid3v0bAvqG3VPrwTrIClcOIgsc9cQjmrvru
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f6cbd6d2-625b-4f7a-52a0-08d5c9b81a64
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cbd6d2-625b-4f7a-52a0-08d5c9b81a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 01:11:29.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1299
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w541Bg3i001181

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Sunday, June 3, 2018 8:54 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Michael
> Turquette <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linux-clk
> <linux-clk@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/4] clk: imx6q: remove clks_init_on array
> 
> Hi Anson,
> 
> On Sun, Jun 3, 2018 at 9:48 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > As I explain in previous mail, busy divider clk type already include the flag
> when registered.
> 
> Ok, then please add this information in the commit log to make the review
> process easier.
 
Thanks for the comments, I improved the commit log in V2 patch set.

Anson.
