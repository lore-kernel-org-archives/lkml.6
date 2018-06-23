Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37024C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE34B24A98
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE34B24A98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934628AbeFWBo5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:44:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34334 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933841AbeFWBo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:44:56 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0AC7F1264BF5C;
        Fri, 22 Jun 2018 18:44:53 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:44:52 +0900 (KST)
Message-Id: <20180623.104452.2046865225678747132.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microsemi.com
Subject: Re: [PATCH net] net: mscc: make sparse happy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180622095052.26726-1-antoine.tenart@bootlin.com>
References: <20180622095052.26726-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Jun 2018 18:44:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri, 22 Jun 2018 11:50:52 +0200

> This patch fixes a sparse warning about using an incorrect type in
> argument 2 of ocelot_write_rix(), as an u32 was expected but a __be32
> was given. The conversion to u32 is forced, which is safe as the value
> will be written as-is in the hardware without any modification.
> 
> Fixes: 08d02364b12f ("net: mscc: fix the injection header")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied.
