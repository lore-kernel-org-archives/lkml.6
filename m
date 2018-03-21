Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeCUT7c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:59:32 -0400
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com ([104.47.41.60]:20640
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753119AbeCUT71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:59:27 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>
CC: Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        "Shubhrajyoti Datta" <shubhraj@xilinx.com>
Subject: RE: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
Thread-Topic: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
Thread-Index: AQHTsON3V86QHgZuvUC5fXi911EHiaPYGrEAgAMZZgA=
Date: Wed, 21 Mar 2018 19:59:21 +0000
Message-ID: <DM2PR0201MB07674E4EE557F73BC195853EB8AA0@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-4-git-send-email-jollys@xilinx.com>
 <152149019011.242365.2529338400397080149@swboyd.mtv.corp.google.com>
In-Reply-To: <152149019011.242365.2529338400397080149@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0592;7:eOxIilnnMdK3lZeIoFqupBl4rYW605QBvIdWhtFFZCQIN1d7ZD6X7czUZ8BzcL0RfY/YTCOBK64zWCQ08gWDfGJc6Hmc+L0PoNWI+28lCdnxoQjzj5Ax+qmSlpVnhCibm/ZXj2E6w/jx4F2PV6HBryTsnyCVNSgFGUCa8B0hDdG0iEwz6b4bnI3azU16Ig1MJJIDx9nZV8m4959Fv1c/yaxR9gW+rSYu7Xwe8YcONnNPvb4q8Zo3I/8WotusvKbU
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(39380400002)(13464003)(51914003)(189003)(199004)(66066001)(107886003)(3280700002)(99286004)(2906002)(2201001)(72206003)(81166006)(97736004)(76176011)(81156014)(86362001)(7696005)(478600001)(14454004)(9686003)(53546011)(6506007)(55016002)(186003)(5660300001)(110136005)(54906003)(25786009)(6246003)(59450400001)(305945005)(6436002)(102836004)(7736002)(74316002)(26005)(53936002)(3660700001)(33656002)(3846002)(2900100001)(68736007)(229853002)(2501003)(4326008)(6116002)(2950100002)(5250100002)(316002)(8676002)(106356001)(105586002)(8936002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0592;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a93d3e8e-7f95-41c7-6515-08d58f663d25
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0592;
x-ms-traffictypediagnostic: DM2PR0201MB0592:
x-microsoft-antispam-prvs: <DM2PR0201MB0592F5BAFD27C07DC04D4173B8AA0@DM2PR0201MB0592.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501326)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR0201MB0592;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0592;
x-forefront-prvs: 0618E4E7E1
x-microsoft-antispam-message-info: uF5I6WiglWdEQ6usf40kK/qSNsUPbE2v+d6+NdJz1g5r/QWYBerJ6lzCrLQg5WD3uiePdwt4PCiZ7SHNJxC3HSmteV83MCC2X3UDo2QwTG10gUs6KFyY3Y2vpyJ1zbqmgJmSN5ViTuQ2Ea7ytXJ0oW2yKucirG2ShbUIX9qiiINFSLjzAGe+APTNBIJAEYR1IrPH0awja6FbzbQBoc/DTQIXBMFLx8b3btqexI3NKXWycYtwlgtLVWSuy/u0g3nDlBzACc7Gtl9PUcqS7V/s3HdFLCIfad8sVyJJr66JNkG4UAit5pTbKON9mxGuRBE4AwwIHDnnzIQhWzRfYuzspg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93d3e8e-7f95-41c7-6515-08d58f663d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 19:59:21.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0592
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LK0109029009


Hi Stephan,

Thanks for the review,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Monday, March 19, 2018 1:10 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; linux-clk@vger.kernel.org;
> mark.rutland@arm.com; michal.simek@xilinx.com; mturquette@baylibre.com;
> robh+dt@kernel.org; sboyd@codeaurora.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Tejas Patel <TEJASP@xilinx.com>; Shubhrajyoti Datta
> <shubhraj@xilinx.com>
> Subject: Re: [PATCH 3/3] drivers: clk: Add ZynqMP clock driver
> 
> > +/**
> > + * struct zynqmp_clock - Structure for clock
> > + * @clk_name:          Clock name
> > + * @valid:             Validity flag of clock
> > + * @init_enable:       init_enable flag of clock
> > + * @type:              Clock type (Output/External)
> > + * @node:              Clock tolology nodes
> > + * @num_nodes:         Number of nodes present in topology
> > + * @parent:            structure of parent of clock
> > + * @num_parents:       Number of parents of clock
> > + */
> > +struct zynqmp_clock {
> > +       char clk_name[MAX_NAME_LEN];
> > +       u32 valid;
> > +       u32 init_enable;
> > +       enum clk_type type;
> 
> Is this ever assigned?

Yes its assigned in zynqmp_get_clock_info function below.

> 
> > + * Return: Returns status, either success or error+reason.
> > + */
> > +static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32
> *parents)
> > +{
> > +       struct zynqmp_pm_query_data qdata = {0};
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> > +       int ret;
> > +
> > +       qdata.qid = PM_QID_CLOCK_GET_PARENTS;
> > +       qdata.arg1 = clock_id;
> > +       qdata.arg2 = index;
> > +
> > +       ret = eemi_ops->query_data(qdata, ret_payload);
> > +       memcpy(parents, &ret_payload[1], CLK_GET_PARENTS_RESP_WORDS *
> 4);
> 
> Is 4 sizeof(u32)? Or is it supposed to be 3 for the 3 parents returned?

It should be 3.

> 
> > +
> > +/**
> > + * zynqmp_clk_setup() - Setup the clock framework and register clocks
> > + * @np:                Device node
> > + */
> > +static void __init zynqmp_clk_setup(struct device_node *np)
> > +{
> > +       int idx;
> > +
> > +       idx = of_property_match_string(np, "clock-names", "pss_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("pss_ref_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "video_clk");
> > +       if (idx < 0) {
> > +               pr_err("video_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "pss_alt_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("pss_alt_ref_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "aux_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("aux_ref_clk not provided\n");
> > +               return;
> > +       }
> > +       idx = of_property_match_string(np, "clock-names", "gt_crx_ref_clk");
> > +       if (idx < 0) {
> > +               pr_err("aux_ref_clk not provided\n");
> > +               return;
> > +       }
> 
> Why are we doing all this? Please don't verify DT contents in driver
> code.

The intent is not to go ahead with other clock registration if these external clocks are not available.
Where should it be validated?

> > +
> > +/**
> > + * pll_get_mode - Get mode of PLL
> > + * @hw: Handle between common and hardware-specific interfaces
> > + *
> > + * Return: Mode of PLL
> > + */
> > +static inline enum pll_mode pll_get_mode(struct clk_hw *hw)
> > +{
> > +       struct zynqmp_pll *clk = to_zynqmp_pll(hw);
> > +       u32 clk_id = clk->clk_id;
> > +       const char *clk_name = clk_hw_get_name(hw);
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> 
> How big is PAYLOAD_ARG_CNT?
> 
Its 5.

Rest all comments will be taken care in next version.


Thanks,
Jolly Shah
