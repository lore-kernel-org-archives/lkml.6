Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDPPVM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:21:12 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43718 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeDPPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:21:10 -0400
X-Google-Smtp-Source: AIpwx4+bvTf7eXGacap0rRIJejciYWs/BS1O27qnaIrTr4eVEGmxrQVxsZ7KLK7De8hYTPI+QESoJw==
Date: Mon, 16 Apr 2018 10:21:09 -0500
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: sergei.shtylyov@cogentembedded.com, mark.rutland@arm.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a77965 SoC
Message-ID: <20180416152109.r2wv7msvmto7zzsn@rob-hp-laptop>
References: <1523886917-14491-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523886917-14491-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 03:55:17PM +0200, Jacopo Mondi wrote:
> Add documentation for r8a77965 compatible string to renesas ravb device
> tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> ---
> 
> Renesas R-Car M3-N support has been merged for v4.17.
> Document the missing device tree bindings.
> 
> ---
>  Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
