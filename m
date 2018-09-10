Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2248C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC13020833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="BTqlYeEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC13020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeIJNld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:41:33 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:58231 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:41:33 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1CA0225BDE3;
        Mon, 10 Sep 2018 18:48:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1536569313; bh=GNNNEDnC0VyPkfMnD4BtA2d4Ib5pavcnxIaMjqepZtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTqlYeEFN8yv+61utlmDqTXgMFEwu5b+ORyOycGFU7W59c2tDHtu02Fo6hJduLCCF
         a01wItug5u772cOZ3rtwohLLFTa+q+CkbCjpa5tOKRw0Ghl0mJd4Am8SkQ4ISV2VRS
         3FZuA7QeSly2k1vmFosjEDr9hpUIReWFiKFNAGfE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 1A45B94017E; Mon, 10 Sep 2018 10:48:31 +0200 (CEST)
Date:   Mon, 10 Sep 2018 10:48:31 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend 2/2] pinctrl: rza1: convert to SPDX identifiers
Message-ID: <20180910084830.hyv6ozatbhuahpqq@verge.net.au>
References: <87ftymqdzh.wl-kuninori.morimoto.gx@renesas.com>
 <87d0tqqdy6.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0tqqdy6.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:51:02AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

