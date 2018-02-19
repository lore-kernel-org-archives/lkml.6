Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBSJTd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:19:33 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:56283 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbeBSJTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:19:31 -0500
Date: Mon, 19 Feb 2018 10:19:12 +0100
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        magnus.damm@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] Documentation: devicetree: R-Car M3-N SoC DT
 bindings
Message-ID: <20180219091911.m7ixqwp22weghhmi@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-2-git-send-email-jacopo+renesas@jmondi.org>
 <20180214100150.dv2fkffussrfqkme@verge.net.au>
 <20180219025213.iqu7vsmrsbbqe4ky@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219025213.iqu7vsmrsbbqe4ky@rob-hp-laptop>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 08:52:13PM -0600, Rob Herring wrote:
> On Wed, Feb 14, 2018 at 11:01:53AM +0100, Simon Horman wrote:
> > On Tue, Feb 13, 2018 at 10:45:48AM +0100, Jacopo Mondi wrote:
> > > Add device tree bindings documentation for Renesas R-Car M3-N (r8a77965)
> > > SoC.
> > > 
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > 
> > Thanks, this looks fine to me but I think the subject should be updated to
> > 
> > dt-bindings: arm: document R8A77965 SoC bindings
> > 
> > I'll let this sit for a few days to see if any other review is forthcoming.
> > 
> > > ---
> > >  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, applied as

dt-bindings: arm: Document R-Car M3-N SoC DT bindings
