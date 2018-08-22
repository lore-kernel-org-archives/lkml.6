Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48938C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034632152D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="jatddBQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034632152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeHVPBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:01:21 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:51029 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHVPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:01:21 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D4D0F25AD64;
        Wed, 22 Aug 2018 21:36:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534937807; bh=QRq4vi2LMNw/1vbfxreVmaObU8hYupWLElJCEi8phac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jatddBQQs5OfzvAbGgMzPVOIDzZKjBY19Q1avwweSjKW7fKy3dj27h2QSpmqg79cC
         EJ7XRtaOswbtf072BxDQT1+apWnU8XxSR/hlNug0KXzeODIhOFlQxsUl78lBSBQdwq
         71JmmGFRWxSdtCtXwt/eeb9xekdJoiJOZ+XMuRBk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id C277694040B; Wed, 22 Aug 2018 13:36:44 +0200 (CEST)
Date:   Wed, 22 Aug 2018 13:36:44 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] clocksource: sh_tmu: convert to SPDX identifiers
Message-ID: <20180822113644.xojrz4i4hu57fkkl@verge.net.au>
References: <87a7pff8jq.wl-kuninori.morimoto.gx@renesas.com>
 <874lfnf8hm.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lfnf8hm.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:26:20AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

