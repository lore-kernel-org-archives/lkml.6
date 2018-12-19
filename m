Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83870C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A5421871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeLSFvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:51:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49444 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeLSFvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:51:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 919FB14B9B6E8;
        Tue, 18 Dec 2018 21:51:46 -0800 (PST)
Date:   Tue, 18 Dec 2018 21:51:46 -0800 (PST)
Message-Id: <20181218.215146.756077002717384391.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: Add a maintainer for Microsemi
 switches
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181218142539.996-1-alexandre.belloni@bootlin.com>
References: <20181218142539.996-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 21:51:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 18 Dec 2018 15:25:39 +0100

> Microsemi has been bought by Microchip and Microchip is supporting those
> switches.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied.
