Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1895C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C342133D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfAYGWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:22:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38210 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfAYGWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:22:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2041D1439893F;
        Thu, 24 Jan 2019 22:22:35 -0800 (PST)
Date:   Thu, 24 Jan 2019 22:22:34 -0800 (PST)
Message-Id: <20190124.222234.228200764049877850.davem@davemloft.net>
To:     sashal@kernel.org
Cc:     linux-kernel@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V hv_netvsc commits for 5.0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190123183030.9CFEE21872@mail.kernel.org>
References: <20190123183030.9CFEE21872@mail.kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Jan 2019 22:22:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Levin <sashal@kernel.org>
Date: Wed, 23 Jan 2019 13:30:29 -0500

> Three patches from Haiyang Zhang to fix settings hash key using ethtool,
> and Adrian Vladu's first patch fixing a few spelling mistakes.

Pulled, thanks.
