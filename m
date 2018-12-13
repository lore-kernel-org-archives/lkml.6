Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C79C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2013B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sfiyTjC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2013B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeLMVhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:37:22 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47580 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLMVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:37:20 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E960F549;
        Thu, 13 Dec 2018 22:37:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1544737038;
        bh=BX8+axEo2GeBhVt5qnUur5rp81KsPn+1io5Iywhsoq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfiyTjC6hEJaabhQL/Bnis7eR9uEzzJyQvCeZAL8Gy2RTYhypyckWpcaOxo73IVRB
         XVORHBvNpKsBYh4v4KmZ9USbeQEs61k9ZEs1RmunD694gJuQueJGtiLpQ3AGqsICGk
         IV0VSxRQquIRkI44EJg1/pO/T0aeZLTxBWc7lEvg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: display: renesas: lvds: Document r8a774c0 bindings
Date:   Thu, 13 Dec 2018 23:38:05 +0200
Message-ID: <16274213.zDsrymDxqi@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1544732454-6633-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1544732454-6633-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Thursday, 13 December 2018 22:20:54 EET Fabrizio Castro wrote:
> The RZ/G2E (r8a774c0) supports two LVDS channels. Extend the binding to
> support them.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt index
> 3aeb0ec..cb7c328 100644
> --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> @@ -8,6 +8,7 @@ Required properties:
> 
>  - compatible : Shall contain one of
>    - "renesas,r8a7743-lvds" for R8A7743 (RZ/G1M) compatible LVDS encoders
> +  - "renesas,r8a774c0-lvds" for R8A774C0 (RZ/G2E) compatible LVDS encoders
>    - "renesas,r8a7790-lvds" for R8A7790 (R-Car H2) compatible LVDS encoders
>    - "renesas,r8a7791-lvds" for R8A7791 (R-Car M2-W) compatible LVDS
> encoders - "renesas,r8a7793-lvds" for R8A7793 (R-Car M2-N) compatible LVDS
> encoders @@ -24,7 +25,7 @@ Required properties:
>  - clock-names: Name of the clocks. This property is model-dependent.
>    - The functional clock, which mandatory for all models, shall be listed
>      first, and shall be named "fck".
> -  - On R8A77990 and R8A77995, the LVDS encoder can use the EXTAL or
> +  - On R8A77990, R8A77995 and R8A774C0, the LVDS encoder can use the EXTAL
> or DU_DOTCLKINx clocks. Those clocks are optional. When supplied they must
> be named "extal" and "dclkin.x" respectively, with "x" being the
> DU_DOTCLKIN numerical index.


-- 
Regards,

Laurent Pinchart



