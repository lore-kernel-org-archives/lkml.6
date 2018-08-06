Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74039C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277BA21A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277BA21A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbeHFToU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:44:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbeHFToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:44:20 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 218E9133E98F1;
        Mon,  6 Aug 2018 10:34:14 -0700 (PDT)
Date:   Mon, 06 Aug 2018 10:34:13 -0700 (PDT)
Message-Id: <20180806.103413.1557000381331834669.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/bridge/br_multicast: remove redundant variable
 "err"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533524843-51236-1-git-send-email-zhongjiang@huawei.com>
References: <1533524843-51236-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Aug 2018 10:34:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Mon, 6 Aug 2018 11:07:23 +0800

> The err is not modified after initalization, So remove it and make
> it to be void function.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v1->v2:
>  -  The initalization of err  to '0' is unnecesary. so drop the change

Applied, thank you.
