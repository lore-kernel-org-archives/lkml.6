Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93385C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A2326900
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A2326900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbeF0Bku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:40:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47642 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeF0Bkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:40:49 -0400
Received: from localhost (unknown [42.29.24.124])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F322C133FB1FC;
        Tue, 26 Jun 2018 18:40:46 -0700 (PDT)
Date:   Wed, 27 Jun 2018 10:40:45 +0900 (KST)
Message-Id: <20180627.104045.2031498066131384558.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     davejwatson@fb.com, borisp@mellanox.com, aviadye@mellanox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/tls: Remove VLA usage on nonce
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180625235505.GA22661@beast>
References: <20180625235505.GA22661@beast>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Jun 2018 18:40:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Mon, 25 Jun 2018 16:55:05 -0700

> It looks like the prior VLA removal, commit b16520f7493d ("net/tls: Remove
> VLA usage"), and a new VLA addition, commit c46234ebb4d1e ("tls: RX path
> for ktls"), passed in the night. This removes the newly added VLA, which
> happens to have its bounds based on the same max value.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks Kees.
