Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7932FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4617F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617F20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441298AbeKXF41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:56:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:32892 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437213AbeKXF40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:56:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E0C5814EA0E8A;
        Fri, 23 Nov 2018 11:10:52 -0800 (PST)
Date:   Fri, 23 Nov 2018 11:10:52 -0800 (PST)
Message-Id: <20181123.111052.2131567308862328659.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: remove HFB_CTRL access
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542755821-21554-1-git-send-email-opendmb@gmail.com>
References: <1542755821-21554-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 11:10:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Tue, 20 Nov 2018 15:17:01 -0800

> Commit c5a54bbcecec ("net: bcmgenet: abort suspend on error")
> mistakenly introduced register accesses that should not occur
> in bcmgenet_wol_power_up_cfg().
> 
> Fixes: c5a54bbcecec ("net: bcmgenet: abort suspend on error")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Applied.
