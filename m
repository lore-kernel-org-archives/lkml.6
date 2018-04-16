Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeDPPXT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:23:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35941 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeDPPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:23:16 -0400
X-Google-Smtp-Source: AIpwx48cJjaQvzDNJ+kndcs4twWrYjwJgLjB5TDbdr4TUl+Ph1Y0m9A73+rnRzmV6uOmVrFlYNC+ug==
Date: Mon, 16 Apr 2018 10:23:15 -0500
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: vinod.koul@intel.com, mark.rutland@arm.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: rcar-dmac: document R8A77965
 support
Message-ID: <20180416152314.bwpchjpspcvkpcuv@rob-hp-laptop>
References: <1523886968-14644-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523886968-14644-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 03:56:08PM +0200, Jacopo Mondi wrote:
> Add documentation for r8a77965 compatible string to rcar-dmac device
> tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> 
> Renesas R-Car M3-N support has been merged for v4.17.
> Document the missing device tree bindings.
> 
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
