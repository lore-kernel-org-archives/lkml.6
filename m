Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E266DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6820837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 23:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B6820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeICD2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 23:28:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35798 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeICD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 23:28:05 -0400
Received: from localhost (168-64-212-66.spl.org [66.212.64.168])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B4AED1262C4F6;
        Sun,  2 Sep 2018 16:10:40 -0700 (PDT)
Date:   Sun, 02 Sep 2018 16:10:40 -0700 (PDT)
Message-Id: <20180902.161040.1009330568454902368.davem@davemloft.net>
To:     mdf@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, moritz.fischer@ettus.com,
        linux-next@vger.kernel.org
Subject: Re: [PATCH net-next] net: nixge: Fix Kconfig warning with OF_MDIO
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180831203054.12132-1-mdf@kernel.org>
References: <20180831203054.12132-1-mdf@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Sep 2018 16:10:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>
Date: Fri, 31 Aug 2018 13:30:54 -0700

> Fix Kconfig warning with OF_MDIO where OF_MDIO was
> selected unconditionally instead of only when
> OF is actually enabled.
> 
> Fixes 7e8d5755be0e ("net: nixge: Add support for 64-bit platforms")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Applied, thanks.
