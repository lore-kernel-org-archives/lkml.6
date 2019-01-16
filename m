Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37DEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989DA20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfAPG2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:28:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34890 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbfAPG2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:28:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 021B814AD1251;
        Tue, 15 Jan 2019 22:28:52 -0800 (PST)
Date:   Tue, 15 Jan 2019 22:28:52 -0800 (PST)
Message-Id: <20190115.222852.1157339860050414390.davem@davemloft.net>
To:     timotej.lazar@araneo.si
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        khilman@baylibre.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: meson-gxl: Use the genphy_soft_reset
 callback
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190113002255.15310-1-timotej.lazar@araneo.si>
References: <20190113002255.15310-1-timotej.lazar@araneo.si>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Jan 2019 22:28:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timotej Lazar <timotej.lazar@araneo.si>
Date: Sun, 13 Jan 2019 01:22:55 +0100

> Since the referenced commit, Ethernet fails to come up at boot on the
> board meson-gxl-s905x-libretech-cc. Fix this by re-enabling the
> genphy_soft_reset callback for the Amlogic Meson GXL PHY driver.
> 
> Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
> Signed-off-by: Timotej Lazar <timotej.lazar@araneo.si>

Applied and queued up for -stable.
