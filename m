Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1E520825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1E520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeKJPOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:14:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37704 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeKJPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:14:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 11A7814BA9F3F;
        Fri,  9 Nov 2018 20:14:10 -0800 (PST)
Date:   Fri, 09 Nov 2018 20:14:09 -0800 (PST)
Message-Id: <20181109.201409.285067017045935389.davem@davemloft.net>
To:     kyle.roeschley@ni.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: leds: Don't make our own link speed names
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181109184803.15588-1-kyle.roeschley@ni.com>
References: <20181109184803.15588-1-kyle.roeschley@ni.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 09 Nov 2018 20:14:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Roeschley <kyle.roeschley@ni.com>
Date: Fri, 9 Nov 2018 12:48:03 -0600

> The phy core provides a handy phy_speed_to_str() helper, so use that
> instead of doing our own formatting of the different known link speeds.
> To do this, increase PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE to 11 so we can fit
> 'Unsupported' if necessary.
> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>

Applied to net-next.
