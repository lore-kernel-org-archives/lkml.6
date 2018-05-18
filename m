Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeERVSo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:18:44 -0400
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:53029
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751542AbeERVSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:18:41 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
Thread-Index: AQHTsCaamP0koL1TzECLJA1Z1b6jPaPCRTqAgACcrACAAAHWAIAOxs/wgGM70SCAAJzXgIAA9cZA
Date: Fri, 18 May 2018 21:18:35 +0000
Message-ID: <SN1PR02MB37582339D5B3937748F4D9ACB8900@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
        <1519775750-21297-2-git-send-email-jollys@xilinx.com>
        <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
        <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
        <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
        <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
        <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
        <SN1PR02MB37588BFF357865F4C9628D99B8910@SN1PR02MB3758.namprd02.prod.outlook.com>
 <be5cecb2-3d0d-22f8-48a2-f94ed9546e04@samsung.com>
In-Reply-To: <be5cecb2-3d0d-22f8-48a2-f94ed9546e04@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB2096;7:UZ4kEIS18TUg37C7X6zCJtZPRpHGRD5kOkh6ppo6pF9xO0D4W7n69FK2pa9yaPVnThpKxw3BiXoyx24qOfKkPMyRMSPEbb4MTlp6roazjeQyDuI9Oy/WH0EaE/wY4arffJLeO/2voKFW97RSpMlldMTzAZUgDxt1gRYb3Dr8U5bM79qQI0fklhsh+eVael3kDUJD+Y5fWb9mg6FefpSNHUuth6+zIunP0lCZgRp4fjrNNweOb9N0e+9kEBLU1Xo8
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(13464003)(189003)(377424004)(199004)(5250100002)(26005)(186003)(6116002)(3846002)(3280700002)(5890100001)(81166006)(6916009)(81156014)(486006)(476003)(11346002)(39060400002)(68736007)(33656002)(97736004)(59450400001)(6506007)(53546011)(55016002)(102836004)(7416002)(5660300001)(3660700001)(9686003)(76176011)(478600001)(229853002)(2906002)(7736002)(54906003)(6436002)(305945005)(8676002)(7696005)(86362001)(53936002)(99286004)(93886005)(316002)(14454004)(74316002)(8936002)(6246003)(2900100001)(446003)(105586002)(106356001)(4326008)(25786009)(72206003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2096;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB2096;
x-ms-traffictypediagnostic: SN1PR02MB2096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-microsoft-antispam-prvs: <SN1PR02MB2096FD31F72EC92AB95314F5B8900@SN1PR02MB2096.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB2096;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB2096;
x-forefront-prvs: 0676F530A9
x-microsoft-antispam-message-info: fsGDVjUTwe/4ofQQqlYKwNyWnYk2FjtLEZeRgQ8Nb6tB3YMcsVT8wZFDhsqPHSe6yrtGo/PESa7XbOAQWN4vJ8IL8+oQFhPHbUJd428Gqrp+IF9Y+tp6OzOCcr+wi6C6AtTAqeIze2nzp2MQ/O2955RILa7sdLRRqz/xRlo8z//NH1t0R9d/Mrzw0h3Gpw6R
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 230b37e9-d342-48ca-9a2d-08d5bd04eade
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230b37e9-d342-48ca-9a2d-08d5bd04eade
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 21:18:35.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2096
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4ILIq9P022121

Hi Marek,

> -----Original Message-----
> From: Marek Szyprowski [mailto:m.szyprowski@samsung.com]
> Sent: Thursday, May 17, 2018 11:31 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; Geert Uytterhoeven <geert@linux-
> m68k.org>; Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>; Andy Gross
> <andy.gross@linaro.org>; Shawn Guo <shawnguo@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; Björn Andersson
> <bjorn.andersson@linaro.org>; sean.wang@mediatek.com; Michal Simek
> <michal.simek@xilinx.com>; Mark Rutland <mark.rutland@arm.com>; Rajan
> Vaja <RAJANV@xilinx.com>; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; Linux ARM <linux-arm-
> kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
> bindings
> 
> Hi Jolly,
> 
> On 2018-05-17 23:10, Jolly Shah wrote:
> 
> >>>>>> +Example:
> >>>>>> +     zynqmp-genpd {
> >>>>>> +             compatible = "xlnx,zynqmp-genpd";
> >>>>> What's the control interface for controlling the domains?
> >>>>>> +
> >>>>>> +             pd_usb0: pd-usb0 {
> >>>>>> +                     pd-id = <22>;
> >>>>>> +                     #power-domain-cells = <0>;
> >>>>> There's no need for all these sub nodes. Make #power-domain-cells
> >>>>> 1 and put the id in the cell value.
> >>>> That was my first reaction, too...
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             pd_sata: pd-sata {
> >>>>>> +                     pd-id = <28>;
> >>>>>> +                     #power-domain-cells = <0>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             pd_gpu: pd-gpu {
> >>>>>> +                     pd-id = <58 20 21>;
> >>>> ... until I saw the above.
> >>>> Controlling the GPU power area requires controlling 3 physical areas?
> >>>>
> >>>> However, doing it this way may bite you in the future, if a need
> >>>> arises to control a subset. And what about power up/down order?
> >>> What about defining 3 separate domains and arranging them in
> >>> parent-child relationship? generic power domains already supports
> >>> that and this allows to nicely define the power on/off order.
> >>>
> >>>>>> +                     #power-domain-cells = <0x0>;
> >>>>>> +             };
> >>>>>> +     };
> >> I agree it should be arranged in as parent child order to control
> >> subset or control order. Will incorporate those changes in next version.
> >
> > As suggested, I tried out parent, child approach. However what I found is
> Genpd core takes care of parent child dependencies for power on off routines
> only. In our case, We need them in attach-detach routines too. In that case, we
> need to handle dependencies manually for those routines. Please suggest better
> approach, if any.
> 
> What do you mean to handle attach-detach?
> 
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland

For our power domain driver,  we request usage of these nodes in attach routines and power them on in power on routine. So for below specific case, when attach_dev is called, all 3 nodes need to be requested.

> >>>>>> +             pd_gpu: pd-gpu {
> >>>>>> +                     pd-id = <58 20 21>;

Thanks,
Jolly Shah
