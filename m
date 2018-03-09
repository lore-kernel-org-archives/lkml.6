Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeCIT1p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:27:45 -0500
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com ([104.47.36.89]:52856
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932230AbeCIT1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:27:44 -0500
From: Rajan Vaja <RAJANV@xilinx.com>
To: "'Stephen Boyd'" <sboyd@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Topic: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Index: AQHTtuf/CFgaaA2KSEWVdsmwI1dm/aPIOgOAgAAMc1A=
Date: Fri, 9 Mar 2018 19:27:40 +0000
Message-ID: <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
In-Reply-To: <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR0201MB3472;7:nT8fCy9427FNFK+uaBBc6elBMRjINJ7dsJGeK1diBbzOKtQDyLL1+k5xPpxfzLRGdBv8EOsc/Y2p7kEMSaBRQ4SvAh5Gw5wN2FeIk9V7uLrc5ze90UtUqlsNIt5qU2aoxs0OcfOMKg4tdqUkNq0uMdAg0cx/KbfksMMJklcov2hQNYKxRbWhXf9IBNftVJPEfPxAdiw6L92gjAdqiKtlWQm5tRW1ZO6+zw9Jb7GtKFUXN0CGmvetleWxgRFrXIet
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(376002)(39380400002)(199004)(13464003)(189003)(377424004)(51914003)(68736007)(106356001)(81166006)(7696005)(81156014)(5250100002)(8676002)(4326008)(2900100001)(99286004)(74316002)(3660700001)(26005)(2906002)(5660300001)(305945005)(3280700002)(3846002)(6116002)(186003)(66066001)(33656002)(7736002)(6436002)(966005)(14454004)(316002)(54906003)(72206003)(105586002)(6916009)(229853002)(97736004)(6306002)(55016002)(9686003)(6246003)(102836004)(53936002)(86362001)(6506007)(53546011)(25786009)(8936002)(2950100002)(76176011)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3472;H:SN4PR0201MB3502.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-correlation-id: cd0d7167-3a97-48e6-be70-08d585f3d2b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN4PR0201MB3472;
x-ms-traffictypediagnostic: SN4PR0201MB3472:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com;
x-microsoft-antispam-prvs: <SN4PR0201MB3472E793EDB389175DB0A8F9B7DE0@SN4PR0201MB3472.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:SN4PR0201MB3472;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3472;
x-forefront-prvs: 0606BBEB39
x-microsoft-antispam-message-info: ScFUPaQwcL6Da7jZJdedMBvKAW6hpkDX+QE6sCT6pXaVHi/X7lN3oEtzm0cFEr49h3KkzqkPUgcWCEi/bStniFF1docb9ftD8eVbhyN8t28l7PdsxKUPnljUcp0RIlXg9LeqzTbJuO6vQlXUw9U5OE6s4X3623egpuZiF/T4GsBzbv1eHI8b9hivWqm2pq4gjlzNr5pLcro5/TIhnH3F4Td+aPaCTwccRxXS/U4COXTbk2GH6kJyFTFXMY3hc6trA90ll4jtVlGn/djxm5jDlzHgxTKJ3m4QAqdur0GZVNTRVSPaLjKd+708++r5v9O2UhEWKryIREiV/Eg+Mtgdrg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0d7167-3a97-48e6-be70-08d585f3d2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 19:27:40.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3472
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w29JRq3E007334

Hi Stephen,

Thanks for the review.

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Friday, March 09, 2018 10:25 AM
> To: Rajan Vaja <RAJANV@xilinx.com>; mturquette@baylibre.com
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>
> Subject: Re: [PATCH] clk: clk-fixed-factor: Use new macro
> CLK_OF_DECLARE_DRIVER
> 
> Quoting Rajan Vaja (2018-03-08 06:15:00)
> > Fixed factor clock has two initialization at of_clk_init() time and
> > also during platform driver probe. So declare the fixed factor clock
> > with CLK_OF_DECLARE_DRIVER instead of CLK_OF_DECLARE.
> >
> > See below commit for reference:
> > "clk: sunxi: apb0: Use new macro CLK_OF_DECLARE_DRIVER"
> > (sha1: 915128b621a05c63fa58ca9e4cbdf394bbe592f3)
> >
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Suggested-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/clk/clk-fixed-factor.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/clk-fixed-factor.c
> > b/drivers/clk/clk-fixed-factor.c index a5d402d..d72ef2d 100644
> > --- a/drivers/clk/clk-fixed-factor.c
> > +++ b/drivers/clk/clk-fixed-factor.c
> > @@ -196,8 +196,9 @@ void __init of_fixed_factor_clk_setup(struct
> > device_node *node)  {
> >         _of_fixed_factor_clk_setup(node);  }
> > -CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
> > -               of_fixed_factor_clk_setup);
> > +
> > +CLK_OF_DECLARE_DRIVER(fixed_factor_clk, "fixed-factor-clock",
> > +                     of_fixed_factor_clk_setup);
> >
> 
> Is the intent to register the clk twice? I believe things are working as
> intended without this patch, so maybe you can explain a little more what
> you're trying to fix.
[Rajan] Yes. During of_clk_init() if some DT fixed factor clock has parent which is neither mentioned in output-clock-names of clock controller nor registered as clock provider, of_clk_init() will try to forcefully register in second loop. 

                        if (force || parent_ready(clk_provider->np)) {

                                /* Don't populate platform devices */
                                of_node_set_flag(clk_provider->np,
                                                 OF_POPULATED);

So registration of this DT fixed-factor clock would fail as parent would be NULL as below (called from _of_fixed_factor_clk_setup()):
parent_name = of_clk_get_parent_name(node, 0);

On the other hand, even if registration failed, that node will be marked as OF_POPULATED, so probe of clk-fixed-factor.c will also not be called and that DT fixed-factor clock would never be registered. 

Same thing is discussed at  https://lkml.org/lkml/2017/6/5/681 .
