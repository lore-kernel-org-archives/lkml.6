Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F2321841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBTUm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:42:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55908 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfBTUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:42:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0EDA12536DA8;
        Wed, 20 Feb 2019 12:42:25 -0800 (PST)
Date:   Wed, 20 Feb 2019 12:42:25 -0800 (PST)
Message-Id: <20190220.124225.847188318007300089.davem@davemloft.net>
To:     sbrivio@redhat.com
Cc:     jiri@resnulli.us, vkoul@kernel.org, sfr@canb.auug.org.au,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220213729.49deb54f@redhat.com>
References: <20190220205910.7bd7fd40@redhat.com>
        <20190220.122548.2257661716734858013.davem@davemloft.net>
        <20190220213729.49deb54f@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Feb 2019 12:42:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>
Date: Wed, 20 Feb 2019 21:37:29 +0100

> On Wed, 20 Feb 2019 12:25:48 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
>> From: Stefano Brivio <sbrivio@redhat.com>
>> Date: Wed, 20 Feb 2019 20:59:10 +0100
>> 
>> > On Wed, 20 Feb 2019 11:02:01 -0800 (PST)
>> > David Miller <davem@davemloft.net> wrote:
>> >   
>> >> From: Jiri Pirko <jiri@resnulli.us>
>> >> Date: Wed, 20 Feb 2019 09:36:11 +0100
>> >>   
>> >> > Would be good to have some robot checking "Fixes" sanity...    
>> >> 
>> >> I want to add a script to my trees that locally do it for me but the
>> >> backlog for patch review for me is so huge that I never get to "fun"
>> >> tasks like that....  
>> > 
>> > If it helps, this is what I use after being bitten once:  
>> 
>> Awesome, thanks!  You put this in as a pre-commit script?
> 
> Nope, I use it before sending patches out with git send-email.
> 
> But you can use this as .git/hooks/commit-msg, just skip taking the
> tree as second argument, something like this (just quickly tested):

Awesome, thank you!
