Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C5FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA1E21580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA1E21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeI0G1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:27:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35430 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeI0G1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:27:49 -0400
Received: from localhost (unknown [172.58.43.123])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A4991454DCB8;
        Wed, 26 Sep 2018 17:12:19 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:12:18 -0700 (PDT)
Message-Id: <20180926.171218.1890476375628867560.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
        keescook@chromium.org, akurz@blala.de, hayeswang@realtek.com,
        kai.heng.feng@canonical.com, grundler@chromium.org,
        zhongjiang@huawei.com, bigeasy@linutronix.de, ran.wang_1@nxp.com,
        edumazet@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/7] net: usb: Check for Wake-on-LAN modes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180924205420.31309-1-f.fainelli@gmail.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 17:12:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 24 Sep 2018 13:54:13 -0700

> Most of our USB Ethernet drivers don't seem to be checking properly
> whether the user is supplying a correct Wake-on-LAN mode to enter, so
> the experience as an user could be confusing, since it would generally
> lead to either no wake-up, or the device not being marked for wake-up.
> 
> Please review!

I saw some discussion on patch #3, is there going to be a new version
of this series or should I apply this one?

Thanks.
