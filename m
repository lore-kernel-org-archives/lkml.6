Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4FBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F7421019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeL2FZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:25:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40292 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeL2FZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:25:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AFD381451514B;
        Fri, 28 Dec 2018 21:25:42 -0800 (PST)
Date:   Fri, 28 Dec 2018 21:25:42 -0800 (PST)
Message-Id: <20181228.212542.399035533911932129.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     f.fainelli@gmail.com, keescook@chromium.org, wang6495@umn.edu,
        jakub.kicinski@netronome.com, ilyal@mellanox.com,
        ecree@solarflare.com, mkubecek@suse.cz, ynorov@caviumnetworks.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethtool: check the return value of get_regs_len
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1545825106-103343-1-git-send-email-linyunsheng@huawei.com>
References: <1545825106-103343-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Dec 2018 21:25:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Wed, 26 Dec 2018 19:51:46 +0800

> The return type for get_regs_len in struct ethtool_ops is int,
> the hns3 driver may return error when failing to get the regs
> len by sending cmd to firmware.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> Note: There is not Fixes tags for this becuase the ops is added
> before the git is used.

Applied, thanks.
