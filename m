Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07391C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CD921841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBTUl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:41:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55876 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTUl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:41:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DFD2512536DA8;
        Wed, 20 Feb 2019 12:41:55 -0800 (PST)
Date:   Wed, 20 Feb 2019 12:41:55 -0800 (PST)
Message-Id: <20190220.124155.2226787912266109280.davem@davemloft.net>
To:     tony@atomide.com
Cc:     grygorii.strashko@ti.com, kishon@ti.com, robh+dt@kernel.org,
        netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220203326.GT15711@atomide.com>
References: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
        <20190220.112244.1206973642383679896.davem@davemloft.net>
        <20190220203326.GT15711@atomide.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Feb 2019 12:41:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Feb 2019 12:33:26 -0800

> * David Miller <davem@davemloft.net> [190220 19:23]:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>> Date: Wed, 20 Feb 2019 17:25:19 +0200
>> 
>> > Deprecate cpsw-phy-sel driver as it's been replaced with new
>> > TI phy-gmii-sel PHY driver.
>> > 
>> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> 
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Thanks for the ack, but actually I'd prefer you to pick
> this patch at some future date. I suggest Grygorii just
> repost this one after v5.1-rc1.

It's so much easier if you group this with those DT changes, they
logically belong together as well and it helps someone reading
the changes in the tree also if they are side by side.

Why don't you want to integrate this with them?
