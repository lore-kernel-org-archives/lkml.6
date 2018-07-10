Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60802C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F8320A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F8320A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbeGJX4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:56:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54032 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbeGJX4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:56:47 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C1ADE1098F5F9;
        Tue, 10 Jul 2018 16:55:17 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:55:15 -0700 (PDT)
Message-Id: <20180710.165515.931825211430361252.davem@davemloft.net>
To:     neilb@suse.com
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, tom@quantonium.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rhashtable: replace rhashtable_walk_peek
 implementation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <153086101070.2825.6850140624411927465.stgit@noble>
References: <153086101070.2825.6850140624411927465.stgit@noble>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 10 Jul 2018 16:55:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Fri, 06 Jul 2018 17:11:32 +1000

> This is a resend of these three patches with no change
> from last time.
> The last patch has an Ack from Tom Herbert and Herbert Xu, but the
> first two which are necessary pre-requisites don't yet.

Please repost this when your dependencies are actually in the
tree, not beforehand.

Otherwise you make more work for me, and you completely destroy
the value of the kbuild test robot.

Thank you.
