Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDPPUN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:20:13 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43524 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:20:11 -0400
X-Google-Smtp-Source: AIpwx49dU1pXxYF0PyJCgZI6O7dgrixEJ6RcnPhfH/BoyTji0nwY98KFTipRB9kfZqUHQGL87Ih9wA==
Date: Mon, 16 Apr 2018 10:20:09 -0500
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: linus.walleij@linaro.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Add support for r8a77965
Message-ID: <20180416152009.gf3rnpuork2lbcfa@rob-hp-laptop>
References: <1523886904-14449-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523886904-14449-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 03:55:04PM +0200, Jacopo Mondi wrote:
> Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

You missed Simon's and my R-by's on v2.

> 
> Renesas R-Car M3-N support has been merged for v4.17.
> Document the missing device tree bindings.
> 
> ---
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> index 9474138..f2af897 100644
> --- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> +++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> @@ -14,6 +14,7 @@ Required Properties:
>      - "renesas,gpio-r8a7794": for R8A7794 (R-Car E2) compatible GPIO controller.
>      - "renesas,gpio-r8a7795": for R8A7795 (R-Car H3) compatible GPIO controller.
>      - "renesas,gpio-r8a7796": for R8A7796 (R-Car M3-W) compatible GPIO controller.
> +    - "renesas,gpio-r8a77965": for R8A77965 (R-Car M3-N) compatible GPIO controller.
>      - "renesas,gpio-r8a77970": for R8A77970 (R-Car V3M) compatible GPIO controller.
>      - "renesas,gpio-r8a77995": for R8A77995 (R-Car D3) compatible GPIO controller.
>      - "renesas,rcar-gen1-gpio": for a generic R-Car Gen1 GPIO controller.
> --
> 2.7.4
> 
