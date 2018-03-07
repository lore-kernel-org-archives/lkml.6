Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754436AbeCGLyr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:54:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754311AbeCGLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:54:45 -0500
Date: Wed, 7 Mar 2018 11:54:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ilya Ledvich <ilya@compulab.co.il>
Cc: Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Add PHY reference clock source support
Message-ID: <20180307115438.GA15139@e107981-ln.cambridge.arm.com>
References: <CAOMZO5AFC9dxhsQjmRrDA7Z3KMkEemryKOBmQhXm19NXKxHkKQ@mail.gmail.com>
 <1515073977-10153-1-git-send-email-ilya@compulab.co.il>
 <1515408232.12538.7.camel@pengutronix.de>
 <498e20c0-7b86-0f86-7555-64a012b85b9e@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498e20c0-7b86-0f86-7555-64a012b85b9e@compulab.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2018 at 03:43:41PM +0200, Ilya Ledvich wrote:
> Hi Lucas,
> 
> On 01/08/2018 12:43 PM, Lucas Stach wrote:
> >Am Donnerstag, den 04.01.2018, 15:52 +0200 schrieb Ilya Ledvich:
> >>i.MX7D variant of the IP can use either Crystal Oscillator input
> >>or internal clock input as a Reference Clock input for PCIe PHY.
> >>Add support for an optional property 'fsl,pcie-phy-refclk-internal'.
> >>If present then an internal clock input is used as PCIe PHY
> >>reference clock source. By default an external oscillator input
> >>is still used.
> >>
> >>Verified on Compulab SBC-iMX7 Single Board Computer.
> >
> >Sorry to get in late here, but I would rather have the external clock
> >input modeled as a real clock and only use the internal clock if that
> >isn't present.
> >
> 
> I tried to follow the logic described in the iMX7 TRM, where external
> oscillator is a default option. Additionally, the external clock input model
> you've suggested, requires additional changes in the iMX7 SabreSD board (and
> probably other boards which use an external input too) devicetree files.
> 
> >Are you even sure that the i.MX7 clock you mention isn't the already
> >documented "pcie_bus" clock? This one is also allowed to be sourced
> >externally on the i.MX6.
> 
> To the best of my understanding it's not the pcie_bus clock, but I'm
> absolutely sure. Could anybody from the BSP team guys elaborate on this
> issue? Thanks a lot!

I have marked this with "Changes Requested" according to Lucas'
feedback, please send a new version or let me know what I should
do with it, thanks.

Lorenzo
