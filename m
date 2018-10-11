Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D891C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6273C21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6273C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbeJLAdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:33:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58930 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeJLAdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:33:36 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AEBB112DE5805;
        Thu, 11 Oct 2018 10:05:29 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:05:28 -0700 (PDT)
Message-Id: <20181011.100528.228435113074605120.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com,
        f.fainelli@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v2] net: mscc: allow extracting the FCS into
 the skb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181011071224.28646-1-antoine.tenart@bootlin.com>
References: <20181011071224.28646-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Oct 2018 10:05:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 11 Oct 2018 09:12:24 +0200

> This patch adds support for the NETIF_F_RXFCS feature in the Mscc
> Ethernet driver. This feature is disabled by default and allow a user
> to request the driver not to drop the FCS and to extract it into the skb
> for debugging purposes.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> 
> Since v1:
>   - Rebased on top of the latest net-next.

Applied.
