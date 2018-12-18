Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F62C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5683921871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeLRWt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:49:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43386 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeLRWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:49:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 937C4147F209D;
        Tue, 18 Dec 2018 14:49:55 -0800 (PST)
Date:   Tue, 18 Dec 2018 14:49:50 -0800 (PST)
Message-Id: <20181218.144950.1319190595342536759.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com, baruch@tkos.co.il
Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181211163228.26130-1-antoine.tenart@bootlin.com>
References: <20181211163228.26130-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 14:49:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Tue, 11 Dec 2018 17:32:28 +0100

> The mvpp2_phylink_validate() function sets all modes that are
> supported by a given PPv2 port. A recent change made all ports to
> advertise they support 10G modes in certain cases. This is not true,
> as only the port #0 can do so. This patch fixes it.
> 
> Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied, thank you.
