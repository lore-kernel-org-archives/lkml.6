Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F66206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="oIaV6/3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbeLNQeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:34:44 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36475 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeLNQeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:34:44 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 3A27925B75B;
        Sat, 15 Dec 2018 03:34:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544805281; bh=3gt7xNgNgazBewpLnW30vBsqXCAtqba9PwcCkyJdMnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oIaV6/3G/73IlDzyJQkuxHjFDZM6ckghZdQ9SWxf6fosVGInKubLZcdkcVh4eIUua
         lON7PbXURU9G1ZlEYNmYRcEGmY34h7o3WE/6fRUweIzxXmrJDfPxEFYkB6xzLRruTe
         MNXJAQQ8PCHLmzGa9u6uwieU9YcEX9Vh6tdMMhgI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 85B519403C3; Fri, 14 Dec 2018 17:34:39 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:34:39 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: renesas_sdhi: Add r8a774c0 support
Message-ID: <20181214163439.exvz5uoczt7xcdu6@verge.net.au>
References: <1544732529-7003-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732529-7003-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:22:09PM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

