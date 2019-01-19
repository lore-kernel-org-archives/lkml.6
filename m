Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730CC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5178D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfASSEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:04:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56570 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfASSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:04:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8081314BC61D8;
        Sat, 19 Jan 2019 10:04:47 -0800 (PST)
Date:   Sat, 19 Jan 2019 10:04:46 -0800 (PST)
Message-Id: <20190119.100446.2276221483557449324.davem@davemloft.net>
To:     camelia.groza@nxp.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        oss@buserror.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: phy driver features are mandatory
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1547727756-18854-1-git-send-email-camelia.groza@nxp.com>
References: <1547727756-18854-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 19 Jan 2019 10:04:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camelia Groza <camelia.groza@nxp.com>
Date: Thu, 17 Jan 2019 14:22:36 +0200

> Since phy driver features became a link_mode bitmap, phy drivers that
> don't have a list of features configured will cause the kernel to crash
> when probed.
> 
> Prevent the phy driver from registering if the features field is missing.
> 
> Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
> Reported-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> ---
> v2: Print the name of the driver that has missing features.
> 
> This patch should be merged to 4.20 stable.

Applied and queued up for -stable.
