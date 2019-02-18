Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90354217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfBRUDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:03:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53630 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:03:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B55B12DE65FA;
        Mon, 18 Feb 2019 12:03:38 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:03:37 -0800 (PST)
Message-Id: <20190218.120337.1294324245757959219.davem@davemloft.net>
To:     david0813@gmail.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        mario.limonciello@dell.com, bigeasy@linutronix.de,
        edumazet@google.com, jslaby@suse.cz, f.fainelli@gmail.com,
        david.chen7@dell.com, kai.heng.feng@canonical.com,
        zhongjiang@huawei.com
Subject: Re: [PATCH 2/2] RTL8153-BD is used in Dell DA300 type-C dongle. It
 should be added to the whitelist of devices to activate MAC address pass
 through.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190218034817.7515-1-david0813@gmail.com>
References: <20190218034817.7515-1-david0813@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 12:03:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Where is patch #1?
