Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C1C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08BF206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="r5d4f7ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbeLNQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:24:28 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36305 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeLNQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:24:27 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 24FED25BE78;
        Sat, 15 Dec 2018 03:24:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544804665; bh=dhTa6AxW0EgpefE7PjkYYwgqlt1pwetpLR2yC31L6ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5d4f7ugKHXcBCHGdOSmsnVNHJbPahFOQZUK3b5mGdphCI6125Iax4XZDHVvRQxv9
         yP21qLF2NsusurpxGPbAyWJXFV6meUOyHaJtevMyomiABolOzsMPXPASnCR/0i1ppI
         N+LRDd4MSKOSLk0PbkSNAaM4UIzcNeLQWmDjxreA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 653099403C3; Fri, 14 Dec 2018 17:24:23 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:24:23 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774c0 DT matching code
Message-ID: <20181214162423.poetvmta62w3gzgs@verge.net.au>
References: <1544732564-7185-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732564-7185-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:22:44PM +0000, Fabrizio Castro wrote:
> Support RZ/G2E (a.k.a. R8A774C0) IPMMU.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
