Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeEQVKv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:10:51 -0400
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:61408
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751293AbeEQVKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:10:48 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Jolly Shah <JOLLYS@xilinx.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rob Herring" <robh@kernel.org>
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
Thread-Index: AQHTsCaamP0koL1TzECLJA1Z1b6jPaPCRTqAgACcrACAAAHWAIAOxs/wgGM70SA=
Date: Thu, 17 May 2018 21:10:38 +0000
Message-ID: <SN1PR02MB37588BFF357865F4C9628D99B8910@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
        <1519775750-21297-2-git-send-email-jollys@xilinx.com>
        <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
        <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
        <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
 <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
 <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
In-Reply-To: <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3710;7:E+7BJjNx7wbiYn8okvJgl4szonQJX005k6l1Hi1RjyiYactOEZiicqW9qM6KUlDF6mIL9Zl6dr2aeBEaDX0B2KwC26X1c78fL+CF79I3RAM06iGcF5n3V97pO4KxMnEScUefATAZbBN/he5ZuNesqqrYtgWkQ+UjunyiJnyr5j1IYeZQezHEBdJ6i9JHR5BQDGd+EpSjctTm8ZVUCsNE01aIS8hWnAYQGuEX7EVSltBTmwJZblxSUbIIAQxnd0+i
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(39380400002)(376002)(396003)(199004)(189003)(377424004)(13464003)(53754006)(81166006)(81156014)(54906003)(446003)(110136005)(8676002)(6436002)(316002)(102836004)(486006)(6506007)(53546011)(59450400001)(97736004)(8936002)(66066001)(39060400002)(86362001)(11346002)(5250100002)(7736002)(229853002)(476003)(5890100001)(53366004)(6246003)(53376002)(26005)(4326008)(93886005)(305945005)(3660700001)(966005)(3280700002)(74316002)(99286004)(7696005)(6116002)(3846002)(478600001)(6306002)(55016002)(53936002)(72206003)(76176011)(105586002)(14454004)(106356001)(9686003)(25786009)(2900100001)(2906002)(7416002)(68736007)(33656002)(5660300001)(10090945008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3710;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3710;
x-ms-traffictypediagnostic: SN1PR02MB3710:
x-microsoft-antispam-prvs: <SN1PR02MB37104529D6BF20604EEB46DAB8910@SN1PR02MB3710.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(265313219721884)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB3710;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3710;
x-forefront-prvs: 067553F396
x-microsoft-antispam-message-info: GK7NU2W62YdHnF+CHKUPxwX48vGsYqvS8w7c2ppeP6ayUQmhhPhdwwcRPiEsGI9/68CJtnae3/FjXt08sb/guLbJ0tn1qGWBVwYHDBywXdH89XkL0wZ/1uuj7C7y65q6wJRtR77yZ8pkODmO76TtT+jOSXruOKi/6NafYnsLIKq4f9qnaqL5H6hbxJmOaqmW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fef4d362-b0cf-4b02-9ff9-08d5bc3aa3e3
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef4d362-b0cf-4b02-9ff9-08d5bc3aa3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 21:10:38.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3710
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HLAvSn011029

Hi Marek,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Jolly Shah
> Sent: Thursday, March 15, 2018 10:47 AM
> To: Marek Szyprowski <m.szyprowski@samsung.com>; Geert Uytterhoeven
> <geert@linux-m68k.org>; Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>; Andy Gross
> <andy.gross@linaro.org>; Shawn Guo <shawnguo@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; Björn Andersson
> <bjorn.andersson@linaro.org>; sean.wang@mediatek.com; Michal Simek
> <michal.simek@xilinx.com>; Mark Rutland <mark.rutland@arm.com>; Rajan
> Vaja <RAJANV@xilinx.com>; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; Linux ARM <linux-arm-
> kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
> bindings
> 
> [This sender failed our fraud detection checks and may not be who they appear
> to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing]
> 
> Hi Rob, Geert, Marek,
> 
> > -----Original Message-----
> > From: Marek Szyprowski [mailto:m.szyprowski@samsung.com]
> > Sent: Tuesday, March 06, 2018 12:06 AM
> > To: Geert Uytterhoeven <geert@linux-m68k.org>; Rob Herring
> > <robh@kernel.org>
> > Cc: Jolly Shah <JOLLYS@xilinx.com>; Matthias Brugger
> > <matthias.bgg@gmail.com>; Andy Gross <andy.gross@linaro.org>; Shawn
> > Guo <shawnguo@kernel.org>; Geert Uytterhoeven
> > <geert+renesas@glider.be>; Björn Andersson
> > <bjorn.andersson@linaro.org>; sean.wang@mediatek.com; Michal Simek
> > <michal.simek@xilinx.com>; Mark Rutland <mark.rutland@arm.com>; Rajan
> > Vaja <RAJANV@xilinx.com>; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE
> > TREE BINDINGS <devicetree@vger.kernel.org>; Linux ARM <linux-arm-
> > kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Jolly Shah <JOLLYS@xilinx.com>
> > Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
> > bindings
> >
> > Hi All,
> >
> > On 2018-03-06 08:59, Geert Uytterhoeven wrote:
> > > Hi Rob, Jolly,
> > >
> > > On Mon, Mar 5, 2018 at 11:39 PM, Rob Herring <robh@kernel.org> wrote:
> > >> On Tue, Feb 27, 2018 at 03:55:49PM -0800, Jolly Shah wrote:
> > >>> Add documentation to describe ZynqMP power domain bindings.
> > >>>
> > >>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > >>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > >>> ---
> > >>>   .../devicetree/bindings/power/zynqmp-genpd.txt     | 46
> > ++++++++++++++++++++++
> > >>>   1 file changed, 46 insertions(+)
> > >>>   create mode 100644
> > >>> Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> > >>>
> > >>> diff --git
> > >>> a/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> > >>> b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> > >>> new file mode 100644
> > >>> index 0000000..25f9711
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> > >>> +This node contains a number of subnodes, each representing a
> > >>> +single PM domain that PM domain consumer devices reference.
> > >>> +
> > >>> +== PM Domain Nodes ==
> > >>> +
> > >>> +Required properties:
> > >>> + - #power-domain-cells: Number of cells in a PM domain specifier.
> > >>> +Must be
> > 0.
> > >>> + - pd-id: List of domain identifiers of as defined by platform firmware.
> > These
> > >>> +       identifiers are passed to the PM firmware.
> > >>> +
> > >>> +Example:
> > >>> +     zynqmp-genpd {
> > >>> +             compatible = "xlnx,zynqmp-genpd";
> > >> What's the control interface for controlling the domains?
> > >>> +
> > >>> +             pd_usb0: pd-usb0 {
> > >>> +                     pd-id = <22>;
> > >>> +                     #power-domain-cells = <0>;
> > >> There's no need for all these sub nodes. Make #power-domain-cells 1
> > >> and put the id in the cell value.
> > > That was my first reaction, too...
> > >>> +             };
> > >>> +
> > >>> +             pd_sata: pd-sata {
> > >>> +                     pd-id = <28>;
> > >>> +                     #power-domain-cells = <0>;
> > >>> +             };
> > >>> +
> > >>> +             pd_gpu: pd-gpu {
> > >>> +                     pd-id = <58 20 21>;
> > > ... until I saw the above.
> > > Controlling the GPU power area requires controlling 3 physical areas?
> > >
> > > However, doing it this way may bite you in the future, if a need
> > > arises to control a subset. And what about power up/down order?
> >
> > What about defining 3 separate domains and arranging them in
> > parent-child relationship? generic power domains already supports that
> > and this allows to nicely define the power on/off order.
> >
> > >>> +                     #power-domain-cells = <0x0>;
> > >>> +             };
> > >>> +     };
> >
> 
> I agree it should be arranged in as parent child order to control subset or control
> order. Will incorporate those changes in next version.
> 
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland


As suggested, I tried out parent, child approach. However what I found is Genpd core takes care of parent child dependencies for power on off routines only. In our case, We need them in attach-detach routines too. In that case, we need to handle dependencies manually for those routines. Please suggest better approach, if any.

Thanks,
Jolly Shah
