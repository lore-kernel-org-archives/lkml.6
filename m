Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6461B2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfBUVJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:09:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43036 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:09:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B6DC4145EE2BE;
        Thu, 21 Feb 2019 13:09:24 -0800 (PST)
Date:   Thu, 21 Feb 2019 13:09:24 -0800 (PST)
Message-Id: <20190221.130924.1528597272966367616.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_rhashtable: fix spelling mistake "existant"
 -> "existent"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190217225209.17536-1-colin.king@canonical.com>
References: <20190217225209.17536-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Feb 2019 13:09:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun, 17 Feb 2019 22:52:09 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in warning macro messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
