Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425390AbeBOP4w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:56:52 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50799 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425373AbeBOP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:56:43 -0500
Date: Thu, 15 Feb 2018 16:56:39 +0100
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, robh+dt@kernel.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/15] Documentation: devicetree: dma: Add r8a77965 dmac
Message-ID: <20180215155638.kh6hxxo4tmit3jj4@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-7-git-send-email-jacopo+renesas@jmondi.org>
 <20180215153948.puwztivx3zwtqxet@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215153948.puwztivx3zwtqxet@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:39:49PM +0100, Simon Horman wrote:
> On Tue, Feb 13, 2018 at 10:45:53AM +0100, Jacopo Mondi wrote:
> > Add documentation for r8a77965 compatible string to rcar-dmac device
> > tree bindings documentation.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Sorry for not noticing this the first time around.

I think a better subject would be:

dt-bindings: dmaengine: rcar-dmac: document R8A77964 support
