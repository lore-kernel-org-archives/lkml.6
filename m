Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF9EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 05:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EA120870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 05:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EA120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeG2HOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 03:14:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeG2HOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 03:14:16 -0400
Received: from localhost (unknown [172.58.91.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85A5F13AEDDE4;
        Sat, 28 Jul 2018 22:45:05 -0700 (PDT)
Date:   Sat, 28 Jul 2018 22:45:01 -0700 (PDT)
Message-Id: <20180728.224501.542504602498362367.davem@davemloft.net>
To:     jcline@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Subject: Re: [PATCH 0/2] net: socket: Fix potential spectre v1 gadgets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727224302.5503-1-jcline@redhat.com>
References: <20180727224302.5503-1-jcline@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 28 Jul 2018 22:45:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jcline@redhat.com>
Date: Fri, 27 Jul 2018 22:43:00 +0000

> This fixes a pair of potential spectre v1 gadgets.
> 
> Note that because the speculation window is large, the policy is to stop
> the speculative out-of-bounds load and not worry if the attack can be
> completed with a dependent load or store[0].
> 
> [0] https://marc.info/?l=linux-kernel&m=152449131114778

Series applied, thank you.
