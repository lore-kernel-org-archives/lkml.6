Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeFDDlg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 23:41:36 -0400
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:24775
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751444AbeFDDle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 23:41:34 -0400
From: Rajan Vaja <RAJANV@xilinx.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Topic: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Index: AQHTtuf/CFgaaA2KSEWVdsmwI1dm/aPIOgOAgAAMc1CACWfIAIABDRAggEtTqACALvxzAIAC8Ytw
Date: Mon, 4 Jun 2018 03:41:27 +0000
Message-ID: <CY1PR02MB2091426610FC0037BB9EF61BB7670@CY1PR02MB2091.namprd02.prod.outlook.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
 <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
 <SN4PR0201MB35029B265E608A24130BFEE2B7D70@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <CY1PR02MB20914DBB65A193DED2BEED92B7870@CY1PR02MB2091.namprd02.prod.outlook.com>
 <152792163637.225090.8916381060805852261@swboyd.mtv.corp.google.com>
In-Reply-To: <152792163637.225090.8916381060805852261@swboyd.mtv.corp.google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB2140;7:1iC+LGXH/jjMTG52Ahu9no8c3cpJys/z3uwkLe580zCLng2URsq0+Lkar5Ztv3ROzSBCdWzER7es+55+KpQk/uhLALXOCKaT8wqMBLr8ZHGYJfa4ZcpJjWKpZd2SVlOAJl2KsmpfFlNifRQfMeGW28VYhXV4xR3axHgPS3iR8AigiLo22hVGwqFWraPre9phvzN0k9LJJgOIGc6GXmg1C3zTlEbTOTVxnNkgemDUvhnxFDk9ZyLcQEZhfcBw2WcF
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(39380400002)(376002)(366004)(51914003)(13464003)(199004)(189003)(7736002)(105586002)(3280700002)(3660700001)(106356001)(2906002)(97736004)(33656002)(6116002)(3846002)(86362001)(2900100001)(478600001)(66066001)(4326008)(68736007)(45080400002)(53936002)(72206003)(6246003)(966005)(14454004)(9686003)(25786009)(229853002)(54906003)(6916009)(5660300001)(8936002)(99286004)(5250100002)(8676002)(11346002)(476003)(446003)(81166006)(486006)(26005)(76176011)(93886005)(186003)(53546011)(6506007)(55016002)(305945005)(74316002)(316002)(6306002)(7696005)(6436002)(81156014)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2140;H:CY1PR02MB2091.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB2140;
x-ms-traffictypediagnostic: CY1PR02MB2140:
x-microsoft-antispam-prvs: <CY1PR02MB21402052DA97B7687EFC3424B7670@CY1PR02MB2140.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB2140;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB2140;
x-forefront-prvs: 069373DFB6
x-microsoft-antispam-message-info: s67fSAWh8y4GOghDB6/FL4RJfvi+6DfZKRaFqxoUL57qImZI4PajG+Qh519TBoaQZnjMrZB3rYaTw7/s4R4i/IblgSIXZkBELtnygYWqBJuje5AbtJ25pm6BAHflRtvAgOpsBr8oqPEOrVRF6EbuS7noknR/Ymmnd81WOTJpRtoL/GPuR4qfEXi05lRkR7AU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dddc243f-3ef5-46d2-5395-08d5c9cd0e0b
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddc243f-3ef5-46d2-5395-08d5c9cd0e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 03:41:28.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w543fgpg008978

Hi Stephen,

Thanks for the reply. 

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: 02 June 2018 12:11 PM
> To: Rajan Vaja <RAJANV@xilinx.com>
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> mturquette@baylibre.com
> Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> CLK_OF_DECLARE_DRIVER
> 
> Quoting Rajan Vaja (2018-05-03 02:18:30)
> > Hi Stephen,
> >
> > > -----Original Message-----
> > > From: Rajan Vaja
> > > Sent: 16 March 2018 05:20 PM
> > > To: 'Stephen Boyd' <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> > > <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> > > mturquette@baylibre.com
> > > Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> > > CLK_OF_DECLARE_DRIVER
> > >
> > > Hi Stephen,
> > >
> > > Thanks for the comment.
> > >
> > > > -----Original Message-----
> > > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > > > Sent: 16 March 2018 12:17 AM
> > > > To: Rajan Vaja <RAJANV@xilinx.com>
> > > > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> > > > <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> > > > mturquette@baylibre.com
> > > > Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> > > > CLK_OF_DECLARE_DRIVER
> > > >
> > > > Quoting Rajan Vaja (2018-03-09 11:27:40)
> > > > > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > > > > >
> > > > > > Is the intent to register the clk twice? I believe things are working as
> > > > > > intended without this patch, so maybe you can explain a little more
> what
> > > > > > you're trying to fix.
> > > > > [Rajan] Yes. During of_clk_init() if some DT fixed factor clock has
> > > > > parent which is neither mentioned in output-clock-names of clock
> > > > > controller nor registered as clock provider, of_clk_init() will try to
> > > > > forcefully register in second loop.
> > > > >
> > > > >                         if (force || parent_ready(clk_provider->np)) {
> > > > >
> > > > >                                 /* Don't populate platform devices */
> > > > >                                 of_node_set_flag(clk_provider->np,
> > > > >                                                  OF_POPULATED);
> > > > >
> > > > > So registration of this DT fixed-factor clock would fail as parent
> > > > > would be NULL as below (called from _of_fixed_factor_clk_setup()):
> > > > > parent_name = of_clk_get_parent_name(node, 0);
> > > > >
> > > > > On the other hand, even if registration failed, that node will be
> > > > > marked as OF_POPULATED, so probe of clk-fixed-factor.c will also not
> > > > > be called and that DT fixed-factor clock would never be registered.
> > > > >
> > > > > Same thing is discussed at  https://lkml.org/lkml/2017/6/5/681 .
> > > >
> > > > Ok. I believe the answer is to fix the DT to describe the parent chain
> > > > properly with clock-output-names. Otherwise, we have no good way of
> > > > figuring out what the name should be.
> > > [Rajan] clock DT binding doc says that clock-output-names property
> > > is optional and sometimes not recommended.
> > > I think this patch fixes the issue we have which mandates to add clock-
> output-
> > > names
> > > property (for this particular case). Also, IIUC platform driver probe in clk-
> fixed-
> > > factor.c
> > > will never be called unless we use CLK_OF_DECLARE_DRIVER.
> > > I completely agree that proper solution would be to stop using strings to
> > > describe clock topology.
> > [Rajan] Any comments on this?
> > Unless we have proper solution ready, we need to have some mechanism to
> handle this scenario.
> > clock-output-names is optional and without this, it mandates to use clock-
> output-names.
> >
> 
> I couldn't read your outlook sent email and I was too busy to go
> translate it. Some bug in my MUA it seems.
> 
> Can you add the output-names property? In this case it's practically
> mandatory, so if you can't do it I'd like to hear why not.
[Rajan] In our case, we are firmware maintains clock database and driver query clocks
from firmware and registers clock based on information received from firmware. So
output clock names are not fixed. 
https://patchwork.kernel.org/patch/10439893/ - dt-bindings: clock: Add bindings for ZynqMP clock driver
https://patchwork.kernel.org/patch/10439891/ - drivers: clk: Add ZynqMP clock driver
