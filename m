Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC1DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D262147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfBTGsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:48:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBTGsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:48:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F399413DB8D47;
        Tue, 19 Feb 2019 22:48:13 -0800 (PST)
Date:   Tue, 19 Feb 2019 22:48:13 -0800 (PST)
Message-Id: <20190219.224813.723564128666927693.davem@davemloft.net>
To:     vkoul@kernel.org
Cc:     sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220044055.GD21884@vkoul-mobl>
References: <20190220093136.73779781@canb.auug.org.au>
        <20190220044055.GD21884@vkoul-mobl>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Feb 2019 22:48:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>
Date: Wed, 20 Feb 2019 10:10:55 +0530

> On 20-02-19, 09:31, Stephen Rothwell wrote:
>> Hi all,
>> 
>> In commit
>> 
>>   a968b5e9d587 ("net: dsa: qca8k: Enable delay for RGMII_ID mode")
>> 
>> Fixes tag
>> 
>>   Fixes: 40269aa9f40a ("net: dsa: qca8k: disable delay for RGMII mode")
>> 
>> has these problem(s):
>> 
>>   - Target SHA1 does not exist
>> 
>> Did you mean:
>> 
>>   Fixes: 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode")
> 
> Yes looks like I messed up the commit id.. Not sure why :(
> 
> Dave would you like to drop this and me sending updated patch or
> something else..
> 
> Sorry about the miss

Doesn't work that way, something in my tree is there forever.
