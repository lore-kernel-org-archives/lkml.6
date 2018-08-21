Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6BBC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486A2173A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="BE2iOylX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E486A2173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeHURlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:41:31 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36878 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHURla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:41:30 -0400
Received: from penelope.horms.nl (unknown [83.137.1.205])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 315AB25BECB;
        Wed, 22 Aug 2018 00:21:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534861261; bh=fh4daaKMu/furJ+xXq/LLJsTX1CS7GUoSxvDFdN1zSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BE2iOylXTRlbo6BPDTnG3D8h6/uT+6pRMZuwE8DBaPGwOkrAa0uTenipT7rl0yfph
         9sLg4UdnbxJh4tj7zVwWAweR3tO6JLEKBLtLl1dcVlBOVIxtquSPRr7GbLw+/LQ7pX
         RZ12UQa71kN+L/+oZqvIpwDwYbiDSOabojrbw0Vc=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id ED900E2140C; Tue, 21 Aug 2018 15:35:47 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:35:47 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a774a1 support
Message-ID: <20180821133547.3s4stv6peqhjkm6x@verge.net.au>
References: <1534517584-14434-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534517584-14434-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534517584-14434-3-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 03:53:04PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

