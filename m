Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeCMSj2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:39:28 -0400
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:56672
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751996AbeCMSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:39:24 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Rob Herring <robh@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
Thread-Topic: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
Thread-Index: AQHTsONzi5kT5xZmx0aJGWwSpBvQuKPCd+2AgALw7dCAACyGAIAI+snw
Date: Tue, 13 Mar 2018 18:39:13 +0000
Message-ID: <DM2PR0201MB0767FFBAECF3A0B30251DBB8B8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com>
 <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
 <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
In-Reply-To: <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0862;7:WfcFzY0F+ecgKE6GWEGyqvjRLiVZNDzLEI+Cqe3M5szpiltSIBRZCvIvWDTsSwtPX8/XfVk6ZtXSD2Ji64YlWQvrGDDqAJ5T3IXmDZGtVM6jlOshldo4NYExactaPWdRX6GVi42hkxQ4Fel8gnzNwU/68ixpw1Of6YcbQpMtl+wdHb7TOvKS5TMKPXZ7mr6QH4j7Qd99EO/y44oFba1wUsoG9ZCh/CAkbqllkwZWQskJUounFOnkv5aFWl3PyCcU
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(39380400002)(346002)(376002)(199004)(189003)(13464003)(26005)(6436002)(54906003)(229853002)(4326008)(3280700002)(9686003)(186003)(2906002)(76176011)(3660700001)(5250100002)(93886005)(55016002)(105586002)(5660300001)(68736007)(7696005)(316002)(6916009)(86362001)(6506007)(53546011)(2950100002)(99286004)(72206003)(33656002)(102836004)(2900100001)(8936002)(66066001)(478600001)(305945005)(97736004)(74316002)(14454004)(7736002)(25786009)(6116002)(8676002)(106356001)(3846002)(6246003)(81156014)(53936002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0862;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b09e9136-0444-46c4-dfbb-08d58911b80b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0862;
x-ms-traffictypediagnostic: DM2PR0201MB0862:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-microsoft-antispam-prvs: <DM2PR0201MB086212E4B68CC48E8A1D0BC9B8D20@DM2PR0201MB0862.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR0201MB0862;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0862;
x-forefront-prvs: 0610D16BBE
x-microsoft-antispam-message-info: LhX2IfVUkFoolyjWSFTrO3Dfif+PkXx4gZ2pj9r7RyA5tNOcJ0siwQ/FwUR9ogfEWxeKlgcDwZ9jmcSGk9/Jk6X+G65LkY9d2u39T0XfJeVsmkrl448Y4gKSu0zDfcQFCkfQPc+thccVu/A8hZx9IyCsQKxzDAOlAhTIElWZRv7b8u8tDSzttc1T8Fdt1naHqcenvVpwHFdK310ATSXTg5hGPXJd+JcEytibgcBnWGmQTP/On3JQwc8Sw8RquRQNOuqzbgIpR0Fif4D+81r4K8JqDJhL5EuG0U1rzWcjv2o5G+AZpVUSNT8LaseOsl/5R8HRO3KKa0KDtRG5eJAvUQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09e9136-0444-46c4-dfbb-08d58911b80b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 18:39:13.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0862
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DIdVes006471

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, March 07, 2018 5:20 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: mturquette@baylibre.com; sboyd@codeaurora.org;
> michal.simek@xilinx.com; mark.rutland@arm.com; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; Shubhrajyoti Datta <shubhraj@xilinx.com>; linux-
> kernel@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
> driver
> 
> On Wed, Mar 7, 2018 at 4:47 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> > Hi Rob,
> >
> >
> >> -----Original Message-----
> >> From: Rob Herring [mailto:robh@kernel.org]
> >> Sent: Monday, March 05, 2018 5:46 PM
> >> To: Jolly Shah <JOLLYS@xilinx.com>
> >> Cc: mturquette@baylibre.com; sboyd@codeaurora.org;
> >> michal.simek@xilinx.com; mark.rutland@arm.com;
> >> linux-clk@vger.kernel.org; devicetree@vger.kernel.org; Shubhrajyoti
> >> Datta <shubhraj@xilinx.com>; linux- kernel@vger.kernel.org; Jolly
> >> Shah <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> >> linux-arm-kernel@lists.infradead.org
> >> Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP
> >> clock driver
> >>
> >> On Wed, Feb 28, 2018 at 02:27:40PM -0800, Jolly Shah wrote:
> >> > Add documentation to describe Xilinx ZynqMP clock driver bindings.
> >> >
> >> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> >> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> >> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >> > ---
> 
> >> > +95         dpll_post_src
> >> > +96         vpll_int
> >> > +97         vpll_pre_src
> >> > +98         vpll_half
> >> > +99         vpll_int_mux
> >> > +100                vpll_post_src
> >> > +101                can0_mio
> >> > +102                can1_mio
> >> > +
> >> > +Example:
> >> > +
> >> > +clk: clk {
> >> > +   #clock-cells = <1>;
> >> > +   compatible = "xlnx,zynqmp-clk";
> >>
> >> How do you control the clocks?
> >
> > Clocks are controlled by a dedicated platform management controller. Above
> clock ids are used to identify clocks between master and PMU.
> 
> What is the interface to the "platform management controller"? Because you
> have no registers, I'm guessing a firmware interface? If so, then just define the
> firmware node as a clock provider.

Yes it is firmware interface. Along with clocks, firmware interface also controls power and pinctrl operations as major.
I am not sure if I understand you correctly. Do you suggest to register clocks through Firmware driver or just use firmware DT node as clock provider and clock driver DT node can reference clocks from FW node to register same?
 
> 
> Rob
