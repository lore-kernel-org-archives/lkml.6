Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0760DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD002087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfADVGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:06:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48804 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfADVGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:06:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2171714C5D370;
        Fri,  4 Jan 2019 13:06:54 -0800 (PST)
Date:   Fri, 04 Jan 2019 13:06:53 -0800 (PST)
Message-Id: <20190104.130653.986135602696070698.davem@davemloft.net>
To:     sbrivio@redhat.com
Cc:     syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com,
        willemdebruijn.kernel@gmail.com, eric.dumazet@gmail.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, dvyukov@google.com,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net 0/2] Fix two further potential unbounded recursions
 in GUE error handlers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1546547862.git.sbrivio@redhat.com>
References: <cover.1546547862.git.sbrivio@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Jan 2019 13:06:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>
Date: Thu,  3 Jan 2019 21:43:33 +0100

> Patch 1/2 takes care of preventing the issue fixed by commit 11789039da53
> ("fou: Prevent unbounded recursion in GUE error handler") also with
> UDP-Lite payloads -- I just realised this might happen from a syzbot
> report.
> 
> Patch 2/2 fixes the issue for both UDP and UDP-Lite on IPv6, which I also
> forgot to deal with in that same commit.

Series applied, thanks.
