Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A5C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82E42244B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82E42244B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeHJT4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:56:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54128 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeHJT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:56:06 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AD48E142E5E46;
        Fri, 10 Aug 2018 10:25:20 -0700 (PDT)
Date:   Fri, 10 Aug 2018 10:25:20 -0700 (PDT)
Message-Id: <20180810.102520.1076878966668982424.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: chelsio: cxgb2: remove unused array pci_speed
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810080217.26758-1-colin.king@canonical.com>
References: <20180810080217.26758-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Aug 2018 10:25:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 10 Aug 2018 09:02:17 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Array pci_speed is defined but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: 'pci_speed' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
