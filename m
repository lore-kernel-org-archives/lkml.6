Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33691C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ECE20661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfBWVgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:36:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42762 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWVgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:36:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 716C314B3DBDA;
        Sat, 23 Feb 2019 13:36:42 -0800 (PST)
Date:   Sat, 23 Feb 2019 13:36:41 -0800 (PST)
Message-Id: <20190223.133641.660058928993735320.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     netdev@vger.kernel.org, linux@roeck-us.net, songliubraving@fb.com,
        ast@kernel.org, yhs@fb.com, linux-kernel@vger.kernel.org,
        kafai@fb.com, daniel@iogearbox.net
Subject: Re: [PATCH] bpfilter: re-add header search paths to tools include
 to fix build error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1550805799-24572-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550805799-24572-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Feb 2019 13:36:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 22 Feb 2019 12:23:19 +0900

> I thought header search paths to tools/include(/uapi) were unneeded,
> but it looks like a build error occurs depending on the compiler.
> 
> Commit 303a339f30a9 ("bpfilter: remove extra header search paths for
> bpfilter_umh") reintroduced the build error fixed by commit ae40832e53c3
> ("bpfilter: fix a build err").
> 
> Apology for the breakage, and thanks to Guenter for reporting this.
> 
> Fixes: 303a339f30a9 ("bpfilter: remove extra header search paths for bpfilter_umh")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to net-next.
