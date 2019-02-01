Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA90121726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfBASRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:17:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47588 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBASRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:17:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 48C9E14283692;
        Fri,  1 Feb 2019 10:17:15 -0800 (PST)
Date:   Fri, 01 Feb 2019 10:17:14 -0800 (PST)
Message-Id: <20190201.101714.344392305120692709.davem@davemloft.net>
To:     T.Rajasingh@landisgyr.com
Cc:     alexander.onnasch@landisgyr.com, andrew@lunn.ch,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] phy: Micrel KSZ8061: link failure after cable
 connect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190201104836.21095-1-T.Rajasingh@landisgyr.com>
References: <20190201104836.21095-1-T.Rajasingh@landisgyr.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 01 Feb 2019 10:17:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
Date: Fri,  1 Feb 2019 16:18:32 +0530

> With Micrel KSZ8061 PHY, the link may occasionally not come up after
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
> sheet 80000688A.pdf describes the problem and possible workarounds in
> detail, see below.
> The patch implements workaround 1, which permanently fixes the issue.

This does not apply cleanly to the current 'net' tree, and also there is not
enough context in the second hunk of the patch for me to safely fix it up
for you as I really can't tell exactly which PHY device entry the change
goes into.

So please respin this upon a clean net tree, thanks.
