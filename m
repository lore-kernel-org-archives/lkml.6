Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C88DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6032146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfBTUZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:25:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55654 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfBTUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:25:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D78E1123A52EE;
        Wed, 20 Feb 2019 12:25:24 -0800 (PST)
Date:   Wed, 20 Feb 2019 12:25:22 -0800 (PST)
Message-Id: <20190220.122522.1237657062289636264.davem@davemloft.net>
To:     jiri@resnulli.us
Cc:     vkoul@kernel.org, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220195811.GO3080@nanopsycho>
References: <20190220083611.GJ3080@nanopsycho>
        <20190220.110201.2245447687492293995.davem@davemloft.net>
        <20190220195811.GO3080@nanopsycho>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Feb 2019 12:25:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Pirko <jiri@resnulli.us>
Date: Wed, 20 Feb 2019 20:58:11 +0100

> Wed, Feb 20, 2019 at 08:02:01PM CET, davem@davemloft.net wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Date: Wed, 20 Feb 2019 09:36:11 +0100
>>
>>> Would be good to have some robot checking "Fixes" sanity...
>>
>>I want to add a script to my trees that locally do it for me but the
> 
> When it is in tree, it's already late. The robot has to check
> emails/patchwork.

It's for me, on my computer, to abort things when I try to commit
with a bad fixes tag or missing signoff.

