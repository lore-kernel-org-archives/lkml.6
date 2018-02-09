Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBICzh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752201AbeBICzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:55:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1492173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 9 Feb 2018 10:55:09 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: add quadspi node
Message-ID: <20180209025507.GI31910@dragon>
References: <20180126142014.13819-1-rasmus.villemoes@prevas.dk>
 <20180205080323.GP31354@dragon>
 <43c533e2-2b93-9672-3905-5f4ba8d6db19@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c533e2-2b93-9672-3905-5f4ba8d6db19@prevas.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 03:24:40PM +0100, Rasmus Villemoes wrote:
> On 2018-02-05 09:03, Shawn Guo wrote:
> > On Fri, Jan 26, 2018 at 03:20:14PM +0100, Rasmus Villemoes wrote:
> >> Add a node to device tree repesenting the QuadSPI controller present on
> >> LS1021a. Driver support has been present since e8c034b2fbe5 (mtd:
> >> spi-nor: fsl-quadspi: add support for ls1021a).
> >>
> >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > 
> > Applied, thanks.
> > 
> 
> Sorry, I didn't know you already had a similar patch queued for 4.16
> (85f8ee78ab ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC),
> so I have to ask you to unapply (or do you want me to send a revert?) -
> the ls1021a.dtsi in your imx/dt branch now has two almost-identical
> qspi: nodes.

Ah, I did not notice that either.  Patch dropped.


Shawn
