Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1487C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725282133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="CmqkM/C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeLQL7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:59:04 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:39410 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeLQL7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:59:04 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 4CA1625B7CF;
        Mon, 17 Dec 2018 22:59:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1545047941; bh=8+EUh0tm+8nYhdI/kRT5T4Mb9fOjjKtbenYCdNyqfR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmqkM/C+PhqgKUfClesyVWHrAEts53yA37o4+g8EhajxmSlIyops2ycz5esi2ksqR
         1lyi1LojMMTWjr2VRtYidtu+jEdWmjx4Ft71TDsY0RSrJjJfHb+5oEjnxL01esVl6k
         aa2Pr1QiCO17AyPAbYxsEdpgKrUVYDDB/G7vL0g8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B1A5A94048A; Mon, 17 Dec 2018 12:58:59 +0100 (CET)
Date:   Mon, 17 Dec 2018 12:58:59 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] drm: rcar-du: lvds: add R8A774C0 support
Message-ID: <20181217115859.vrfzth5lna7kzfk5@verge.net.au>
References: <1544732616-7322-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732616-7322-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:23:36PM +0000, Fabrizio Castro wrote:
> The LVDS implementation on the RZ/G2E (a.k.a. R8A774C0) is very similar
> to the one found on R-Car E3 (a.k.a. R8A77990), therefore add RZ/G2E
> LVDS support to the LVDS encoder driver in a similar fashion to what
> done for R-Car E3.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

