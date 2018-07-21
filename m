Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D369ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE60820854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE60820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeGUSXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:23:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40884 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeGUSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:23:01 -0400
Received: from localhost (unknown [172.58.43.143])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19A9E1231CA71;
        Sat, 21 Jul 2018 10:29:32 -0700 (PDT)
Date:   Sat, 21 Jul 2018 10:29:31 -0700 (PDT)
Message-Id: <20180721.102931.1584742627477735620.davem@davemloft.net>
To:     jmaxwell37@gmail.com
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: Re: [PATCH V4 net-next 0/3] tcp: improve setsockopt()
 TCP_USER_TIMEOUT accuracy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180719011444.4694-1-jmaxwell37@gmail.com>
References: <20180719011444.4694-1-jmaxwell37@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Jul 2018 10:29:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Thu, 19 Jul 2018 11:14:41 +1000

> The patch was becoming bigger based on feedback therefore I have
> implemented a series of 3 commits instead in V4.
> 
> This series is a continuation based on V3 here and associated feedback:
> 
> https://patchwork.kernel.org/patch/10516195/

Series applied, thanks.
