Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeCPLto (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:49:44 -0400
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:3012
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753866AbeCPLtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:49:42 -0400
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
Thread-Index: AQHTtuf/CFgaaA2KSEWVdsmwI1dm/aPIOgOAgAAMc1CACWfIAIABDRAg
Date: Fri, 16 Mar 2018 11:49:37 +0000
Message-ID: <SN4PR0201MB35029B265E608A24130BFEE2B7D70@SN4PR0201MB3502.namprd02.prod.outlook.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
 <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
In-Reply-To: <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR0201MB3519;7:/nr/JVB21LJKoj35wb+VBH/mkQYOHqEMrZelYMbQQFiSTFfOvZoRmGIJpM6Xu1vnhr9EDE3WVUppMZtsz42zlQrr7AHzsyrAp4+L1NoUK20g3YeAaf23p/nF2+ezxX2wjvJ5kTISe81H2SQBNlz7yrGGRnUAYtDdefiat8aYupYtRIGiCjRPIQQPe6cWn46lq+vkCjR58MLlKCq51CBWowGR9V5uXCIIk0wcq3k1PwgLzucP/gkVXIpgeMmRIvCl
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39840400004)(346002)(366004)(396003)(51914003)(377424004)(13464003)(189003)(199004)(26005)(6916009)(2900100001)(3660700001)(2950100002)(3280700002)(4326008)(33656002)(106356001)(25786009)(5660300001)(105586002)(86362001)(55016002)(93886005)(9686003)(478600001)(6306002)(102836004)(186003)(305945005)(7736002)(74316002)(54906003)(53546011)(5250100002)(68736007)(6436002)(229853002)(8936002)(6246003)(316002)(99286004)(2906002)(966005)(8676002)(6116002)(3846002)(6506007)(66066001)(7696005)(14454004)(76176011)(81166006)(72206003)(81156014)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3519;H:SN4PR0201MB3502.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 141952a4-8d50-4750-47df-08d58b33fef0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN4PR0201MB3519;
x-ms-traffictypediagnostic: SN4PR0201MB3519:
x-microsoft-antispam-prvs: <SN4PR0201MB3519364F5D7D80B6EE6EE517B7D70@SN4PR0201MB3519.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN4PR0201MB3519;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3519;
x-forefront-prvs: 0613912E23
x-microsoft-antispam-message-info: 7AKS9bp3HwFDi/TF4qYzf5hzvrHfm3i6iuPgzUp5O7nONBbRd6SabAe54JguMfohiHexUhnmo8MxPKUVLCynUqrZEKzPESFX7AUM3vceO39Tw/RDwxKkHUsaxKAUNQ6lgeyUAW/o7+TnSSnm0g/3OVpQju2DOJDz1FKvmv1zIB+iO4ghaSsMzgxJcbk/1VkichGNf7784Jg8febW+LTytLijCZZYw7xxxdYq+/CqD/nDLH4yE2gVR3mC80AztB2b+h8+8cA/Cra/IpIE79D40ZN+XZCfaGuKH0qn77Zp64s8ymxeHEeRq0iX2lkZ4CiIy+jkzU9xMSfN4KANWmXR0g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141952a4-8d50-4750-47df-08d58b33fef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 11:49:37.8296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3519
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2GBnmxV027386

Hi Stephen,

Thanks for the comment.

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: 16 March 2018 12:17 AM
> To: Rajan Vaja <RAJANV@xilinx.com>
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Michal Simek <michals@xilinx.com>;
> mturquette@baylibre.com
> Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
> CLK_OF_DECLARE_DRIVER
> 
> Quoting Rajan Vaja (2018-03-09 11:27:40)
> > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > >
> > > Is the intent to register the clk twice? I believe things are working as
> > > intended without this patch, so maybe you can explain a little more what
> > > you're trying to fix.
> > [Rajan] Yes. During of_clk_init() if some DT fixed factor clock has
> > parent which is neither mentioned in output-clock-names of clock
> > controller nor registered as clock provider, of_clk_init() will try to
> > forcefully register in second loop.
> >
> >                         if (force || parent_ready(clk_provider->np)) {
> >
> >                                 /* Don't populate platform devices */
> >                                 of_node_set_flag(clk_provider->np,
> >                                                  OF_POPULATED);
> >
> > So registration of this DT fixed-factor clock would fail as parent
> > would be NULL as below (called from _of_fixed_factor_clk_setup()):
> > parent_name = of_clk_get_parent_name(node, 0);
> >
> > On the other hand, even if registration failed, that node will be
> > marked as OF_POPULATED, so probe of clk-fixed-factor.c will also not
> > be called and that DT fixed-factor clock would never be registered.
> >
> > Same thing is discussed at  https://lkml.org/lkml/2017/6/5/681 .
> 
> Ok. I believe the answer is to fix the DT to describe the parent chain
> properly with clock-output-names. Otherwise, we have no good way of
> figuring out what the name should be.
[Rajan] clock DT binding doc says that clock-output-names property
is optional and sometimes not recommended. 
I think this patch fixes the issue we have which mandates to add clock-output-names
property (for this particular case). Also, IIUC platform driver probe in clk-fixed-factor.c
will never be called unless we use CLK_OF_DECLARE_DRIVER.
I completely agree that proper solution would be to stop using strings to
describe clock topology.

> 
> The alternative is to start working on a solution for having the clk
> framework stop using strings to describe clk topology. My plan there is
> to allow clk registration to indicate that another parent names array
> should be used with clk_get() of the device or node pointer that's
> associated with the clk during registration to find the parent . If we
> had that, then we could hook up clks into the tree by calling clk_get()
> in the framework and map through the clock-names property. This also
> gets us to a point where clk names don't have to be globally unique,
> which would be nice.
