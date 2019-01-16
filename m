Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72503C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433B520675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfAPVj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:39:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45116 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfAPVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:39:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C4099126662E6;
        Wed, 16 Jan 2019 13:39:56 -0800 (PST)
Date:   Wed, 16 Jan 2019 13:39:56 -0800 (PST)
Message-Id: <20190116.133956.313573108708029373.davem@davemloft.net>
To:     khlebnikov@yandex-team.ru
Cc:     netdev@vger.kernel.org, xiyou.wangcong@gmail.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH] net/core/neighbour: fix kmemleak minimal reference
 count for hash tables
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154746232378.234732.3976012997312897852.stgit@buzz>
References: <154746232378.234732.3976012997312897852.stgit@buzz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Jan 2019 13:39:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Mon, 14 Jan 2019 13:38:43 +0300

> This should be 1 for normal allocations, 0 disables leak reporting.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Fixes: 85704cb8dcfd ("net/core/neighbour: tell kmemleak about hash tables")

Applied.
