Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39F2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7C220835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7C220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJKMoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:44:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeJKMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 08:44:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 035ED12130EB1;
        Wed, 10 Oct 2018 22:18:42 -0700 (PDT)
Date:   Wed, 10 Oct 2018 22:18:40 -0700 (PDT)
Message-Id: <20181010.221840.945121881022811735.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     igor.russkikh@aquantia.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: aquantia: remove some redundant variable
 initializations
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181008133558.5841-1-colin.king@canonical.com>
References: <20181008133558.5841-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Oct 2018 22:18:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon,  8 Oct 2018 14:35:58 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several variables being initialized that are being set later
> and hence the initialization is redundant and can be removed. Remove
> then.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
