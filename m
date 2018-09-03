Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77C5C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694D620878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694D620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeICXa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:30:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46502 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICXa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:30:59 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 484B71449BE78;
        Mon,  3 Sep 2018 12:09:27 -0700 (PDT)
Date:   Mon, 03 Sep 2018 12:09:10 -0700 (PDT)
Message-Id: <20180903.120910.2227273252885975717.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 4.19-rc2
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180903182202.GA14258@roeck-us.net>
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
        <20180903182202.GA14258@roeck-us.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Sep 2018 12:09:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 3 Sep 2018 11:22:02 -0700

> The sparc32:allmodconfig build problem is the same as last week.
> David - any interest/plan to get this fixed, or should I just drop
> the build ?

I didn't see it, please give me a reference to the details.

Thanks.
