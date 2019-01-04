Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76581C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E48921872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfADUuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:50:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48552 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:50:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5DF4F14C5C7F2;
        Fri,  4 Jan 2019 12:50:10 -0800 (PST)
Date:   Fri, 04 Jan 2019 12:50:09 -0800 (PST)
Message-Id: <20190104.125009.597959860502207422.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     hkallweit1@gmail.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: Add support for new Realtek Ethernet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190102064507.32122-1-kai.heng.feng@canonical.com>
References: <20190102064507.32122-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Jan 2019 12:50:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed,  2 Jan 2019 14:45:07 +0800

> There are two new Realtek Ethernet devices which are re-branded r8168h.
> Add the IDs to to support them.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.
