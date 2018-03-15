Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeCORrM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:47:12 -0400
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:55376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752173AbeCORrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:47:10 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?utf-8?B?QmrDtnJuIEFuZGVyc3Nvbg==?= <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Mark Rutland" <mark.rutland@arm.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
Thread-Index: AQHTsCaamP0koL1TzECLJA1Z1b6jPaPCRTqAgACcrACAAAHWAIAOxs/w
Date: Thu, 15 Mar 2018 17:47:01 +0000
Message-ID: <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
        <1519775750-21297-2-git-send-email-jollys@xilinx.com>
        <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
        <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
        <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
 <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
In-Reply-To: <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [73.162.184.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0750;6:kA+2EB3hulJCxxoz8A+9sEYXRPWvVZ1vwxBpUnbAGsgHyfZ5j7Hp1k3piJUK1dxACqW0uYI1B8xRa3imkUbuAeRN3t7KTw4wN016MKTKMSYG1Huo5DsPe/g4ujCR1djurAdahQIuy3GIYzvVT9if8NW9zPKg45b/2P194KJcx9dWJwkKvbRrl/DC293t/gOKIdo1gj0m5RLvrj8HkC3XNK2EDwtu4KnNyR7h+8kmNhpSOqwYT7Pn1OnLx73SetI993afFGQbleazX/yxltAfj2n3OiVTufG58WNYBf00A39n4lWAjgqBq9IPum8DqAIrwR/icB075feZiCSHbL5/gsdB7il8i2PuttZ7RBOv9tyO8ubcDxSspn9pP74Ova+o;5:L1YaXdXcwWZ5aSraZwhxyMAkKhZXj2qiIQz8Yrlt6jiNH/IeLUEdnvNpZouLRuwcHkADICxi5KeAh+PEyxxZSBOpwExtdn5lusMnGqOaknrAmA9++rs+xIRg1x3pwPwe3BPrv/+a0tlYMCw+NprVMEqt8oruaBlgHcG9udbg1Xw=;24:DusX1l/BH+GU+Vkl9F6MzK446v9nwEoLtKvppURbYVuiBhOeprb85s9ZTTgNFK7r6WtNttFY3e0OItyoMvknU/4s29JwKFT2+QqzqEiYWlo=;7:XBjVIO1LFIij232cO7qk0cwDzKUHk5d6uTj1YWPOwziHpseAelzQGwOTe3c+HNb3dcn99MTg+OA1TZZPjeZiOSMn5xIsp7zd6YvqWM3i794UFagD19E19XQ90i0Kg1+GiHeeLLbAg+ewqirED8RA7uVS+2gp9yQKiiTYMFLsJy8oEUnj+6SyGBMIQaer6FI5l8AXTV1OwVx8qLgjAubPXUBi+Y03N1245aVSFt4Qhpmf9ow4umcEfPaPFRfOn8z7
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(396003)(39380400002)(346002)(39860400002)(377424004)(13464003)(53754006)(199004)(189003)(8676002)(6116002)(39060400002)(6506007)(8936002)(66066001)(76176011)(102836004)(3846002)(25786009)(59450400001)(99286004)(7416002)(14454004)(3280700002)(5250100002)(186003)(305945005)(478600001)(93886005)(74316002)(7696005)(72206003)(2906002)(97736004)(53546011)(81156014)(26005)(316002)(7736002)(2900100001)(105586002)(110136005)(2950100002)(55016002)(4326008)(106356001)(229853002)(81166006)(6246003)(86362001)(9686003)(5660300001)(33656002)(3660700001)(6436002)(53936002)(54906003)(68736007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0750;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5abfd650-b761-45fd-be4e-08d58a9cc1bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0750;
x-ms-traffictypediagnostic: DM2PR0201MB0750:
x-microsoft-antispam-prvs: <DM2PR0201MB075041CCD733E61B05272193B8D00@DM2PR0201MB0750.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR0201MB0750;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0750;
x-forefront-prvs: 0612E553B4
x-microsoft-antispam-message-info: BsY4DC+gH1ubTvO4ccnOAnwR5hdQ7/iQM8oqVMActsqmJ2Ae6nhvrDjECDiG1g0+WBi1P9xP2syou7Tz1iP2Tmabk0SCs0XmnHXELSJ1qVqu+2JKVi7rttK+Ub8Cj7KLaIJOQVeJqnOVkLYhp4sohmmQIWfCnIX6V55ot1mkiR3/FcG9LL+Wgw8vVFd+/FoYEuBCSw9ROtKmUqXgBBrcd2WiJrRqvbwpFFvqw5IRq1UO0DWuuep5xZTqxk7Ga/hvBhBkMkgK3gwhnNdCOV0EBdITR85rLROEvC7DPmV/w6k4o2D9McH6xksvtlU76xMvfHxstoPUjfMA+JuSy8yn/Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abfd650-b761-45fd-be4e-08d58a9cc1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 17:47:01.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0750
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2FHlGBf031560

Hi Rob, Geert, Marek,

> -----Original Message-----
> From: Marek Szyprowski [mailto:m.szyprowski@samsung.com]
> Sent: Tuesday, March 06, 2018 12:06 AM
> To: Geert Uytterhoeven <geert@linux-m68k.org>; Rob Herring
> <robh@kernel.org>
> Cc: Jolly Shah <JOLLYS@xilinx.com>; Matthias Brugger
> <matthias.bgg@gmail.com>; Andy Gross <andy.gross@linaro.org>; Shawn Guo
> <shawnguo@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Björn Andersson <bjorn.andersson@linaro.org>; sean.wang@mediatek.com;
> Michal Simek <michal.simek@xilinx.com>; Mark Rutland
> <mark.rutland@arm.com>; Rajan Vaja <RAJANV@xilinx.com>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; Linux ARM <linux-arm-
> kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
> bindings
> 
> Hi All,
> 
> On 2018-03-06 08:59, Geert Uytterhoeven wrote:
> > Hi Rob, Jolly,
> >
> > On Mon, Mar 5, 2018 at 11:39 PM, Rob Herring <robh@kernel.org> wrote:
> >> On Tue, Feb 27, 2018 at 03:55:49PM -0800, Jolly Shah wrote:
> >>> Add documentation to describe ZynqMP power domain bindings.
> >>>
> >>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> >>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> >>> ---
> >>>   .../devicetree/bindings/power/zynqmp-genpd.txt     | 46
> ++++++++++++++++++++++
> >>>   1 file changed, 46 insertions(+)
> >>>   create mode 100644
> >>> Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>> b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>> new file mode 100644
> >>> index 0000000..25f9711
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>> +This node contains a number of subnodes, each representing a single
> >>> +PM domain that PM domain consumer devices reference.
> >>> +
> >>> +== PM Domain Nodes ==
> >>> +
> >>> +Required properties:
> >>> + - #power-domain-cells: Number of cells in a PM domain specifier. Must be
> 0.
> >>> + - pd-id: List of domain identifiers of as defined by platform firmware.
> These
> >>> +       identifiers are passed to the PM firmware.
> >>> +
> >>> +Example:
> >>> +     zynqmp-genpd {
> >>> +             compatible = "xlnx,zynqmp-genpd";
> >> What's the control interface for controlling the domains?
> >>> +
> >>> +             pd_usb0: pd-usb0 {
> >>> +                     pd-id = <22>;
> >>> +                     #power-domain-cells = <0>;
> >> There's no need for all these sub nodes. Make #power-domain-cells 1
> >> and put the id in the cell value.
> > That was my first reaction, too...
> >>> +             };
> >>> +
> >>> +             pd_sata: pd-sata {
> >>> +                     pd-id = <28>;
> >>> +                     #power-domain-cells = <0>;
> >>> +             };
> >>> +
> >>> +             pd_gpu: pd-gpu {
> >>> +                     pd-id = <58 20 21>;
> > ... until I saw the above.
> > Controlling the GPU power area requires controlling 3 physical areas?
> >
> > However, doing it this way may bite you in the future, if a need
> > arises to control a subset. And what about power up/down order?
> 
> What about defining 3 separate domains and arranging them in parent-child
> relationship? generic power domains already supports that and this allows to
> nicely define the power on/off order.
> 
> >>> +                     #power-domain-cells = <0x0>;
> >>> +             };
> >>> +     };
> 

I agree it should be arranged in as parent child order to control subset or control order. Will incorporate those changes in next version.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
