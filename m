Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51F5218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfAYXau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:30:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48434 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYXau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:30:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D38E1496ED2C;
        Fri, 25 Jan 2019 15:30:49 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:30:49 -0800 (PST)
Message-Id: <20190125.153049.398047611332640267.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     tomer.tayar@cavium.com, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=whFc9FmZe-eO39nRKcXLYqO=Ni-p1ht=tNFtYdtCw07UQ@mail.gmail.com>
References: <20190125.115827.1407196401514719611.davem@davemloft.net>
        <CAHk-=whgEt4tUaF=6FstoETUKRzCD5WFzWvE_w9Jb7Kp1rbUFg@mail.gmail.com>
        <CAHk-=whFc9FmZe-eO39nRKcXLYqO=Ni-p1ht=tNFtYdtCw07UQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 25 Jan 2019 15:30:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Jan 2019 13:25:22 -1000

> No way is this appropriate. Get rid of it.

Ok, consider it done.
