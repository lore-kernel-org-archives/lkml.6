Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 21:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5042070C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeL3VDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 16:03:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeL3VDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 16:03:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BA2E314AC3A4E;
        Sun, 30 Dec 2018 13:03:05 -0800 (PST)
Date:   Sun, 30 Dec 2018 13:03:05 -0800 (PST)
Message-Id: <20181230.130305.1166520195525645576.davem@davemloft.net>
To:     suyj.fnst@cn.fujitsu.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: fix typo in net/ipv6/reassembly.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546110476-20058-1-git-send-email-suyj.fnst@cn.fujitsu.com>
References: <1546110476-20058-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 30 Dec 2018 13:03:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Date: Sat, 29 Dec 2018 14:07:55 -0500

> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>

Applied.
