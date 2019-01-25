Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718BFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFF6218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfAYXac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:30:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48426 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYXab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:30:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AC9511496ED2C;
        Fri, 25 Jan 2019 15:30:30 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:30:26 -0800 (PST)
Message-Id: <20190125.153026.1506484459234355212.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=whgEt4tUaF=6FstoETUKRzCD5WFzWvE_w9Jb7Kp1rbUFg@mail.gmail.com>
References: <20190125.115827.1407196401514719611.davem@davemloft.net>
        <CAHk-=whgEt4tUaF=6FstoETUKRzCD5WFzWvE_w9Jb7Kp1rbUFg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 25 Jan 2019 15:30:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Jan 2019 13:15:37 -1000

> You don't even *mention*  the changes to the qlogic driver that are
> completely new and over a thousand lines.

It's error recovery code and I trust the judgment of the qlogic folks
that this was appropriate to add.

I am more than happy to revert if you disagree.

Thanks.
