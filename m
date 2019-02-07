Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8504C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F57F21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfBGRw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:52:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50040 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGRw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:52:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 10A96146A0A18;
        Thu,  7 Feb 2019 09:52:56 -0800 (PST)
Date:   Thu, 07 Feb 2019 09:52:52 -0800 (PST)
Message-Id: <20190207.095252.2022131747259851934.davem@davemloft.net>
To:     mdf@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hkallweit1@gmail.com, f.fainelli@gmail.com, andrew@lunn.ch,
        moritz@ettus.com
Subject: Re: [PATCH v2 net-next] net: phy: fixed_phy: Fix fixed_phy not
 checking GPIO
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190207054529.2865-1-mdf@kernel.org>
References: <20190207054529.2865-1-mdf@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Feb 2019 09:52:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>
Date: Wed,  6 Feb 2019 21:45:29 -0800

> Fix fixed_phy not checking GPIO if no link_update callback
> is registered.
> 
> In the original version all users registered a link_update
> callback so the issue was masked.
> 
> Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Applied, thank you.
