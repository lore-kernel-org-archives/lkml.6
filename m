Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeECJSk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:18:40 -0400
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:55328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750898AbeECJSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:18:36 -0400
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
Thread-Index: AQHTtuf/CFgaaA2KSEWVdsmwI1dm/aPIOgOAgAAMc1CACWfIAIABDRAggEtTqAA=
Date: Thu, 3 May 2018 09:18:30 +0000
Message-ID: <CY1PR02MB20914DBB65A193DED2BEED92B7870@CY1PR02MB2091.namprd02.prod.outlook.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
 <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
 <SN4PR0201MB35029B265E608A24130BFEE2B7D70@SN4PR0201MB3502.namprd02.prod.outlook.com>
In-Reply-To: <SN4PR0201MB35029B265E608A24130BFEE2B7D70@SN4PR0201MB3502.namprd02.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com;
x-originating-ip: [219.65.63.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1246;7:iyBXRe6RTgwLQLgBnvGQ89/18tWubJMYTILEDOigBAEqxnLGkSw4WMHjDYMvJgRNB7lWh7qGz2brML+Z95uNfOJ+sRXDf5uTj6CRQTdLNFhEbUoBXPw42Fm06Zvk4b7XUiRZnwP3SdGOvjAwdpN/gZxVsYextV+8i+BJ6Fb/DHTlobzxAulTkGnk6zqdphGBULSrW3Hw++0g7srFvh2InA7T3uyvBQQTu5ZKmAVAyA2GD4NgusLHSpcgsed/3D8M
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39850400004)(396003)(39380400002)(51914003)(377424004)(189003)(13464003)(199004)(68736007)(26005)(2900100001)(99286004)(55016002)(54906003)(9686003)(229853002)(6916009)(478600001)(97736004)(2906002)(4326008)(8676002)(53936002)(25786009)(3846002)(3660700001)(5250100002)(6506007)(6436002)(74316002)(33656002)(6116002)(3280700002)(14454004)(966005)(66066001)(6306002)(305945005)(93886005)(446003)(5660300001)(186003)(86362001)(486006)(316002)(106356001)(105586002)(76176011)(72206003)(476003)(8936002)(81166006)(7736002)(53546011)(6246003)(102836004)(11346002)(81156014)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1246;H:CY1PR02MB2091.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1246;
x-ms-traffictypediagnostic: CY1PR02MB1246:
x-microsoft-antispam-prvs: <CY1PR02MB12469682357E80FE9E1ED0F1B7870@CY1PR02MB1246.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR02MB1246;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1246;
x-forefront-prvs: 066153096A
x-microsoft-antispam-message-info: c4c5ofxeqJqRCqONJty4ZQYqVMCEiXisgFS+TyhI0LekCHYHkBJRdciIj4bQn3o4ls+gvQud8On4D3g5HRzLEnJuvPwTHkBp8i39wdevCLP8yW5XbdNZYKWluQb5DAmdmOgHs28yxwWcdyUcpho2xR4qkUpH+1kN+k6maULLsesZx4O/b6PuAPlbbnWbOiEk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c664c1f9-3b47-4850-269f-08d5b0d6d66f
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c664c1f9-3b47-4850-269f-08d5b0d6d66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 09:18:30.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1246
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w439IixT004077

Hi Stephen,

> -----Original Message-----
> From: Rajan Vaja
> Sent: 16 March 2018 05:20 PM
> To: 'Stephen Boyd' <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> mturquette@baylibre.com
> Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> CLK_OF_DECLARE_DRIVER
> 
> Hi Stephen,
> 
> Thanks for the comment.
> 
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: 16 March 2018 12:17 AM
> > To: Rajan Vaja <RAJANV@xilinx.com>
> > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> > <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> > mturquette@baylibre.com
> > Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> > CLK_OF_DECLARE_DRIVER
> >
> > Quoting Rajan Vaja (2018-03-09 11:27:40)
> > > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > > >
> > > > Is the intent to register the clk twice? I believe things are working as
> > > > intended without this patch, so maybe you can explain a little more what
> > > > you're trying to fix.
> > > [Rajan] Yes. During of_clk_init() if some DT fixed factor clock has
> > > parent which is neither mentioned in output-clock-names of clock
> > > controller nor registered as clock provider, of_clk_init() will try to
> > > forcefully register in second loop.
> > >
> > >                         if (force || parent_ready(clk_provider->np)) {
> > >
> > >                                 /* Don't populate platform devices */
> > >                                 of_node_set_flag(clk_provider->np,
> > >                                                  OF_POPULATED);
> > >
> > > So registration of this DT fixed-factor clock would fail as parent
> > > would be NULL as below (called from _of_fixed_factor_clk_setup()):
> > > parent_name = of_clk_get_parent_name(node, 0);
> > >
> > > On the other hand, even if registration failed, that node will be
> > > marked as OF_POPULATED, so probe of clk-fixed-factor.c will also not
> > > be called and that DT fixed-factor clock would never be registered.
> > >
> > > Same thing is discussed at  https://lkml.org/lkml/2017/6/5/681 .
> >
> > Ok. I believe the answer is to fix the DT to describe the parent chain
> > properly with clock-output-names. Otherwise, we have no good way of
> > figuring out what the name should be.
> [Rajan] clock DT binding doc says that clock-output-names property
> is optional and sometimes not recommended.
> I think this patch fixes the issue we have which mandates to add clock-output-
> names
> property (for this particular case). Also, IIUC platform driver probe in clk-fixed-
> factor.c
> will never be called unless we use CLK_OF_DECLARE_DRIVER.
> I completely agree that proper solution would be to stop using strings to
> describe clock topology.
[Rajan] Any comments on this?
Unless we have proper solution ready, we need to have some mechanism to handle this scenario.
clock-output-names is optional and without this, it mandates to use clock-output-names.

> 
> >
> > The alternative is to start working on a solution for having the clk
> > framework stop using strings to describe clk topology. My plan there is
> > to allow clk registration to indicate that another parent names array
> > should be used with clk_get() of the device or node pointer that's
> > associated with the clk during registration to find the parent . If we
> > had that, then we could hook up clks into the tree by calling clk_get()
> > in the framework and map through the clock-names property. This also
> > gets us to a point where clk names don't have to be globally unique,
> > which would be nice.
