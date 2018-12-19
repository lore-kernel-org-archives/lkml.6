Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E0721871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeLSFzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:55:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49500 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSFzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:55:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2057A14B9B76F;
        Tue, 18 Dec 2018 21:55:46 -0800 (PST)
Date:   Tue, 18 Dec 2018 21:55:45 -0800 (PST)
Message-Id: <20181218.215545.1657190540227341803.davem@davemloft.net>
To:     sukumarg1973@gmail.com
Cc:     liuhangbin@gmail.com, karn@ka9q.net, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: hard-coded limit on unresolved multicast route cache in
 ipv4/ipmr.c causes slow, unreliable creation of multicast routes on busy
 networks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CADiZnkTm3UMdZ+ivPXFeTJS+_2ZaiQh7D8wWnsw0BNGfxa0C4w@mail.gmail.com>
References: <CADiZnkSy=rFq5xLs6RcgJDihQ1Vwo2WBBY9Fi_5jOHr8XupukQ@mail.gmail.com>
        <20181204065100.GT24677@leo.usersys.redhat.com>
        <CADiZnkTm3UMdZ+ivPXFeTJS+_2ZaiQh7D8wWnsw0BNGfxa0C4w@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 21:55:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sukumar Gopalakrishnan <sukumarg1973@gmail.com>
Date: Wed, 19 Dec 2018 10:57:02 +0530

> Hi David,
> 
>   There are two patch for this issue:
>    1) Your changes which removes cache_resolve_queue_len
>     2) Hangbin's changes which make cache_resolve_queue_len configurable.
> 
> Which one will be chosen for this issue ?

I do plan to look into this, sorry for taking so long.

Right now I am overwhelmed preparing for the next merge window and
synchronizing with other developers for that.

Please be patient.
