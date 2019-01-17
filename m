Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE222C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D50320855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="UAc5C/Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfAQMLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:11:44 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:60976 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfAQMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:11:44 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6753225B760;
        Thu, 17 Jan 2019 23:11:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1547727100; bh=G6ZaZWv+S+AsEbzDMS70CAwhselONIBi9I5jdKO92aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAc5C/Lji/BJtBpTf9PiOKC5JL/w09gqRwIMf//T0zrn0qTaxu7/0BOfvNxrxlTzX
         xZjuwqRaNggpkv3RRXmlEdj0ZjhqYYWUOB+YEwy2yDrXscdBoJhSXLA3kHo1jfwEsp
         A69EPh1zv4bpg9hup1ZzJRdnyyE32HOyRpP58IbU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id CA84F940459; Thu, 17 Jan 2019 13:11:37 +0100 (CET)
Date:   Thu, 17 Jan 2019 13:11:37 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        linux-kernel@vger.kernel.org, ebiharaml@si-linux.co.jp
Subject: Re: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0
 support
Message-ID: <20190117121137.riri7nzwegkocnxc@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:37:54PM +0000, Fabrizio Castro wrote:
> Document the support for rcar_canfd on R8A774C0 SoC devices.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch depends on:
> https://patchwork.kernel.org/patch/10687999/
> https://patchwork.kernel.org/patch/10688001/
> 
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 +++++++++-------

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> index 41049fe..32f051f 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -3,7 +3,8 @@ Renesas R-Car CAN FD controller Device Tree Bindings
>  
>  Required properties:
>  - compatible: Must contain one or more of the following:
> -  - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
> +  - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
> +  - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
>    - "renesas,r8a77965-canfd" for R8A77965 (R-Car M3-N) compatible controller.
> @@ -28,12 +29,13 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
>  child node supports the "status" property only, which is used to
>  enable/disable the respective channel.
>  
> -Required properties for "renesas,r8a7795-canfd", "renesas,r8a7796-canfd",
> -"renesas,r8a77965-canfd" and "renesas,r8a77990-canfd" compatible:
> -In R8A7795, R8A7796, R8A77965 and R8A77990 SoCs, canfd clock is a div6 clock
> -and can be used by both CAN and CAN FD controller at the same time. It needs
> -to be scaled to maximum frequency if any of these controllers use it. This is
> -done using the below properties:
> +Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd",
> +"renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and "renesas,r8a77990-canfd"
> +compatible:
> +In R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd clock is a
> +div6 clock and can be used by both CAN and CAN FD controller at the same time.
> +It needs to be scaled to maximum frequency if any of these controllers use it.
> +This is done using the below properties:
>  
>  - assigned-clocks: phandle of canfd clock.
>  - assigned-clock-rates: maximum frequency of this clock.
> -- 
> 2.7.4
> 
