Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8DFC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CB82084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="q7MoFdYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeLONw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:52:28 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47104 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbeLONw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:52:27 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7D3F725AE79;
        Sun, 16 Dec 2018 00:52:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544881944; bh=qTUtRRt5DaZW1EZUwQ7myTEOl0D1pTkvS+7yAmoYSBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7MoFdYSWyOU73UNJ2kJxMwEMZJYsIK2lPAsnlsL2yBrXxVMW/tHOnQ71mDFtXPoP
         QLkSfJa1wd6sH7mHtPFCRi5EhwzingfQxKUFBBHipW9oFL8fVquhV6LtopuF8BF1gZ
         B+gc9XjX/7KAq7onMVGf5ER8uPoJNaOw+kV5yn9M=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 6D760E20E06; Sat, 15 Dec 2018 05:52:22 -0800 (PST)
Date:   Sat, 15 Dec 2018 14:52:22 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
Message-ID: <20181215135222.aarjedojr7ntd5ut@verge.net.au>
References: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:19:38PM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (r8a774c0) SoC specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

