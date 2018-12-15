Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B0C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68DE2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="HAAUdiny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeLONvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:51:36 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47055 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLONvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:51:35 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id EB3D125AE79;
        Sun, 16 Dec 2018 00:51:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544881893; bh=5fK3kPaJymCnLW46klfYPo7Q68mdfAaInD9kohRHaJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAAUdinyfRfULGdsKa+zAhYhQBP26Ar77SXEAiov5dLbcXmewx8z4Y6+sgUwc4LuI
         By2ViC7MdfVCt41GqGiBgprZZ79wfoGMYfZ2JpPj0gb4935LE2KDLVVs3c5zYymvma
         CeKXt1QXeCyI+eacs8kxPKzqtBYVN+GSg/f6LZ1o=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id D675BE20E06; Sat, 15 Dec 2018 05:51:30 -0800 (PST)
Date:   Sat, 15 Dec 2018 14:51:30 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: rcar: Add r8a774c0 (RZ/G2E) support
Message-ID: <20181215135130.ternno5paye6ej5x@verge.net.au>
References: <1544732294-5996-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732294-5996-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:18:14PM +0000, Fabrizio Castro wrote:
> Document Renesas' RZ/G2E (R8A774C0) GPIO blocks compatibility within the
> relevant dt-bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

