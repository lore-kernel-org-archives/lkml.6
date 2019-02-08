Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF5BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DFC20836
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBHXUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:20:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfBHXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:20:42 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3DC9E149C25B4;
        Fri,  8 Feb 2019 15:20:42 -0800 (PST)
Date:   Fri, 08 Feb 2019 15:20:41 -0800 (PST)
Message-Id: <20190208.152041.1940768604724106089.davem@davemloft.net>
To:     nicolas.ferre@microchip.com
Cc:     alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] net: macb: add sam9x60-macb compatibility string
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190206175610.26773-3-nicolas.ferre@microchip.com>
References: <20190206175610.26773-1-nicolas.ferre@microchip.com>
        <20190206175610.26773-3-nicolas.ferre@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Feb 2019 15:20:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Wed, 6 Feb 2019 18:56:10 +0100

> Add a new compatibility string for this product. It's using
> at91sam9260-macb layout but has a newer hardware revision: it's safer
> to use its own string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to net-next.
