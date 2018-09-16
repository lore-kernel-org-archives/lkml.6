Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7EFC4161C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7139A2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7139A2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeIQDsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 23:48:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35770 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeIQDsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 23:48:39 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AE3F91420A746;
        Sun, 16 Sep 2018 15:24:12 -0700 (PDT)
Date:   Sun, 16 Sep 2018 15:24:09 -0700 (PDT)
Message-Id: <20180916.152409.82390837199781832.davem@davemloft.net>
To:     neidhard.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, chanho.min@lge.com
Subject: Re: [PATCH] stmmac: fix valid numbers of unicast filter entries
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1536831141-25757-1-git-send-email-neidhard.kim@lge.com>
References: <1536831141-25757-1-git-send-email-neidhard.kim@lge.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Sep 2018 15:24:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jongsung Kim <neidhard.kim@lge.com>
Date: Thu, 13 Sep 2018 18:32:21 +0900

> Synopsys DWC Ethernet MAC can be configured to have 1..32, 64, or
> 128 unicast filter entries. (Table 7-8 MAC Address Registers from
> databook) Fix dwmac1000_validate_ucast_entries() to accept values
> between 1 and 32 in addition.
> 
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>

Applied, thank you.
