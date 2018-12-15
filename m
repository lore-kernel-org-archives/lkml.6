Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C41C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B592084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="gIZS0+oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbeLONus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:50:48 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47018 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLONus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:50:48 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1A32A25AE79;
        Sun, 16 Dec 2018 00:50:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544881845; bh=Z0HuilUX8r/4rpsuG5gRxi6mrDNgACbomOEUOPawUyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIZS0+oy14j95s/Bv8TdmIxW7ZOe24a6Aj4kHFWdPoU/Fl2OAhCwgpdFCkrv0H8fp
         zcVvz11oC3iN10ModDKpiKMa+CCLXZzhD08fh8Qk72XWxPLNvpuRLcY+rxHL151spO
         505/WXHD4IxsH8/CPmFedZyBUckJPQgcXDmRFedc=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id C8710E20E06; Sat, 15 Dec 2018 05:50:42 -0800 (PST)
Date:   Sat, 15 Dec 2018 14:50:42 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document R8A774C0 bindings
Message-ID: <20181215135038.iw4xngnktajowz5x@verge.net.au>
References: <1544732263-5859-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732263-5859-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:17:43PM +0000, Fabrizio Castro wrote:
> Renesas' RZ/G2E (R8A774C0) SoC has DMA controllers compatible
> with this driver, therefore document RZ/G2E specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

