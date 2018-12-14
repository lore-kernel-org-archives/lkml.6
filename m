Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF45C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D762070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="QPWz7pZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeLNQVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:21:16 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36240 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLNQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:21:15 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E0C2025B75B;
        Sat, 15 Dec 2018 03:21:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544804473; bh=YGzAVZHe/2HJBL3HnYg4zii4MqshybAlmz0LUu+DDt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPWz7pZbgdJnYQNon4j0lHZF5Hnm/FHYtIEC+jpk0DRWTdfIdgZzbOZ0qTK+UGQ/Y
         eiVM7LCbTwcpUJ/i6gm2M/dQ54Or+X18iMZyMvBHXG0byjCl/rqzwDIdRpdFN2YKHL
         8utXW5EWiQ7JSx5ydaJ2GsoZOTKeb9Rl0OqJ+cZs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 27FB79403C3; Fri, 14 Dec 2018 17:21:11 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:21:11 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] thermal: rcar_thermal: add R8A774C0 support
Message-ID: <20181214162110.az3r6kt6ok62nj76@verge.net.au>
References: <1544732590-7230-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732590-7230-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:23:10PM +0000, Fabrizio Castro wrote:
> Add thermal support for the RZ/G2E SoC (a.k.a. R8A774C0).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

