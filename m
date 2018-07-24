Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E73ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDBD2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDBD2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbeGXR5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:57:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34650 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbeGXR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:52 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 26693108B628B;
        Tue, 24 Jul 2018 09:50:30 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:50:26 -0700 (PDT)
Message-Id: <20180724.095026.1142374357536198879.davem@davemloft.net>
To:     gregory.clement@bootlin.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, yelena@marvell.com,
        nadavh@marvell.com, mw@semihalf.com, dima@marvell.com,
        antoine.tenart@bootlin.com, miquel.raynal@bootlin.com,
        maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v3 0/8] A fix and a few improvements on mvneta
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87h8ko7ozf.fsf@bootlin.com>
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
        <87h8ko7ozf.fsf@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Jul 2018 09:50:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Tue, 24 Jul 2018 15:16:52 +0200

> I saw in patchwork, the status was "Accepted" (for example the 1st patch
> [1]). However the series is not in your git branches and usually you
> also answered to the series to inform that you have applied it. So I
> would like to know what is the status of the series.

Sorry about that, I'll take a look and try to figure out what happened
and fix it up.
