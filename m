Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C42C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6D1206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="gKlefXV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeLNQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:27:53 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36323 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbeLNQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:27:53 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2DE5125B75B;
        Sat, 15 Dec 2018 03:27:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544804870; bh=74z4HWacQbb9o0MvBEcqOYNNpRJaZQdajPfxa6MrK8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKlefXV+9PPYoFKMu8xv/KYLm9EIgEBvPPHPrkPw4Vll3xTmiTESez2lGroFO5ScS
         wIiTb+Dmkux2111Vw7/5WcWpCgUI53c9VPSJgLuBxQ6yoLdP6o9Ok49LIhJUYyAoUN
         ScTBF9w1G/4u3+w939UkXnwujw5rUdPQ6qoECxGU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 7303B9403C3; Fri, 14 Dec 2018 17:27:48 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:27:48 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
Message-ID: <20181214162748.dt2ntmw5qn4j5q24@verge.net.au>
References: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:22:34PM +0000, Fabrizio Castro wrote:
> Similarly to R-Car E3, RZ/G2E doesn't come with automatic
> transmission registers, as such it is not considered compatible
> with the existing fallback bindings.
> 
> Add SoC specific binding compatibility to allow for later
> support for automatic transmission.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

