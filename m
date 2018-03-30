Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeC3H05 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:26:57 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45812 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeC3H0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:26:55 -0400
Date: Fri, 30 Mar 2018 09:26:50 +0200
From: Simon Horman <horms@verge.net.au>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 7/8] DT: arm: Add Renesas RZN1D-DB Board base file
Message-ID: <20180330072649.fvl46dfoha7gfxig@verge.net.au>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-8-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522309629-10152-8-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 08:47:03AM +0100, Michel Pollet wrote:
> This adds a base device tree file for the RZN1-DB board, with only the
> basic support allowing the system to boot to a prompt. Only one UART is
> used, with only a single CPU running.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> 
> diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> new file mode 100644
> index 0000000..a462b1a
> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the RZN1D-DB Board
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "r9a06g0xx.dtsi"
> +
> +/ {
> +	model = "RZN1D-DB Board";
> +	compatible = "renesas,rzn1d400-db", "renesas,r9a06g032", "renesas,rzn1";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +};
> +&uart0 {
> +	status = "okay";
> +};

Please add a blank line between nodes.
Please use "ARM: dts: " as the patch prefix.
