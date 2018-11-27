Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E157BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E3A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E3A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeK1Kcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:32:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45788 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeK1Kcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:32:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5962314E09835;
        Tue, 27 Nov 2018 15:33:00 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:32:59 -0800 (PST)
Message-Id: <20181127.153259.1657295271764002647.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firestream: fix spelling mistake: "Inititing" ->
 "Initializing"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181125232108.14548-1-colin.king@canonical.com>
References: <20181125232108.14548-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 27 Nov 2018 15:33:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun, 25 Nov 2018 23:21:08 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in debug messages, fix them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
