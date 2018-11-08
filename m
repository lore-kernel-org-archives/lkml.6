Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96121ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2C2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E2C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKIERk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:17:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34186 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeKIERk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:17:40 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5CED41451A893;
        Thu,  8 Nov 2018 10:34:31 -0800 (PST)
Date:   Thu, 08 Nov 2018 10:34:28 -0800 (PST)
Message-Id: <20181108.103428.494936194513918478.davem@davemloft.net>
To:     suraj1998@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com
Subject: Re: [PATCH] staging: net: ipv4: tcp_vegas: fixed checks and
 warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541665792-5888-1-git-send-email-suraj1998@gmail.com>
References: <1541665792-5888-1-git-send-email-suraj1998@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 10:34:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Singh <suraj1998@gmail.com>
Date: Thu,  8 Nov 2018 13:59:52 +0530

> Fixed checks and warnings in TCP Vegas
> 
> Signed-off-by: Suraj Singh <suraj1998@gmail.com>

Once again, please explain why you are putting "staging: " into the subject
line of your TCP congestion control patches.

If you do not answer this question and fix your Subject lines, I will
really have no choice but to ignore your submissions as you are
ignoring our feedback.

Thank you.
