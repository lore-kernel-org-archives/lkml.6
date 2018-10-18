Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E0FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CD021480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CD021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJRNbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:31:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeJRNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:31:07 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C134D13AE6FC0;
        Wed, 17 Oct 2018 22:31:52 -0700 (PDT)
Date:   Wed, 17 Oct 2018 22:31:52 -0700 (PDT)
Message-Id: <20181017.223152.1247618584989583539.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: skbuff.h: Mark expected switch
 fall-throughs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181017130137.GA739@embeddedor.com>
References: <20181017130137.GA739@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 22:31:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 17 Oct 2018 15:01:37 +0200

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
