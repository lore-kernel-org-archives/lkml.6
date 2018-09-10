Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5037DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C4420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="f5sI59Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C4420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeIJSI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:08:27 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33173 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeIJSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:08:27 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 3A36825BE2C;
        Mon, 10 Sep 2018 23:14:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1536585264; bh=vdmoJiMlvCmXIPvMsHzmN7h6aVra4agjdkM8rOevAIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5sI59RpRl8UcTnciLDcJKUnUwq8e3Hkw4zDNFFhdtltovmpX6FQcNp3TkWELpVgW
         Zn+Ec0jgoYnAAhzzqJKsmmBK+G8AJVoiwI79vegxE4RCeg9be4ZZlF3U+9EFngCEih
         k/SiBIrAMrPL6N3Bk7Oj3WmGQeenNoULDyu1Rm/8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 3994694017E; Mon, 10 Sep 2018 15:14:22 +0200 (CEST)
Date:   Mon, 10 Sep 2018 15:14:22 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] phy: renesas: convert to SPDX identifiers
Message-ID: <20180910131421.jwn6mbv7chypoalf@verge.net.au>
References: <87zhwuoykl.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhwuoykl.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 02:08:30AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

