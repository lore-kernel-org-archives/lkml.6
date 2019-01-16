Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A16DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0341F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbfAPWDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:03:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45462 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbfAPWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:03:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DB6C412673A45;
        Wed, 16 Jan 2019 14:03:52 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:03:52 -0800 (PST)
Message-Id: <20190116.140352.554500140177001885.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     ariel.elior@cavium.com, sudarsana.kalluru@cavium.com,
        everest-linux-l2@cavium.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnx2x: fix various indentation issues
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190114151516.17744-1-colin.king@canonical.com>
References: <20190114151516.17744-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Jan 2019 14:03:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 14 Jan 2019 15:15:16 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are lines that have indentation issues, fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
