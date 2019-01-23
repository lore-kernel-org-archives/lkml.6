Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3943FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1014021855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfAWRGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:06:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46934 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:06:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DF1214D42E58;
        Wed, 23 Jan 2019 09:06:54 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:06:51 -0800 (PST)
Message-Id: <20190123.090651.1949701692687423101.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tipc: mark expected switch fall-throughs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190123070931.GA5514@embeddedor>
References: <20190123070931.GA5514@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 23 Jan 2019 09:06:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 23 Jan 2019 01:09:31 -0600

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> net/tipc/link.c:1125:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> net/tipc/socket.c:736:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> net/tipc/socket.c:2418:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
