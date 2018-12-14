Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0100EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB90206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="j55BfbVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeLNQ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:57:36 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36866 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeLNQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:57:36 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 3B9CA25B75B;
        Sat, 15 Dec 2018 03:57:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544806653; bh=iUHnp/vs+js5Hdn5/f8MhkllI2znAlwi69srQaBCdJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j55BfbVlDMp6LaX76jatzE29sFfiAmK5oGfcbopLGFXjJCTem17NFOvhgcErDQ3jw
         Avg6k8wxiTdrzDxxwf/DkYdGw4thO7DXIvJ7nxTVHPWMNf6woXzxQHXtaW0FQGFvAh
         DT0myZml8nmS3VolLZ5Q/wjsx4m0cMBM9hFF11nc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8D94A9403C3; Fri, 14 Dec 2018 17:57:31 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:57:31 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: rcar: Add r8a774c0 support
Message-ID: <20181214165731.5ygiye5nuhr2a35z@verge.net.au>
References: <1544732415-6453-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732415-6453-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:20:15PM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

