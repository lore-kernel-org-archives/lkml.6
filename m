Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60693C46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0939C214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0939C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbeKFDab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:30:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59456 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbeKFDab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:30:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0FFB6144A04B2;
        Mon,  5 Nov 2018 10:09:40 -0800 (PST)
Date:   Mon, 05 Nov 2018 10:09:39 -0800 (PST)
Message-Id: <20181105.100939.1815554550864302569.davem@davemloft.net>
To:     tiny.windzz@gmail.com
Cc:     edumazet@google.com, willemb@google.com, dja@axtens.net,
        ast@kernel.org, sbrivio@redhat.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: skbuff.h: remove unnecessary unlikely()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAEExFWuGN_R=7B4ueAVA8hVoix8ko8zQSXzHxZB5gjwP7jOjpg@mail.gmail.com>
References: <20181104131444.4049-1-tiny.windzz@gmail.com>
        <CAEExFWuGN_R=7B4ueAVA8hVoix8ko8zQSXzHxZB5gjwP7jOjpg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 10:09:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Lee <tiny.windzz@gmail.com>
Date: Mon, 5 Nov 2018 21:21:50 +0800

> add netdev@vger.kernel.org
> -- Yangtao

Sorry, you can't do it like that.

You have to make a formal, fresh, posting to netdev with your patch.

Thank you.
