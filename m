Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0119DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EA320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EA320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbeGWWz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:55:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49392 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388161AbeGWWz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:55:57 -0400
Received: from localhost (unknown [172.58.43.32])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1F17712DE5811;
        Mon, 23 Jul 2018 14:52:44 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:52:40 -0700 (PDT)
Message-Id: <20180723.145240.185951244068948936.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, rdunlap@infradead.org
Subject: Re: [PATCH] media: staging: omap4iss: Include asm/cacheflush.h
 after generic includes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532381973-11856-1-git-send-email-linux@roeck-us.net>
References: <1532381973-11856-1-git-send-email-linux@roeck-us.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Jul 2018 14:52:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Jul 2018 14:39:33 -0700

> Including asm/cacheflush.h first results in the following build error when
> trying to build sparc32:allmodconfig.
 ...
> Include generic includes files first to fix the problem.
> 
> Fixes: fc96d58c10162 ("[media] v4l: omap4iss: Add support for OMAP4 camera interface - Video devices")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David Miller <davem@davemloft.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: David S. Miller <davem@davemloft.net>
