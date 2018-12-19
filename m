Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3C0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44D7218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeLSQeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:34:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeLSQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:34:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2173814E2221C;
        Wed, 19 Dec 2018 08:34:21 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:34:18 -0800 (PST)
Message-Id: <20181219.083418.1274588153696095550.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net v3 0/2] net: mvpp2: phylink validate fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181219082609.GH20364@kwain>
References: <20181217145606.13847-1-antoine.tenart@bootlin.com>
        <20181218.164252.1932839718305986043.davem@davemloft.net>
        <20181219082609.GH20364@kwain>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Dec 2018 08:34:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Wed, 19 Dec 2018 09:26:09 +0100

> Hi David,
> 
> On Tue, Dec 18, 2018 at 04:42:52PM -0800, David Miller wrote:
>> From: Antoine Tenart <antoine.tenart@bootlin.com>
>> Date: Mon, 17 Dec 2018 15:56:04 +0100
>> 
>> > This small series introduces 2 fixes for the phylink validate function
>> > of the Marvell PPv2 Ethernet driver.
>> > 
>> > Since v2:
>> >   - Added an additional patch (2/2) as suggested by Russell.
>> >   - Rebased on top of net/master.
>> > 
>> > Since v1:
>> >   - Rebased on top of net/master.
>> 
>> Because, in the end, I applied:
>> 
>> 006791772084 ("net: mvpp2: 10G modes aren't supported on all ports")
>>
>> I am assuming this series is not relevant.
> 
> The patch 2/2 ("net: mvpp2: fix the phylink mode validation") is still
> relevant, in addition to the patch you applied. It was added in v3, and
> is an (unrelated) addition to the first patch.

Sorry about that!

Please resubmit patch #2 separately and I'll apply it.

Thank you!
