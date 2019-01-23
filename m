Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD86EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E90218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfAWRHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:07:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfAWRHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:07:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6FB4914EC9753;
        Wed, 23 Jan 2019 09:07:15 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:07:15 -0800 (PST)
Message-Id: <20190123.090715.1503851709611372496.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     ariel.elior@cavium.com, sudarsana.kalluru@cavium.com,
        everest-linux-l2@cavium.com, siva.kallam@broadcom.com,
        prashant@broadcom.com, mchan@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] broadcom: Mark expected switch fall-throughs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190123074119.GA18304@embeddedor>
References: <20190123074119.GA18304@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 23 Jan 2019 09:07:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 23 Jan 2019 01:41:19 -0600

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:6336:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:2231:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/net/ethernet/broadcom/tg3.c:722:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/net/ethernet/broadcom/tg3.c:783:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
