Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC9CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B6D2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfALCLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:11:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39668 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfALCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:11:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B4E014CCB499;
        Fri, 11 Jan 2019 18:11:05 -0800 (PST)
Date:   Fri, 11 Jan 2019 18:11:04 -0800 (PST)
Message-Id: <20190111.181104.1615164226881752852.davem@davemloft.net>
To:     ap420073@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, ast@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH net v4 0/4] net: bpfilter: fix two bugs in bpfilter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190108172342.11917-1-ap420073@gmail.com>
References: <20190108172342.11917-1-ap420073@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 11 Jan 2019 18:11:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>
Date: Wed,  9 Jan 2019 02:23:42 +0900

> This patches fix two bugs in the bpfilter_umh which are related in
> iptables command.
 ...

Series applied, thank you.
