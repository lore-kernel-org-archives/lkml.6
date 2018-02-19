Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeBSC6r (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:58:47 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42099 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeBSC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:58:46 -0500
X-Google-Smtp-Source: AH8x224XXCsnBij04f6pwPcrSWRmmmf0RaYuvSXdDpOJFR+BnR9EDBlg7f17CNqDHjYqsHf1B5P/Qg==
Date: Sun, 18 Feb 2018 20:58:44 -0600
From: Rob Herring <robh@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, magnus.damm@gmail.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/15] Documentation: devicetree: dma: Add r8a77965 dmac
Message-ID: <20180219025844.vqol334fs642trnr@rob-hp-laptop>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-7-git-send-email-jacopo+renesas@jmondi.org>
 <20180215153948.puwztivx3zwtqxet@verge.net.au>
 <20180215155638.kh6hxxo4tmit3jj4@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215155638.kh6hxxo4tmit3jj4@verge.net.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:56:39PM +0100, Simon Horman wrote:
> On Thu, Feb 15, 2018 at 04:39:49PM +0100, Simon Horman wrote:
> > On Tue, Feb 13, 2018 at 10:45:53AM +0100, Jacopo Mondi wrote:
> > > Add documentation for r8a77965 compatible string to rcar-dmac device
> > > tree bindings documentation.
> > > 
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > 
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Sorry for not noticing this the first time around.
> 
> I think a better subject would be:
> 
> dt-bindings: dmaengine: rcar-dmac: document R8A77964 support

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
