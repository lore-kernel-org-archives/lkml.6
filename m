Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qKo0K48ZGlv5GgAAmS7hNA
	; Fri, 08 Jun 2018 05:52:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9FE92607DC; Fri,  8 Jun 2018 05:52:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A32B86074D;
	Fri,  8 Jun 2018 05:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A32B86074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeFHFwJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:52:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60199 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeFHFwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:52:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5390A20728; Fri,  8 Jun 2018 07:52:06 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BF934203EB;
        Fri,  8 Jun 2018 07:51:55 +0200 (CEST)
Date: Fri, 8 Jun 2018 07:51:55 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
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
Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Message-ID: <20180608075155.24915c89@bbrezillon>
In-Reply-To: <MWHPR02MB2623AA49F71D3D24B997C682AF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180607174203.035f187d@xps13>
        <MWHPR02MB2623AA49F71D3D24B997C682AF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018 05:20:33 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Miquel,
> 
> Thanks for the review.
> 
> > -----Original Message-----
> > From: Miquel Raynal [mailto:miquel.raynal@bootlin.com]
> > Sent: Thursday, June 7, 2018 9:12 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: boris.brezillon@bootlin.com; richard@nod.at; wmw2@infradead.org;
> > computersforpeace@gmail.com; marek.vasut@gmail.com; f.fainelli@gmail.com;
> > mmayer@broadcom.com; rogerq@ti.com; ladis@linux-mips.org; ada@thorsis.com;
> > honghui.zhang@mediatek.com; linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org;
> > nagasureshkumarrelli@gmail.com
> > Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller devicetree
> > binding information
> > 
> > Hi Naga,
> > 
> > On Wed, 6 Jun 2018 13:19:39 +0530, Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com> wrote:
> >   
> > > Add pl353 static memory controller devicetree binding information.
> > >
> > > Signed-off-by: Naga Sureshkumar Relli
> > > <naga.sureshkumar.relli@xilinx.com>
> > > ---
> > > Changes in v9:
> > >  - Addressed commens given by Randy Dunlap and Miquel Raynal  
> > 
> > Can you please be more specific in your next changelog? I don't remember what I suggested a
> > few months ago :)  
> Ok, I will update.
> 
> >   
> > > Changes in v8:
> > >  - None
> > > Changes in v7:
> > > - Corrected clocks description
> > > - prefixed '#' for address and size cells Changes in v6:
> > >  - None
> > > Changes in v5:
> > >  - Removed timing properties
> > > Changes in v4:
> > >  - none
> > > Changes in v3:
> > >  - none
> > > Changes in v2:
> > >  - modified timing binding info as per onfi timing parameters
> > >  - add suffix nano second as timing unit
> > >  - modified the clock names as per the IP spec
> > > ---
> > >  .../bindings/memory-controllers/pl353-smc.txt      | 53  
> > ++++++++++++++++++++++  
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > > b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > > new file mode 100644
> > > index 0000000..551e66b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.t
> > > +++ xt
> > > @@ -0,0 +1,53 @@
> > > +Device tree bindings for ARM PL353 static memory controller
> > > +
> > > +PL353 static memory controller supports two kinds of memory
> > > +interfaces.i.e NAND and SRAM/NOR interfaces.
> > > +The actual devices are instantiated from the child nodes of pl353 smc node.
> > > +
> > > +Required properties:
> > > +- compatible		: Should be "arm,pl353-smc-r2p1"  
> > 
> > I thing Rob prefers:
> > 
> > - compatible: Must be one of:
> >   * arm, pl353-smc-r2p1  
> Are you suggesting any other compatibles?
> Or just a change from "should be to Must be one of"?
> >   
> > > +- reg			: Controller registers map and length.
> > > +- clock-names		: List of input clock names - "ref_clk", "aper_clk"
> > > +			  (See clock bindings for details).
> > > +- clocks		: Clock phandles (see clock bindings for details).
> > > +- address-cells		: Address cells, must be 1.
> > > +- size-cells		: Size cells. Must be 1.  
> > 
> > Please avoid padding, just this is enough:
> > 
> > - something: And another thing.  
> Ok, I will update it.
> 
> >   
> > > +
> > > +Child nodes:
> > > + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash"
> > > +drivers are supported as child nodes.
> > > +
> > > +Mandatory timing properties for child nodes:
> > > +- arm,nand-cycle-t0	: Read cycle time(t_rc).
> > > +- arm,nand-cycle-t1	: Write cycle time(t_wc).
> > > +- arm,nand-cycle-t2	: re_n assertion delay(t_rea).
> > > +- arm,nand-cycle-t3	: we_n de-assertion delay(t_wp).
> > > +- arm,nand-cycle-t4	: Status read time(t_clr)
> > > +- arm,nand-cycle-t5	: ID read time(t_ar)
> > > +- arm,nand-cycle-t6	: busy to re_n(t_rr)  
> > 
> > I think this has nothing to do in the DT, you should handle timings from the -  
> > >setup_data_interface() hook. If you need, you may use different compatibles to distinguish  
> > different platform data.
> >   
> This controller is applicable only to Zynq platform. No other platform will use this.
> Basically pl353-smc.c and pl353-nand.c, both are different drivers.
> And this data_interface hook is in nand, and to set this timings if we read it from setup_data_interface(), then
> We need to make call from nand to smc driver.
> Let me try this.
> 
> > > +
> > > +for nand partition information please refer the below file  
> > 
> > s/nand/NAND/  
> I will update in next version.
> 
> >   
> > > +Documentation/devicetree/bindings/mtd/partition.txt
> > > +
> > > +Example:
> > > +	pl353smcc_0: pl353smcc@e000e000 {  
> > 
> > Why not something more explicit with the '-flash-controller' suffix?  
> Is this ok?
> smcc: memory-controller@e000e000 {}
> 
> >   
> > > +			compatible = "arm,pl353-smc-r2p1"
> > > +			clock-names = "memclk", "aclk";
> > > +			clocks = <&clkc 11>, <&clkc 44>;
> > > +			reg = <0xe000e000 0x1000>;
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			ranges;
> > > +			nand_0: nand@e1000000 {
> > > +				compatible = "arm,pl353-nand-r2p1"  
> > 
> > NAND chips do not have their own compatible.  
> As I said above, SMCC controller has two interface(NAND, NOR/SRAM).
> So to differentiate which interface is selected, we added the compatible.
> The dts node looks below.
> smcc: memory-controller@e000e000 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			clock-names = "memclk", "aclk";
> 			clocks = <&clkc 11>, <&clkc 44>;
> 			compatible = "arm,pl353-smc-r2p1";
> 			interrupt-parent = <&intc>;
> 			interrupts = <0 18 4>;
> 			ranges ;
> 			reg = <0xe000e000 0x1000>;
> 			nand0: flash@e1000000 {
> 				compatible = "arm,pl353-nand-r2p1";
> 				reg = <0xe1000000 0x1000000>;
> 				#address-cells = <0x1>;
> 				#size-cells = <0x1>;
> 			};
> 			nor0: flash@e2000000 {
> 				compatible = "cfi-flash";
> 				reg = <0xe2000000 0x2000000>;
> 				#address-cells = <1>;
> 				#size-cells = <1>;
> 			};
> 		};

This looks similar to what we have on at91 SoC with one memory
controller and inside this memory controller a dedicated logic for NAND
devices. We used a representation where the NAND controller logic is
described as a subnode of the memory controller and then NAND chips are
defined under this subnode [1].

[1]https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mtd/atmel-nand.txt#L84
