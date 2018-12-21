Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6EAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13907217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbeLUAlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:41:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35916 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeLUAlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:41:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 21B40149BDD0B;
        Thu, 20 Dec 2018 16:41:14 -0800 (PST)
Date:   Thu, 20 Dec 2018 16:41:13 -0800 (PST)
Message-Id: <20181220.164113.1954199771405222572.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     dsahern@gmail.com, roopa@cumulusnetworks.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] neighbour: remove stray semicolon
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181220165050.17429-1-colin.king@canonical.com>
References: <20181220165050.17429-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 20 Dec 2018 16:41:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 20 Dec 2018 16:50:50 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the stray semicolon means that the final term in the addition
> is being missed.  Fix this by removing it. Cleans up clang warning:
> 
> net/core/neighbour.c:2821:9: warning: expression result unused [-Wunused-value]
> 
> Fixes: 82cbb5c631a0 ("neighbour: register rtnl doit handler")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks Colin.
