Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2040FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603A6208A4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603A6208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbeG3SV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:21:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbeG3SVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:21:25 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6528613F4E720;
        Mon, 30 Jul 2018 09:45:35 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:45:34 -0700 (PDT)
Message-Id: <20180730.094534.351189879060038512.davem@davemloft.net>
To:     alexander.onnasch@landisgyr.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532959287-360-1-git-send-email-alexander.onnasch@landisgyr.com>
References: <1532959287-360-1-git-send-email-alexander.onnasch@landisgyr.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 09:45:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Date: Mon, 30 Jul 2018 16:01:27 +0200

> With Micrel KSZ8061 PHY, the link may occasionally not come up after
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
> sheet 80000688A.pdf describes the problem and possible workarounds in
> detail, see below.
> The patch implements workaround 1, which permanently fixes the issue.
 ...
> Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>

This patch does not apply cleanly to any of my neworking trees.
