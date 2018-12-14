Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0586208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeLNWic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:38:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35672 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeLNWib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:38:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2F9D814E09833;
        Fri, 14 Dec 2018 14:38:31 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:38:30 -0800 (PST)
Message-Id: <20181214.143830.893521639436526133.davem@davemloft.net>
To:     mario.limonciello@dell.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, anthony.wong@canonical.com
Subject: Re: [PATCH] r8152: Add support for MAC address pass through on
 RTL8153-BND
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544537774-4370-1-git-send-email-mario.limonciello@dell.com>
References: <1544537774-4370-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 14:38:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@dell.com>
Date: Tue, 11 Dec 2018 08:16:14 -0600

> All previous docks and dongles that have supported this feature use
> the RTL8153-AD chip.
> 
> RTL8153-BND is a new chip that will be used in upcoming Dell type-C docks.
> It should be added to the whitelist of devices to activate MAC address
> pass through.
> 
> Per confirming with Realtek all devices containing RTL8153-BND should
> activate MAC pass through and there won't use pass through bit on efuse
> like in RTL8153-AD.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Applied, thanks.
