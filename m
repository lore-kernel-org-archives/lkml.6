Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC80206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Lij8m58O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbeLNQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:30:09 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36355 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeLNQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:30:09 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1915825B75B;
        Sat, 15 Dec 2018 03:30:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544805006; bh=Dxa6cRBTXcQMj6KrUWfv42/3XChBvKQNOmCg8sltN7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lij8m58OKT0w9/kztvzeiNm07a7nnMxoDyK5sExetPJ+be5Oam+YZSjKNHB+T782d
         qMMTNattPeC95eGkXqqV/No743DyY4pxdefGwE/wx0tkg+8r/zoOn/BwqH3k2KxxMe
         gd1/azm7JeAZhfRTLwSS8aHAIQ3Z8J1fmzKd2Q0c=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 5F7DE9403C3; Fri, 14 Dec 2018 17:30:04 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:30:04 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
Message-ID: <20181214163004.hypp5shiflslluh6@verge.net.au>
References: <1544776907-17845-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544776907-17845-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 08:41:47AM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
