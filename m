Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeCTTPO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:15:14 -0400
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:15072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751186AbeCTTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:15:11 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
Thread-Topic: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
Thread-Index: AQHTsONzi5kT5xZmx0aJGWwSpBvQuKPCd+2AgALw7dCAACyGAIAI+snwgAls8ICAAZo/sA==
Date: Tue, 20 Mar 2018 19:15:05 +0000
Message-ID: <DM2PR0201MB0767673F4B956454260B67ECB8AB0@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com>
 <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
 <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
 <DM2PR0201MB0767FFBAECF3A0B30251DBB8B8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <152148383577.242365.14896728603053993045@swboyd.mtv.corp.google.com>
In-Reply-To: <152148383577.242365.14896728603053993045@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0592;7:um0P65JQdDMjeKXpQQ1XSHepwQyVgo/koTDqXRUxxkBcPghwPVG3h3YTlmQXZnG5USIzzn2RqHEVyjM0a3H9yNqWawL77Iu/7jip3gl9vm2kkSQc+992PRDbmZD7JPIyr2+ZWIbXHpPfSy2vvbBwQQfxup51InvAToTuEj2t/v6HPwLzxx+A5xkEffhYFjHu4LSsGWrObiUHXPYmF0T2t4E4T0g0ZCgZ4x9lMit4b5qqIcUpCYB5RrhZtY4zrlLw
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(377424004)(13464003)(189003)(199004)(81166006)(33656002)(7736002)(106356001)(25786009)(8676002)(99286004)(68736007)(2900100001)(93886005)(229853002)(2950100002)(3280700002)(2906002)(4326008)(6246003)(102836004)(478600001)(8936002)(14454004)(5660300001)(110136005)(76176011)(186003)(66066001)(305945005)(72206003)(74316002)(81156014)(6506007)(5250100002)(54906003)(97736004)(26005)(105586002)(53546011)(6436002)(7696005)(3846002)(53936002)(316002)(9686003)(55016002)(3660700001)(86362001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0592;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3979a874-4a4e-411d-2de8-08d58e96e34e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0592;
x-ms-traffictypediagnostic: DM2PR0201MB0592:
x-microsoft-antispam-prvs: <DM2PR0201MB0592848D5A71949C4266C26AB8AB0@DM2PR0201MB0592.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR0201MB0592;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0592;
x-forefront-prvs: 061725F016
x-microsoft-antispam-message-info: vXYhs8voLHKL3r8E9+HK/iRRigJ/XGtZjADOU1GiJa+0O82wMo9r+rw/D110G/SP07iMmqgmFmfCop7fyp9OzfzWNuXEDzA6jaHXMvlWzghqrZum/OPGafVs4honw6eyS4U45bBTEJCWJpLXvFsjjDF76mISjPSvZI+ZbKnU3Ev7KvwRekFqccAUxdcM4nmjdXxu3usymijwP4tMF0YaTYakA7J4IO2qAT9t7Ko4TQ30tO5qkkHuB/K7MRaj2iLA7CSN7hh7XYRzy9jjdwSsvSRiUEVlLc+afimI/DHwFnFpljH8uOKg5oWB9EBgR6zwyK+7KPGbiVoR1dhNFtEz1Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979a874-4a4e-411d-2de8-08d58e96e34e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 19:15:05.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0592
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KJFQPr021767

Hi Rob and Stephan,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Monday, March 19, 2018 11:24 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; Rob Herring <robh@kernel.org>
> Cc: mark.rutland@arm.com; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; mturquette@baylibre.com; sboyd@codeaurora.org;
> michal.simek@xilinx.com; Shubhrajyoti Datta <shubhraj@xilinx.com>; Rajan
> Vaja <RAJANV@xilinx.com>; linux-clk@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
> driver
> 
> Quoting Jolly Shah (2018-03-13 11:39:13)
> > Hi Rob,
> > >
> > > What is the interface to the "platform management controller"?
> > > Because you have no registers, I'm guessing a firmware interface? If
> > > so, then just define the firmware node as a clock provider.
> >
> > Yes it is firmware interface. Along with clocks, firmware interface also controls
> power and pinctrl operations as major.
> > I am not sure if I understand you correctly. Do you suggest to register clocks
> through Firmware driver or just use firmware DT node as clock provider and
> clock driver DT node can reference clocks from FW node to register same?
> 
> I would suggest making the firmware driver register the clks and act as the clk
> provider. Not sure what Rob wants.

Firmware driver just provides API interface and doesn’t actually control the clocks. Along with clocks, it provides interface for power and pinmux control also. Shall we register clocks/pins/power domains in FW driver or follow something like scpi as below and keep registration separate? 

zynqmp_firmware  {
		compatible = "xlnx,zynqmp-firmware";
		method = "smc";
		
		zynqmp_clk: zynqmp_clk {
				compatible = "xlnx,zynqmp-clk";
				#clock-cells = <1>;
				clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>
				clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk"
		};
		
		zynqmp-genpd: zynqmp-genpd {
				compatible = "xlnx,zynqmp-genpd";
				...
		};
		zynqmp-pinctrl: zynqmp-pinctrl {
                			compatible = "xlnx,zynqmp-pinctrl";
			                ...
        		};
	};

Thanks,
Jolly Shah
