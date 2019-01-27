Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20023C282C7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 02:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CD921726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 02:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfA0C1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 21:27:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59130 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfA0C1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 21:27:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D64C314E232C3;
        Sat, 26 Jan 2019 18:27:21 -0800 (PST)
Date:   Sat, 26 Jan 2019 18:27:19 -0800 (PST)
Message-Id: <20190126.182719.1754056487582705755.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lmc: remove -I. header search path
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1548426149-7961-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548426149-7961-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 26 Jan 2019 18:27:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 25 Jan 2019 23:22:29 +0900

> The header search path -I. in kernel Makefiles is very suspicious;
> it allows the compiler to search for headers in the top of $(srctree),
> where obviously no header file exists.
> 
> I was able to build without this header search path.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to net-next, thanks.
