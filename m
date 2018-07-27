Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E1FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9220671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF9220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbeG0Vmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:42:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38208 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389416AbeG0Vmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:42:55 -0400
Received: from localhost (unknown [172.56.44.110])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A030B103192D0;
        Fri, 27 Jul 2018 13:19:24 -0700 (PDT)
Date:   Fri, 27 Jul 2018 13:19:23 -0700 (PDT)
Message-Id: <20180727.131923.1126798474002765240.davem@davemloft.net>
To:     anders.roxell@linaro.org
Cc:     santosh.shilimkar@oracle.com, eric.dumazet@gmail.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/rds/Kconfig: Correct the RDS depends
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727131849.18488-1-anders.roxell@linaro.org>
References: <20180727131849.18488-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Jul 2018 13:19:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 27 Jul 2018 15:18:49 +0200

> Remove prefix 'CONFIG_' from CONFIG_IPV6
> 
> Fixes: ba7d7e2677c0 ("net/rds/Kconfig: RDS should depend on IPV6")
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Oops, applied :)
