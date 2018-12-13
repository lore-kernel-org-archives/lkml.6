Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6CEC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506C82086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lQ/jzDD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506C82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeLMVhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:37:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47626 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeLMVhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:37:22 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDFDD568;
        Thu, 13 Dec 2018 22:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1544737040;
        bh=1/YdkZgFlmjplR1e/sDF0P+Dj/0smQRgYv8AKmsiZBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQ/jzDD9LGDX76Q0T6XBxPk8GeJG1pejufHhjqxJF/3IM2D/aApG7CSHJUqf+tH79
         IwCD14DL/wrm58Zs9G0gbaKc8P6prRH7OLgIjssUuY5zirSj4mT6qqN6nqIfIo1qoP
         oQm40NW4DApNzPlYgo8U8dfkL2XNwPEe0z6q/emo=
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
Subject: Re: [PATCH] dt-bindings: display: renesas: du: Document r8a774c0 bindings
Date:   Thu, 13 Dec 2018 23:38:07 +0200
Message-ID: <2853413.TK89vclHxN@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1544732445-6588-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1544732445-6588-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Thursday, 13 December 2018 22:20:45 EET Fabrizio Castro wrote:
> Document the RZ/G2E (a.k.a. r8a774c0) SoC in the R-Car DU bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt
> b/Documentation/devicetree/bindings/display/renesas,du.txt index
> 3c855d9..aedb22b 100644
> --- a/Documentation/devicetree/bindings/display/renesas,du.txt
> +++ b/Documentation/devicetree/bindings/display/renesas,du.txt
> @@ -7,6 +7,7 @@ Required Properties:
>      - "renesas,du-r8a7744" for R8A7744 (RZ/G1N) compatible DU
>      - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
>      - "renesas,du-r8a77470" for R8A77470 (RZ/G1C) compatible DU
> +    - "renesas,du-r8a774c0" for R8A774C0 (RZ/G2E) compatible DU
>      - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
>      - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
>      - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
> @@ -57,6 +58,7 @@ corresponding to each DU output.
>   R8A7744 (RZ/G1N)       DPAD 0         LVDS 0         -              -
>   R8A7745 (RZ/G1E)       DPAD 0         DPAD 1         -              -
>   R8A77470 (RZ/G1C)      DPAD 0         DPAD 1         LVDS 0         -
> + R8A774C0 (RZ/G2E)      DPAD 0         LVDS 0         LVDS 1         -
>   R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              -
>   R8A7790 (R-Car H2)     DPAD 0         LVDS 0         LVDS 1         -
>   R8A7791 (R-Car M2-W)   DPAD 0         LVDS 0         -              -


-- 
Regards,

Laurent Pinchart



