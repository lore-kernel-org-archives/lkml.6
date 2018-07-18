Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F552075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F552075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbeGRV1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:27:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43294 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeGRV1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:27:39 -0400
Received: from localhost (179-64-212-66.spl.org [66.212.64.179])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 324851479C5F2;
        Wed, 18 Jul 2018 13:48:02 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:48:01 +0900 (KST)
Message-Id: <20180719.054801.2301719511482785772.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     aleksey.makarov@cavium.com, rad@semihalf.com,
        felix.manlunas@cavium.com, sgoutham@cavium.com,
        vijaya.guvva@cavium.com, alexander.sverdlin@nokia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: cavium: add missing PCI dependencies
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180717134756.3447762-1-arnd@arndb.de>
References: <20180717134756.3447762-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 13:48:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Jul 2018 15:46:34 +0200

> While some of the cavium drivers don't require PCI support, most
> others do, as shown by these build failures:
 ...
> This adds back the minimum set of dependencies to get everything to
> build cleanly again, but leaving the ones that build cleanly.
> 
> Fixes: 7e2bc7fb65d5 ("net: cavium: Drop dependency of NET_VENDOR_CAVIUM on PCI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
