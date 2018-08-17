Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC934C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6178218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="MemtKSsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6178218AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHQMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:51 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49100 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeHQMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:13 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 063DF25B803;
        Fri, 17 Aug 2018 19:48:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534499307; bh=ulmxNQOzHKcmQgcXoPSMZfGC/qN5mh4jLccWMZ5409U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MemtKSsvFhPeJBY/hBpAOqh3CWfMWeziXZi8cePcUjkEaqGUEBzeLtti7JxDAYJD1
         ZXDze61+dJHYfC5CpvkH68BvYRg/B409DyV0VuQ3H0gMjZXSUit2DoYMXPEqw2lwcq
         Vtn3TrQirf0955Z1dAHqDzYUeTebGtG4/fAytkCA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id ED1D4940453; Fri, 17 Aug 2018 11:48:24 +0200 (CEST)
Date:   Fri, 17 Aug 2018 11:48:24 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Message-ID: <20180817094824.ppqqthm56mdpqgm6@verge.net.au>
References: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 01:32:15PM +0100, Fabrizio Castro wrote:
> Renesas' RZ/G2M (R8A774A1) SoC has DMA controllers compatible
> with this driver, therefore document RZ/G2M specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
