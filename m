Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F9ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0F62086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0F62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJ0COM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:14:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46932 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbeJ0COM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:14:12 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B45DA148A4D4B;
        Fri, 26 Oct 2018 10:36:18 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:36:17 -0700 (PDT)
Message-Id: <20181026.103617.373827980255084988.davem@davemloft.net>
To:     vijaykhemka@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Justin.Lee1@Dell.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
From:   David Miller <davem@davemloft.net>
In-Reply-To: <F0024535-93C3-4470-98A6-F57426587474@fb.com>
References: <20181025220413.2936698-1-vijaykhemka@fb.com>
        <20181025.155335.2132843393553452471.davem@davemloft.net>
        <F0024535-93C3-4470-98A6-F57426587474@fb.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Oct 2018 10:36:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 26 Oct 2018 17:19:49 +0000

> Do you have any timeline when it is going to open next or how do I
> know.

I always announce net-next openning and closing here on the list.

There is also a web site:

	http://vger.kernel.org/~davem/net-next.html

Thanks.
