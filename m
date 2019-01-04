Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C592C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531D621872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfADUyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:54:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48616 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfADUyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:54:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ABB2C14C5C7FE;
        Fri,  4 Jan 2019 12:54:34 -0800 (PST)
Date:   Fri, 04 Jan 2019 12:54:34 -0800 (PST)
Message-Id: <20190104.125434.2239560197580981867.davem@davemloft.net>
To:     ap420073@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, ast@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH net 0/4] net: bpfilter: fix two bugs in bpfilter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181230163045.20813-1-ap420073@gmail.com>
References: <20181230163045.20813-1-ap420073@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Jan 2019 12:54:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 31 Dec 2018 01:30:45 +0900

> This patches fix two bugs in the bpfilter_umh which are related in
> iptables command.
 ...

I am still thinking about these patches, sorry for taking so long to
give a response.

Thank you.
