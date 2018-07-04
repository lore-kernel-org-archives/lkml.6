Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6883C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7927223CAF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7927223CAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeGDNkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:40:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37188 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeGDNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:40:20 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BB7101094CA94;
        Wed,  4 Jul 2018 06:40:18 -0700 (PDT)
Date:   Wed, 04 Jul 2018 22:40:17 +0900 (KST)
Message-Id: <20180704.224017.1182444162221613940.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     jes@trained-monkey.org, linux-acenic@sunsite.dk,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: alteon: acenic: remove redundant pointer rxdesc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180704070135.13938-1-colin.king@canonical.com>
References: <20180704070135.13938-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Jul 2018 06:40:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed,  4 Jul 2018 08:01:35 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer rxdesc is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'rxdesc' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
