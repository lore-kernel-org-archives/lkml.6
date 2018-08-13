Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C7221798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C7221798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbeHMVeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:34:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57078 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbeHMVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:34:05 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 71EFB142A5A50;
        Mon, 13 Aug 2018 11:50:38 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:50:38 -0700 (PDT)
Message-Id: <20180813.115038.2070003569481963697.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-tape: remove redundant variable buffer_size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180702100026.16007-1-colin.king@canonical.com>
References: <20180702100026.16007-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 11:50:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon,  2 Jul 2018 11:00:26 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable buffer_size is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'buffer_size' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
