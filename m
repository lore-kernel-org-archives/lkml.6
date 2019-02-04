Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA1FC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16CD2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBDENc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:13:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46780 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfBDENc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:13:32 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EB6D814DF23D8;
        Sun,  3 Feb 2019 20:13:30 -0800 (PST)
Date:   Sun, 03 Feb 2019 20:13:28 -0800 (PST)
Message-Id: <20190203.201328.1920617828984866065.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        mcroce@redhat.com, linux-kernel@vger.kernel.org,
        jakub.kicinski@netronome.com, labbott@redhat.com, ast@fb.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH] bpfilter: remove extra header search paths for
 bpfilter_umh
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1548904535-9853-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548904535-9853-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Feb 2019 20:13:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 31 Jan 2019 12:15:35 +0900

> Currently, the header search paths -Itools/include and
> -Itools/include/uapi are not used. Let's drop the unused code.
> 
> We can remove -I. too by fixing up one C file.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I guess I'm ok with this, applied to net-next.

Thanks for explaining things.
