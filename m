Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xfZxCNQ3GlupbAAAmS7hNA
	; Fri, 08 Jun 2018 08:01:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E74E4607DC; Fri,  8 Jun 2018 08:01:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cdm3Jdyg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5229A6074D;
	Fri,  8 Jun 2018 08:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5229A6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeFHIBP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:01:15 -0400
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:33184
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751249AbeFHIBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VcjtFTmVh+lNXq0HOMy8sczz2KBl6r6ELkL+r1zj0c=;
 b=cdm3JdygneYEyPVnZglLSc+oDvB6AgA5kxS4H764kGSDHIrc/cZxBL/ij78y+vZgu7UfDzKAdYE78+AfTbNHFhMPw+i4yF5XO0nZF3PaW7I9ar8Dhq78wINoeJrO4TYaI0/XKm+yMQft9qzMyG6+t4sJKay5tQ2l7FRk7Pa3Qug=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2784.namprd02.prod.outlook.com (10.175.49.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 8 Jun 2018 08:01:11 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::e826:8d65:9e76:6426]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::e826:8d65:9e76:6426%9]) with mapi id 15.20.0841.015; Fri, 8 Jun 2018
 08:01:11 +0000
From: Naga Sureshkumar Relli <nagasure@xilinx.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: Miquel Raynal <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "wmw2@infradead.org" <wmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Topic: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Index: AQHT/Wsmg8T3cSZFT0KMk8mIo2wW0KRU8VOAgADS3DCAABqXgIAAHbdw
Date: Fri, 8 Jun 2018 08:01:10 +0000
Message-ID: <MWHPR02MB2623170B7B99A94EFF4C1E3AAF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180607174203.035f187d@xps13>
        <MWHPR02MB2623AA49F71D3D24B997C682AF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180608075155.24915c89@bbrezillon>
In-Reply-To: <20180608075155.24915c89@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2784;7:+dkGXtb0sU04cjhA6ZuwUtWjXTNBzF96PNSYCG0nQbEtyooINiejWtTCEvid+uuWk3PDFPGyTPXm903qYiqHXodPwnHRyphRxRnOT9f8b9jguGZ++3e9HRJhlybFpEEQnuRF90OFn+DepPWLpCEHDU2IFyWtWgPxgNQx5EwefqduOTe7I6goHQ2rzOs+RnWnyWrnlcxfhbbrSQ7DpujJZ3bEtXdHWSCPxEJwPgES/w7ZKE9ZOuymm8puCP5EAXf/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2784;
x-ms-traffictypediagnostic: MWHPR02MB2784:
x-microsoft-antispam-prvs: <MWHPR02MB27843F47C470D3C8D3E83EABAF7B0@MWHPR02MB2784.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2784;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2784;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(51914003)(189003)(13464003)(54534003)(6246003)(3660700001)(93886005)(6506007)(2906002)(55236004)(102836004)(99286004)(97736004)(7696005)(76176011)(6306002)(53936002)(9686003)(11346002)(446003)(186003)(33656002)(305945005)(53546011)(3280700002)(106356001)(7416002)(229853002)(105586002)(6916009)(59450400001)(26005)(7736002)(5660300001)(68736007)(66066001)(6116002)(8676002)(3846002)(5250100002)(8936002)(478600001)(2900100001)(6436002)(74316002)(55016002)(14454004)(81156014)(81166006)(4326008)(316002)(86362001)(39060400002)(54906003)(476003)(486006)(25786009)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2784;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZOpu9Zb3Lt147QT5vM+Z3w8Hvat0GOSSd/R1g7OZnah+M13K9bjLuDNmMbvLEi+YbZhyPmvCJr4WU7K1WajyX6UuvDeBs6QPYPBG5USTpftBKMkzrEhrTpizKN4rcHoXquXkroUA3TAqOC/N4lQmRs9f+rq5sEfENjtLKxPcCsUmd0MDzGJ/yhFBxhRgfpoK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d1659337-86e3-4080-d5d7-08d5cd15ffd1
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1659337-86e3-4080-d5d7-08d5cd15ffd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 08:01:11.0398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thanks for letting us know the similar stuff.
I will look into it and if any update is required, I will update as per tha=
t.

Thanks,
Naga Sureshkumar Relli

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Friday, June 8, 2018 11:22 AM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>; richard@nod.at; wmw2@infra=
dead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; f.fainelli@gmail.com;
> mmayer@broadcom.com; rogerq@ti.com; ladis@linux-mips.org; ada@thorsis.com=
;
> honghui.zhang@mediatek.com; linux-mtd@lists.infradead.org; linux-kernel@v=
ger.kernel.org;
> nagasureshkumarrelli@gmail.com
> Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller de=
vicetree
> binding information
>=20
> On Fri, 8 Jun 2018 05:20:33 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > Hi Miquel,
> >
> > Thanks for the review.
> >
> > > -----Original Message-----
> > > From: Miquel Raynal [mailto:miquel.raynal@bootlin.com]
> > > Sent: Thursday, June 7, 2018 9:12 PM
> > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > Cc: boris.brezillon@bootlin.com; richard@nod.at; wmw2@infradead.org;
> > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > f.fainelli@gmail.com; mmayer@broadcom.com; rogerq@ti.com;
> > > ladis@linux-mips.org; ada@thorsis.com; honghui.zhang@mediatek.com;
> > > linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > nagasureshkumarrelli@gmail.com
> > > Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc
> > > controller devicetree binding information
> > >
> > > Hi Naga,
> > >
> > > On Wed, 6 Jun 2018 13:19:39 +0530, Naga Sureshkumar Relli
> > > <naga.sureshkumar.relli@xilinx.com> wrote:
> > >
> > > > Add pl353 static memory controller devicetree binding information.
> > > >
> > > > Signed-off-by: Naga Sureshkumar Relli
> > > > <naga.sureshkumar.relli@xilinx.com>
> > > > ---
> > > > Changes in v9:
> > > >  - Addressed commens given by Randy Dunlap and Miquel Raynal
> > >
> > > Can you please be more specific in your next changelog? I don't
> > > remember what I suggested a few months ago :)
> > Ok, I will update.
> >
> > >
> > > > Changes in v8:
> > > >  - None
> > > > Changes in v7:
> > > > - Corrected clocks description
> > > > - prefixed '#' for address and size cells Changes in v6:
> > > >  - None
> > > > Changes in v5:
> > > >  - Removed timing properties
> > > > Changes in v4:
> > > >  - none
> > > > Changes in v3:
> > > >  - none
> > > > Changes in v2:
> > > >  - modified timing binding info as per onfi timing parameters
> > > >  - add suffix nano second as timing unit
> > > >  - modified the clock names as per the IP spec
> > > > ---
> > > >  .../bindings/memory-controllers/pl353-smc.txt      | 53
> > > ++++++++++++++++++++++
> > > >  1 file changed, 53 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.t
> > > > xt
> > > > b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.t
> > > > xt
> > > > new file mode 100644
> > > > index 0000000..551e66b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-s
> > > > +++ mc.t
> > > > +++ xt
> > > > @@ -0,0 +1,53 @@
> > > > +Device tree bindings for ARM PL353 static memory controller
> > > > +
> > > > +PL353 static memory controller supports two kinds of memory
> > > > +interfaces.i.e NAND and SRAM/NOR interfaces.
> > > > +The actual devices are instantiated from the child nodes of pl353 =
smc node.
> > > > +
> > > > +Required properties:
> > > > +- compatible		: Should be "arm,pl353-smc-r2p1"
> > >
> > > I thing Rob prefers:
> > >
> > > - compatible: Must be one of:
> > >   * arm, pl353-smc-r2p1
> > Are you suggesting any other compatibles?
> > Or just a change from "should be to Must be one of"?
> > >
> > > > +- reg			: Controller registers map and length.
> > > > +- clock-names		: List of input clock names - "ref_clk", "aper_clk"
> > > > +			  (See clock bindings for details).
> > > > +- clocks		: Clock phandles (see clock bindings for details).
> > > > +- address-cells		: Address cells, must be 1.
> > > > +- size-cells		: Size cells. Must be 1.
> > >
> > > Please avoid padding, just this is enough:
> > >
> > > - something: And another thing.
> > Ok, I will update it.
> >
> > >
> > > > +
> > > > +Child nodes:
> > > > + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash"
> > > > +drivers are supported as child nodes.
> > > > +
> > > > +Mandatory timing properties for child nodes:
> > > > +- arm,nand-cycle-t0	: Read cycle time(t_rc).
> > > > +- arm,nand-cycle-t1	: Write cycle time(t_wc).
> > > > +- arm,nand-cycle-t2	: re_n assertion delay(t_rea).
> > > > +- arm,nand-cycle-t3	: we_n de-assertion delay(t_wp).
> > > > +- arm,nand-cycle-t4	: Status read time(t_clr)
> > > > +- arm,nand-cycle-t5	: ID read time(t_ar)
> > > > +- arm,nand-cycle-t6	: busy to re_n(t_rr)
> > >
> > > I think this has nothing to do in the DT, you should handle timings
> > > from the -
> > > >setup_data_interface() hook. If you need, you may use different
> > > >compatibles to distinguish
> > > different platform data.
> > >
> > This controller is applicable only to Zynq platform. No other platform =
will use this.
> > Basically pl353-smc.c and pl353-nand.c, both are different drivers.
> > And this data_interface hook is in nand, and to set this timings if we
> > read it from setup_data_interface(), then We need to make call from nan=
d to smc driver.
> > Let me try this.
> >
> > > > +
> > > > +for nand partition information please refer the below file
> > >
> > > s/nand/NAND/
> > I will update in next version.
> >
> > >
> > > > +Documentation/devicetree/bindings/mtd/partition.txt
> > > > +
> > > > +Example:
> > > > +	pl353smcc_0: pl353smcc@e000e000 {
> > >
> > > Why not something more explicit with the '-flash-controller' suffix?
> > Is this ok?
> > smcc: memory-controller@e000e000 {}
> >
> > >
> > > > +			compatible =3D "arm,pl353-smc-r2p1"
> > > > +			clock-names =3D "memclk", "aclk";
> > > > +			clocks =3D <&clkc 11>, <&clkc 44>;
> > > > +			reg =3D <0xe000e000 0x1000>;
> > > > +			#address-cells =3D <1>;
> > > > +			#size-cells =3D <1>;
> > > > +			ranges;
> > > > +			nand_0: nand@e1000000 {
> > > > +				compatible =3D "arm,pl353-nand-r2p1"
> > >
> > > NAND chips do not have their own compatible.
> > As I said above, SMCC controller has two interface(NAND, NOR/SRAM).
> > So to differentiate which interface is selected, we added the compatibl=
e.
> > The dts node looks below.
> > smcc: memory-controller@e000e000 {
> > 			#address-cells =3D <1>;
> > 			#size-cells =3D <1>;
> > 			clock-names =3D "memclk", "aclk";
> > 			clocks =3D <&clkc 11>, <&clkc 44>;
> > 			compatible =3D "arm,pl353-smc-r2p1";
> > 			interrupt-parent =3D <&intc>;
> > 			interrupts =3D <0 18 4>;
> > 			ranges ;
> > 			reg =3D <0xe000e000 0x1000>;
> > 			nand0: flash@e1000000 {
> > 				compatible =3D "arm,pl353-nand-r2p1";
> > 				reg =3D <0xe1000000 0x1000000>;
> > 				#address-cells =3D <0x1>;
> > 				#size-cells =3D <0x1>;
> > 			};
> > 			nor0: flash@e2000000 {
> > 				compatible =3D "cfi-flash";
> > 				reg =3D <0xe2000000 0x2000000>;
> > 				#address-cells =3D <1>;
> > 				#size-cells =3D <1>;
> > 			};
> > 		};
>=20
> This looks similar to what we have on at91 SoC with one memory controller=
 and inside this
> memory controller a dedicated logic for NAND devices. We used a represent=
ation where the
> NAND controller logic is described as a subnode of the memory controller =
and then NAND
> chips are defined under this subnode [1].
>=20
> [1]https://elixir.bootlin.com/linux/latest/source/Documentation/devicetre=
e/bindings/mtd/
> atmel-nand.txt#L84
