Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D803C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA84D21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfAVTWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:22:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35130 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAVTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:22:21 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DAA0C14D0CECE;
        Tue, 22 Jan 2019 11:22:20 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:22:20 -0800 (PST)
Message-Id: <20190122.112220.236605234484188045.davem@davemloft.net>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, shannon.nelson@oracle.com,
        yanjun.zhu@oracle.com, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org
Subject: Re: [PATCH] net: sun: cassini: Cleanup license conflict
From:   David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.21.1901181147160.1647@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901181147160.1647@nanos.tec.linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 22 Jan 2019 11:22:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 18 Jan 2019 11:49:58 +0100 (CET)

> The recent addition of SPDX license identifiers to the files in
> drivers/net/ethernet/sun created a licensing conflict.
> 
> The cassini driver files contain a proper license notice:
> 
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
>   * published by the Free Software Foundation; either version 2 of the
>   * License, or (at your option) any later version.
> 
> but the SPDX change added:
> 
>    SPDX-License-Identifier: GPL-2.0
> 
> So the file got tagged GPL v2 only while in fact it is licensed under GPL
> v2 or later.
> 
> It's nice that people care about the SPDX tags, but they need to be more
> careful about it. Not everything under (the) sun belongs to ...
> 
> Fix up the SPDX identifier and remove the boiler plate text as it is
> redundant.
> 
> Fixes: c861ef83d771 ("sun: Add SPDX license tags to Sun network drivers")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Applied.
