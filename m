Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7505C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8911E2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfA0STM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 13:19:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36670 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfA0STM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 13:19:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C58BE1086DD92;
        Sun, 27 Jan 2019 10:19:11 -0800 (PST)
Date:   Sun, 27 Jan 2019 10:19:11 -0800 (PST)
Message-Id: <20190127.101911.1334731946720302039.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=wgJQf+eS6MeEuUL59kSr-kiiYpzSUfErvO_yTQTNPtHwg@mail.gmail.com>
References: <20190125.162151.302539235913379257.davem@davemloft.net>
        <CAHk-=wgJQf+eS6MeEuUL59kSr-kiiYpzSUfErvO_yTQTNPtHwg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 27 Jan 2019 10:19:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Jan 2019 09:02:17 -0800

> I'm trying to be a bit stricter about the rc pulls, even if I normally
> don't even look at yours much.
> 
> So let's try to keep it to fixes only, or at least when you sneak in
> new stuff, make them small enough that I don't go "Hmm.. That looks
> odd.." ;)

Completely understood.

This one was actually my bad in the most heinous way, because the
submitter did say that the changes should go to net-next.

I have to tone down the meds or something.

Sorry!
