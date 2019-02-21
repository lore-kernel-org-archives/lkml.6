Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E6CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399322089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfBUASg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:18:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfBUASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:18:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B9E6A126736E9;
        Wed, 20 Feb 2019 16:18:34 -0800 (PST)
Date:   Wed, 20 Feb 2019 16:18:31 -0800 (PST)
Message-Id: <20190220.161831.2067856031892978.davem@davemloft.net>
To:     tony@atomide.com
Cc:     grygorii.strashko@ti.com, kishon@ti.com, robh+dt@kernel.org,
        netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220210127.GU15711@atomide.com>
References: <20190220203326.GT15711@atomide.com>
        <20190220.124155.2226787912266109280.davem@davemloft.net>
        <20190220210127.GU15711@atomide.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Feb 2019 16:18:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Feb 2019 13:01:27 -0800

> What I can do is set up a separate branch with just this
> patch on top of the dts changes that the arm-soc guys can
> then merge towards the end of the merge cycle. If that
> works for you, let me know and I'll do it.

Yes, it does work for me.

Thanks.
