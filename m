Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA61C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DA82172F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DA82172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbeHNTwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:52:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52446 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733125AbeHNTwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:52:50 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1F7613CED779;
        Tue, 14 Aug 2018 10:04:50 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:04:50 -0700 (PDT)
Message-Id: <20180814.100450.716865241721191781.davem@davemloft.net>
To:     ndesaulniers@google.com
Cc:     natechancellor@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inet/connection_sock: prefer _THIS_IP_ to
 current_text_addr
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAKwvOdkvk7wN_iypAa09xhju2-XE60Nn16QjAKzK4mZkEBfNBw@mail.gmail.com>
References: <CAKwvOdnp7R094sbsyKi921ZVB8BD+d-8L37mcPv0UjMMF4QqDg@mail.gmail.com>
        <20180802.151740.166085629835691260.davem@davemloft.net>
        <CAKwvOdkvk7wN_iypAa09xhju2-XE60Nn16QjAKzK4mZkEBfNBw@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Aug 2018 10:04:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 13 Aug 2018 14:10:08 -0700

> Can you please pick this up for the net-next tree then?

Sure, done.
