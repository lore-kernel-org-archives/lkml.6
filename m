Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A684C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ADC208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7ADC208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406815AbeHATMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:12:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49806 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406738AbeHATMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:12:09 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A8916100A39A0;
        Wed,  1 Aug 2018 09:50:18 -0700 (PDT)
Date:   Wed, 01 Aug 2018 09:50:17 -0700 (PDT)
Message-Id: <20180801.095017.1689289308274863542.davem@davemloft.net>
To:     jdmason@kudzu.us
Cc:     helgaas@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: change Exar/Neterion menu items to be
 alphabetical
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180731155619.16310-1-jdmason@kudzu.us>
References: <20180731155619.16310-1-jdmason@kudzu.us>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 09:50:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 31 Jul 2018 11:56:19 -0400

> Neterion was standalone for several years, then acquired by Exar and
> shutdown in 11 months without ever making any new Exar branded adapters.
> Users would probably think of them as Neterion and not Exar (as there
> have been no follow-on adapters and the vast majority ever sold were
> under the Neterion name).
> 
> 6c541b4595a2 ("net: ethernet: Sort Kconfig sourcing alphabetically")
> sorted Kconfig sourcing based on directory names, but in a couple cases,
> the menu item text is quite different from the directory name and is not
> sorted correctly:
> 
>   drivers/net/ethernet/neterion/Kconfig    => "Exar devices"
> 
> To address that and clear up any confusion about the name, "Exar" was
> changed to "Neterion (Exar)" and the relevant entries in the Makefile
> and Kconfig were reordered to match the alphabetical organization.
> 
> Inspired-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jon Mason <jdmason@kudzu.us>

Applied.
