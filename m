Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC65EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AD22152F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="lxq3aJxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AD22152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeHVPBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:01:04 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:51018 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHVPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:01:03 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AC95725AD64;
        Wed, 22 Aug 2018 21:36:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534937790; bh=awuskn1uihhpqyH+NxbXlVYzJgDKe0JF7hPqpB/GQyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxq3aJxMBwsDWdnEz6DRTguIh+eJgbNWM78GtGuJMAj8k3iaOeaPfCT7TjWNKkXXv
         JFAOGPAzsGzDbJ6zicR1hhu3WxQU8j97rp2PzZx9F2p7Xm8vVr5LUojkTgM8Dwc3CM
         puV3MkCMlEDjSE2TICJQlb5qSCdNp1q4PIKPUW5c=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B40BE94040B; Wed, 22 Aug 2018 13:36:27 +0200 (CEST)
Date:   Wed, 22 Aug 2018 13:36:27 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clocksource: sh_mtu2: convert to SPDX identifiers
Message-ID: <20180822113627.gxfxvxh7ie2t2ebh@verge.net.au>
References: <87a7pff8jq.wl-kuninori.morimoto.gx@renesas.com>
 <876003f8hz.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876003f8hz.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:26:06AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

