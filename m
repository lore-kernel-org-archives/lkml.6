Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A5AC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD9A2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD9A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeHSVCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:02:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33368 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeHSVCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:02:04 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9D7651473A806;
        Sun, 19 Aug 2018 10:49:48 -0700 (PDT)
Date:   Sun, 19 Aug 2018 10:49:44 -0700 (PDT)
Message-Id: <20180819.104944.1717508823921470560.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     Jisheng.Zhang@synaptics.com, thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada
 3700
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810222335.GD11955@lunn.ch>
References: <20180810113627.5dec5d40@xhacker.debian>
        <20180810.144031.861564620036768413.davem@davemloft.net>
        <20180810222335.GD11955@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Aug 2018 10:49:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 11 Aug 2018 00:23:35 +0200

> Please can you queue up:
> 
> Fixes: 7a86f05faf11 ("net: ethernet: mvneta: Fix napi structure mixup on armada 3700")
> 
> and this patch for stable.

Since these are now both in Linus's tree, done.

But, if one thinks the change belongs in -stable, target 'net' always.
