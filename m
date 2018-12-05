Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D972FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD46213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="oA4/Khvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD46213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeLEVVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:21:33 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:37599 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:21:32 -0500
Received: from penelope.horms.nl (unknown [64.124.208.80])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 595C325B799;
        Thu,  6 Dec 2018 08:21:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544044890; bh=4BvgaB4+uzx3c8aOCPwWB6qYTwlvTnDmHzUi6Vr1ND8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oA4/KhvbJgpCI6OCeDbbwyeTL0SGPRvrxrH4nVNMusbN5V7thhvBhndCzWLRjiV9W
         C86gths2CRkcXsx30avFToK1YC3VCVeciicadIKFcZ+JgORghY5HNMUtkxXnyDqNv4
         2aHmv3l42pHeRnrfI6+7fR7wAI1g7/6TjhCpbnlU=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id B85A0E22BBB; Wed,  5 Dec 2018 13:21:28 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:21:28 -0800
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] soc: renesas: rcar-sysc: Miscellaneous fixes and
 cleanups
Message-ID: <20181205212127.xmgmfvzbz6o7oots@verge.net.au>
References: <20181205153945.13767-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205153945.13767-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:39:41PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This series (against renesas-devel-20181204-v4.20-rc5) contains
> miscellaneous fixes and cleanups for the R-Car SYSC driver.
> 
> This has been tested on R-Car Gen2 (H2 and M2-W) and R-Car Gen3 (H3
> ES1.0, H3 ES2.0, M3-W, M3-N, D3, E3, and V3M) (without 3DG).
> 
> This not been tested on R-Car H1 and R-Car V3H.

Thanks, applied for v4.21.
