Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB40BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B470920675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbfAPXJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:09:51 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfAPXJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:09:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B0371340813B;
        Wed, 16 Jan 2019 15:09:50 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:09:47 -0800 (PST)
Message-Id: <20190116.150947.648508919785105752.davem@davemloft.net>
To:     ytht.net@gmail.com
Cc:     sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanha@redhat.com
Subject: Re: linux-next: Signed-off-by missing for commit in the net-next
 tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CALqoU4ywdKaeD_DX4pF2hOTh-LQb2N+zGhap6x4sskaf_YthJw@mail.gmail.com>
References: <20190117080619.5a632a41@canb.auug.org.au>
        <CALqoU4ywdKaeD_DX4pF2hOTh-LQb2N+zGhap6x4sskaf_YthJw@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Jan 2019 15:09:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lepton <ytht.net@gmail.com>
Date: Wed, 16 Jan 2019 14:27:45 -0800

> I sent another version with signed off serveral days ago:
> 
> https://www.spinics.net/lists/netdev/msg543829.html
> 
> So for some reason it got missed?

I didn't see it before I applied the initial patch because I was
heavily backlogged, I saw it afterwards...
