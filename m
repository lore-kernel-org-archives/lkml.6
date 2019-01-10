Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08BC214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfAJObn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:31:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAJObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:31:41 -0500
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C39D146D7882;
        Thu, 10 Jan 2019 06:31:40 -0800 (PST)
Date:   Thu, 10 Jan 2019 06:31:39 -0800 (PST)
Message-Id: <20190110.063139.1025068458152382906.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     arjun@chelsio.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb4: fix various indentation issues
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190107234809.14373-1-colin.king@canonical.com>
References: <20190107234809.14373-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 10 Jan 2019 06:31:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon,  7 Jan 2019 23:48:09 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are some lines that have indentation issues, fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
