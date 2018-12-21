Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552E221920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbeLURCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:02:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48986 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLURCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:02:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5265E147D11D7;
        Fri, 21 Dec 2018 09:02:02 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:02:01 -0800 (PST)
Message-Id: <20181221.090201.51665179504686411.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, manish.chopra@cavium.com, rahul.verma@cavium.com,
        Dept-GELinuxNICDev@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netxen: fix a missing check and an uninitialized
 use
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181221062232.59789-1-kjlu@umn.edu>
References: <20181221062232.59789-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 09:02:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 21 Dec 2018 00:22:32 -0600

> When netxen_rom_fast_read() fails, "bios" is left uninitialized and may
> contain random value, thus should not be used.
> 
> The fix ensures that if netxen_rom_fast_read() fails, we return "-EIO".
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied, thanks.
