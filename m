Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020F3C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB1C206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WyMNLg4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbeLNQkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:40:53 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36607 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbeLNQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:40:50 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E2CBB25B75B;
        Sat, 15 Dec 2018 03:40:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544805648; bh=n/pEr+nHWG/VYpoc5TnIrZZT4rBm+3yYNRvijMs2zY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyMNLg4Y8KYcE7Chlnp62jzrv/5/vEJIAsItoXBT59oMYp1qzbWzR46zD0nObUXuX
         aLa76mOrR5jfOiEnlqfWCebeE+tdv3Gp+cQUI6BrJqMlLFM4kiF/HYHnAwCjkwvqfj
         r1RRVwzJcgPhaHt+5oajsbCeT2P3+lR5jGDLdzkA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 2DE4E9403C3; Fri, 14 Dec 2018 17:40:46 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:40:46 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774c0
Message-ID: <20181214164045.bjhknlosmikzux6f@verge.net.au>
References: <1544732491-6821-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732491-6821-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:21:31PM +0000, Fabrizio Castro wrote:
> This patch adds bindings for the r8a774c0 (RZ/G2E).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

