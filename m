Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E03C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C716121736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfBSAiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:38:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56700 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfBSAiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:38:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A1CF711D424B2;
        Mon, 18 Feb 2019 16:38:10 -0800 (PST)
Date:   Mon, 18 Feb 2019 16:38:10 -0800 (PST)
Message-Id: <20190218.163810.1214895494629813276.davem@davemloft.net>
To:     david0813@gmail.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        mario.limonciello@dell.com, bigeasy@linutronix.de,
        edumazet@google.com, jslaby@suse.cz, f.fainelli@gmail.com,
        david.chen7@dell.com, kai.heng.feng@canonical.com,
        zhongjiang@huawei.com
Subject: Re: [PATCH] r8152: Add support for MAC address pass through on
 RTL8153-BD
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190216091642.21388-1-david0813@gmail.com>
References: <20190216091642.21388-1-david0813@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 16:38:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Chen <david0813@gmail.com>
Date: Sat, 16 Feb 2019 17:16:42 +0800

> From: David Chen <david.chen7@dell.com>
> 
> RTL8153-BD is used in Dell DA300 type-C dongle.
> It should be added to the whitelist of devices to activate MAC address
> pass through.
> 
> Per confirming with Realtek all devices containing RTL8153-BD should
> activate MAC pass through and there won't use pass through bit on efuse
> like in RTL8153-AD.
> 
> Signed-off-by: David Chen <david.chen7@dell.com>

Applied, thanks.
