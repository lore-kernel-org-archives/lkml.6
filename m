Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA2C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDC22075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDC22075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeJ2LD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:03:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53168 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeJ2LD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:03:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 24A4E133FBEEE;
        Sun, 28 Oct 2018 19:17:21 -0700 (PDT)
Date:   Sun, 28 Oct 2018 19:17:16 -0700 (PDT)
Message-Id: <20181028.191716.382124691461827661.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuhangbin@gmail.com
Subject: Re: linux-next: build failure in Linus' tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=wi475eRvUDctiWdBWsEB7UYgr8OrpPzrd=xkevUpTSCuA@mail.gmail.com>
References: <20181029093532.38a3888e@canb.auug.org.au>
        <CAHk-=wi475eRvUDctiWdBWsEB7UYgr8OrpPzrd=xkevUpTSCuA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 28 Oct 2018 19:17:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Oct 2018 15:45:16 -0700

> On Sun, Oct 28, 2018 at 3:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the origin tree, today's linux-next build (powerpc
>> ppc64_defconfig) failed like this:
> 
> linux-next is back! Wheee..
> 
>>   5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
> 
> David?

I'm on it and have a fix coming.
