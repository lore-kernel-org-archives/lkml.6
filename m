Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34876C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E821871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfADVAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:00:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48728 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:00:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 051941444D2D3;
        Fri,  4 Jan 2019 13:00:38 -0800 (PST)
Date:   Fri, 04 Jan 2019 13:00:38 -0800 (PST)
Message-Id: <20190104.130038.1781862477531783334.davem@davemloft.net>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tristram.Ha@microchip.com
Subject: Re: [PATCH] net: macb: remove unnecessary code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546527547-10262-1-git-send-email-claudiu.beznea@microchip.com>
References: <1546527547-10262-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Jan 2019 13:00:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Claudiu.Beznea@microchip.com>
Date: Thu, 3 Jan 2019 14:59:35 +0000

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Commit 653e92a9175e ("net: macb: add support for padding and fcs
> computation") introduced a bug fixed by commit 899ecaedd155 ("net:
> ethernet: cadence: fix socket buffer corruption problem"). Code removed
> in this patch is not reachable at all so remove it.
> 
> Fixes: 653e92a9175e ("net: macb: add support for padding and fcs computation")
> Cc: Tristram Ha <Tristram.Ha@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied.
