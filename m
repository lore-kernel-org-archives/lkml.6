Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDQKzE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:55:04 -0400
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:5531
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752067AbeDQKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:55:02 -0400
From: Radhey Shyam Pandey <radheys@xilinx.com>
To: Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Appana Durga Kedareswara Rao" <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property
 has_axieth_connected
Thread-Topic: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property
 has_axieth_connected
Thread-Index: AQHTym7jCq0jRY4Yk06xwJmBWFUc+6P7U5gAgAmJVeA=
Date: Tue, 17 Apr 2018 10:54:57 +0000
Message-ID: <MWHPR02MB3293878F33D165B799DB8A96C7B70@MWHPR02MB3293.namprd02.prod.outlook.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-2-git-send-email-radheys@xilinx.com>
 <20180411090525.GX6014@localhost>
In-Reply-To: <20180411090525.GX6014@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3232;7:0wdsgOu+qyMkm0/CttNL55wUUygQacd91JzmseeXoW5MYy6M+3+4xJHxyjuGpOYnGpowbTPI20XPrr+NTS+O3TkSt2lCDIvrgKzPzkDkcbXaqU+uiazJ9KI8FUblHvZpj2HDWiL9TXnuK/nMQQGZKWqtNkmnzY0MPwyazm4k2GXNmayaO9BxfFKzb/7BTI6cPebh8yDxvA76ytwpmbtJdilZxgw13E1UIewN0du6U2dz0E8kq5KD4dHJ7YIuFm8w
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(13464003)(199004)(6246003)(74316002)(305945005)(316002)(7736002)(25786009)(2906002)(68736007)(186003)(105586002)(14454004)(6436002)(76176011)(99286004)(7696005)(53546011)(106356001)(53936002)(55236004)(3660700001)(33656002)(6506007)(66066001)(59450400001)(110136005)(2900100001)(5250100002)(3280700002)(54906003)(486006)(102836004)(81156014)(81166006)(478600001)(11346002)(8936002)(476003)(446003)(4326008)(8676002)(2501003)(9686003)(5660300001)(97736004)(229853002)(26005)(55016002)(6116002)(86362001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3232;H:MWHPR02MB3293.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3232;
x-ms-traffictypediagnostic: MWHPR02MB3232:
x-microsoft-antispam-prvs: <MWHPR02MB3232F87B8CB90533EB899D2CC7B70@MWHPR02MB3232.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR02MB3232;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3232;
x-forefront-prvs: 0645BEB7AA
x-microsoft-antispam-message-info: 1IK6FJhhFhRwu1oKpipXlOLI3geikRPj16tI9RPJR6R319zM6PNlT3jci6+rWU2zzcmiTVU6i3LRHG7zZE0ETIS5lYkp6VST4baTJkpmRKrA6DlXbvs3tL9K6p7EhGoNDPpYVDMNjhORAMTNxM/xYG/8ip8qToRoPlsUp9VcNXIj/15dVEahUjy1Xykzm5lB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ab597b42-20b9-4c78-f9d6-08d5a451a8ae
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab597b42-20b9-4c78-f9d6-08d5a451a8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 10:54:57.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HAtAdE007938

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul@intel.com]
> Sent: Wednesday, April 11, 2018 2:35 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; Rob Herring
> <robh@kernel.org>; devicetree@vger.kernel.org
> Cc: dan.j.williams@intel.com; michal.simek@xilinx.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; lars@metafoo.de; dmaengine@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property
> has_axieth_connected
> 
> On Mon, Apr 02, 2018 at 04:09:01PM +0530, Radhey Shyam Pandey wrote:
> > Add an optional AXI DMA property 'has_axieth_connected'. This can be
> > specified to indicate that AXI DMA is connected to AXI Ethernet in
> > hardware design and dma driver needs to do some additional handling.
> 
> 1. why are DT people and list not added to this? I have added that
Sorry missed it. I will add in v2. Thanks.
> 2. should we have a property for a specific peripheral? Wouldn't it help to
> have
> a generic property for peripheral connected which can be scaled to more IPs
> being connected in future?
Good point! I will rename this property to xlnx,axistream-connected and
update description. It can then be reused for other usecases as well.
> 3. Please use right subsystem name, it damengine: not dma:
I will fix.
> 
> >
> > Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> > ---
> >  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > index a2b8bfa..5d592e3 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > @@ -42,6 +42,7 @@ Optional properties:
> >  	the hardware.
> >  Optional properties for AXI DMA:
> >  - xlnx,mcdma: Tells whether configured for multi-channel mode in the
> hardware.
> > +- xlnx,axieth-connected: Tells whether AXI DMA is connected to AXI
> Ethernet.
> >  Optional properties for VDMA:
> >  - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
> >  	It takes following values:
> > --
> > 1.7.1
> >
> 
> --
> ~Vinod
