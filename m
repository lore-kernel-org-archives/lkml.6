Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A75C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91A12098B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91A12098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeHPWaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:30:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60916 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPWaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:30:23 -0400
Received: from localhost (unknown [205.153.50.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2FC3A145E666C;
        Thu, 16 Aug 2018 12:30:03 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:30:02 -0700 (PDT)
Message-Id: <20180816.123002.844201503080913720.davem@davemloft.net>
To:     jianjian.wang1@gmail.com
Cc:     jasowang@redhat.com, girish.moodalbail@oracle.com, mst@redhat.com,
        willemb@google.com, viro@zeniv.linux.org.uk, wexu@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tap: comment fix
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAP4sYWUDb8wtNVvgPO+3a5MWoiBGuafQpvG6KR30RWinf36Msw@mail.gmail.com>
References: <CAP4sYWUDb8wtNVvgPO+3a5MWoiBGuafQpvG6KR30RWinf36Msw@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Aug 2018 12:30:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jian <jianjian.wang1@gmail.com>
Date: Thu, 16 Aug 2018 21:01:27 +0800

> The tap_queue and the "tap_dev" are loosely coupled, not "macvlan_dev".
> 
> And I also change one rcu_read_lock's place, seems can reduce rcu
> critical section a little.
> 
> Signed-off-by: Wang Jian <jianjian.wang1@gmail.com>

This patch was corrupted by your email client, for example it turned
TAB characters into sequences of spaces.

Please fix this, email a test patch to yourself, and do not resend the
patch to this mailing list until you can successfully extract and
cleanly apply the test patch you email to yourself.

Thank you.
