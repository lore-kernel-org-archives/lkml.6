Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A1C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBB220866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBB220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJSGoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:44:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeJSGoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:44:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 51CE21000932A;
        Thu, 18 Oct 2018 15:41:28 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:41:27 -0700 (PDT)
Message-Id: <20181018.154127.945780492391744369.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: eni: Move semicolon to a new line after empty for
 loop
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181017180334.8640-1-natechancellor@gmail.com>
References: <20181017180334.8640-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 15:41:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 17 Oct 2018 11:03:34 -0700

> Clang warns:
> 
> drivers/atm/eni.c:244:48: error: for loop has empty body
> [-Werror,-Wempty-body]
>         for (order = 0; (1 << order) < *size; order++);
>                                                       ^
> drivers/atm/eni.c:244:48: note: put the semicolon on a separate line to
> silence this warning
> 
> In this case, that loop is expected to be empty so silence the warning
> in the way that Clang suggests.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/42
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
