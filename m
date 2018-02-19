Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeBSCwR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:52:17 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39931 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeBSCwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:52:15 -0500
X-Google-Smtp-Source: AH8x225CgBOojKfgHP2gyNSGpWNDXPzBoA8Gxxr0VoC9aKoCmC8YKoPj+TyQt8NTR593v6334HAzxg==
Date: Sun, 18 Feb 2018 20:52:13 -0600
From: Rob Herring <robh@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        magnus.damm@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] Documentation: devicetree: R-Car M3-N SoC DT
 bindings
Message-ID: <20180219025213.iqu7vsmrsbbqe4ky@rob-hp-laptop>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-2-git-send-email-jacopo+renesas@jmondi.org>
 <20180214100150.dv2fkffussrfqkme@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214100150.dv2fkffussrfqkme@verge.net.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:01:53AM +0100, Simon Horman wrote:
> On Tue, Feb 13, 2018 at 10:45:48AM +0100, Jacopo Mondi wrote:
> > Add device tree bindings documentation for Renesas R-Car M3-N (r8a77965)
> > SoC.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Thanks, this looks fine to me but I think the subject should be updated to
> 
> dt-bindings: arm: document R8A77965 SoC bindings
> 
> I'll let this sit for a few days to see if any other review is forthcoming.
> 
> > ---
> >  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
> >  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
