Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967096AbeBNKIZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:08:25 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:56555 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966933AbeBNKIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:08:23 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kbingham@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] arm64: dts: renesas: r8a7795-es1: Fix register mappings on VSPs
Date: Wed, 14 Feb 2018 12:08:56 +0200
Message-ID: <2009459.7Q8ChOu4tJ@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1518602108-1724-4-git-send-email-kbingham@kernel.org>
References: <1518602108-1724-1-git-send-email-kbingham@kernel.org> <1518602108-1724-4-git-send-email-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Wednesday, 14 February 2018 11:55:06 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The VSPD includes a CLUT on RPF2. Ensure that the register space is
> mapped correctly to support this.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi index
> ed553338b4d4..1adfe6cad268 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> @@ -80,7 +80,7 @@
> 
>  	vspd3: vsp@fea38000 {
>  		compatible = "renesas,vsp2";
> -		reg = <0 0xfea38000 0 0x4000>;
> +		reg = <0 0xfea38000 0 0x8000>;
>  		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&cpg CPG_MOD 620>;
>  		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;

-- 
Regards,

Laurent Pinchart
