Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935815AbeEXIQY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:16:24 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:36640
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751091AbeEXIQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:16:21 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: mxc: add clock operation
Thread-Topic: [PATCH] gpio: mxc: add clock operation
Thread-Index: AQHT8Ovpk2s4/xFu6UGg8dQ0QkzgaaQ+jBSAgAAATAA=
Date: Thu, 24 May 2018 08:16:16 +0000
Message-ID: <AM3PR04MB1315F0E402BED6BAA943781AF56A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526897190-28714-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdbYDqnroi-X7ECdcoeuALEgwB0afZZszap97D_AF725Hg@mail.gmail.com>
In-Reply-To: <CACRpkdbYDqnroi-X7ECdcoeuALEgwB0afZZszap97D_AF725Hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB291;7:eR30sIYUCXzkJAtMtpjHXvsIQ/aOQsVWAs3lt+jezzyYnsPUAxoEXQ9hjkcjko2qk6gQkS6SPtk9YN2wYg9YrQf/yVFwjkc+R5ucAMHvaeW7fjHJkonObrmgMWWH1xcykNPhnQKqWvpxamuT50nrVGJuI+B8A9RmlFu7hInE0oeTmIZF5SWcx4NIm8r13ihfkn84ezEOE56tNPCVxW+iIDQAIIFxU/N52Xx7jFZDAG4Ki9KEA2qc1bemF+GhpBh6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB291;
x-ms-traffictypediagnostic: AM3PR04MB291:
x-microsoft-antispam-prvs: <AM3PR04MB2912B04CFC275F4E90DDF33F56A0@AM3PR04MB291.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB291;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB291;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(13464003)(189003)(199004)(478600001)(25786009)(186003)(229853002)(26005)(53936002)(6506007)(8936002)(68736007)(102836004)(53546011)(3660700001)(8676002)(81156014)(2906002)(81166006)(6916009)(6246003)(7736002)(5660300001)(305945005)(3280700002)(2900100001)(66066001)(86362001)(59450400001)(74316002)(33656002)(97736004)(316002)(99286004)(5250100002)(55016002)(486006)(44832011)(7696005)(11346002)(446003)(6116002)(3846002)(6436002)(9686003)(76176011)(14454004)(106356001)(105586002)(476003)(4326008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB291;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-microsoft-antispam-message-info: JEu9ym6o0RpjVKW8aDp3+fOZwntVm/q01PttnMVbtffJIfx8X+O8mWVkGiW6okpqmgEXheIZQ/emUBvH6O/iht0Cw+JTiPs6gG0YkSzf7dPWW/g1lA8vJtn/YDr1f2/jb58jRYdNTuiyICf4M2vYo/b8mu3qYeU9c0xrWmx+XUNiM+o5Ocx1iqYJQSdMxTVi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8298a667-3aac-4e03-7a8a-08d5c14e9f55
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8298a667-3aac-4e03-7a8a-08d5c14e9f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 08:16:16.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB291
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4O8GTGN005119

Hi, Linus

Anson Huang
Best Regards!


> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij@linaro.org]
> Sent: Thursday, May 24, 2018 4:13 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; open list:GPIO SUBSYSTEM
> <linux-gpio@vger.kernel.org>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] gpio: mxc: add clock operation
> 
> On Mon, May 21, 2018 at 12:06 PM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > i.MX6SLL has GPIO clock gates in CCM CCGR, need to enable them before
> > accessing registers, add optional clock operation for GPIO driver.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Some warnings from the build robot, seem like a missing #include <linux/clk.h>
> or something.
 
Please ignore this patch, the "[PATCH V3] gpio: mxc: add clock operation" is to
fix this build warning.

Thanks.

Anson.


> 
> Yours,
> Linus Walleij
