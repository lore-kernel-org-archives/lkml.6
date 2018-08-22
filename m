Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C12C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1092152F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="lAGTY75F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1092152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeHVPBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:01:47 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:51043 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHVPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:01:47 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E3C2325AD64;
        Wed, 22 Aug 2018 21:37:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1534937833; bh=Q/ExfyMLr5z0sVQT14Hjb1YQM3AHDnOGLZWD18yz3t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAGTY75FlHiXdJBLDY9O240TIt80Qjrz7+rdKSuSLddxvAk9tNsQL0/wQ1lXcb0pj
         qQmVISZEVo8KXTos0yTi03DZJOFuDLNvuTEsF6XF8hqTPz6FuCpYhJAMRdKvZmpSqJ
         IdVAytd5sDS7dhI5s5G/M5365f6MX79OFcC97r34=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D97B094040B; Wed, 22 Aug 2018 13:37:10 +0200 (CEST)
Date:   Wed, 22 Aug 2018 13:37:10 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] irqchip: irq-renesas-irqc: convert to SPDX
 identifiers
Message-ID: <20180822113710.p4rmwjrnb6ag6hr6@verge.net.au>
References: <87va83dn68.wl-kuninori.morimoto.gx@renesas.com>
 <87tvnndn50.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvnndn50.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 04:52:49AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

