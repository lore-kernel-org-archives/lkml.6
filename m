Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756579AbeDZVQ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:16:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59838 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeDZVQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:16:13 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/17] arm64: dts: r8a77965: Use the correct CPG header
Date: Fri, 27 Apr 2018 00:16:27 +0300
Message-ID: <4644695.5hyXcXK7su@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426165346.494-10-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-10-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:38 EEST Kieran Bingham wrote:
> The SoC dtsi includes the generic renesas-cpg-mssr header, which does
> not contain all of the relevant SoC specific definitions.
> 
> Adapt this to be the r8a77965 specific header.

I would squash this with patch 13/17.

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77965.dtsi index
> 02de36b9e581..894903a59bdc 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -8,7 +8,7 @@
>   * Copyright (C) 2016 Renesas Electronics Corp.
>   */
> 
> -#include <dt-bindings/clock/renesas-cpg-mssr.h>
> +#include <dt-bindings/clock/r8a77965-cpg-mssr.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/r8a77965-sysc.h>


-- 
Regards,

Laurent Pinchart
