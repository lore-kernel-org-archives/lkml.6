Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B3ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23CC20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23CC20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeJYIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:32:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43532 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:32:27 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5598D145DC270;
        Wed, 24 Oct 2018 17:02:16 -0700 (PDT)
Date:   Wed, 24 Oct 2018 17:02:13 -0700 (PDT)
Message-Id: <20181024.170213.632063387857625082.davem@davemloft.net>
To:     joe@perches.com
Cc:     w@1wt.eu, wanghaifine@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com, lkp@01.org
Subject: Re: [PATCH] Change judgment len position
From:   David Miller <davem@davemloft.net>
In-Reply-To: <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
References: <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
        <20181024204852.GA25509@1wt.eu>
        <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Oct 2018 17:02:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Wed, 24 Oct 2018 16:46:18 -0700

> I would have suggested David reply with only his second sentence
> and maybe a pointer to kernelnewbies or staging.

I maintain that I was not out of line with my comment.

I sought a second opinion from Greg KH and others, and they agree with
me that I was still kind with my choice of words.

I think you're taking things too far, and I will simply not stand for
this overreaching judgement upon my behavior on this list which is
completely not justified.

Thank you.
