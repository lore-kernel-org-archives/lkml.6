Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A02C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841A82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841A82084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeJFAum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:50:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFAum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:50:42 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1034813ADF96D;
        Fri,  5 Oct 2018 10:50:55 -0700 (PDT)
Date:   Fri, 05 Oct 2018 10:50:54 -0700 (PDT)
Message-Id: <20181005.105054.26315414942706191.davem@davemloft.net>
To:     richard.weinberger@gmail.com
Cc:     Jason@zx2c4.com, ebiggers@kernel.org, ard.biesheuvel@linaro.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAFLxGvw154vyOziRKuFf5-XTa1NcQm5ZVmgUy3=F79k=Rw2dvA@mail.gmail.com>
References: <20181003064951.GC745@sol.localdomain>
        <CAHmME9ogY=v2Le85+_=-m++RwAzwiUmKyNzx6N2y9Ht-J7xBcQ@mail.gmail.com>
        <CAFLxGvw154vyOziRKuFf5-XTa1NcQm5ZVmgUy3=F79k=Rw2dvA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 10:50:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 5 Oct 2018 15:37:57 +0200

> And I strongly vote that Herbert Xu shall remain the maintainer of
> the whole crypto system (including zinc!) in the kernel.

I 100% agree with this.
