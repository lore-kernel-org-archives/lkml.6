Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E3F24411
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E3F24411
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbeF1FTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:19:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45532 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeF1FTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:19:16 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 80303142CD208;
        Wed, 27 Jun 2018 22:19:11 -0700 (PDT)
Date:   Thu, 28 Jun 2018 14:19:06 +0900 (KST)
Message-Id: <20180628.141906.992117881940997277.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     Allan.Nielsen@microsemi.com, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, thomas.petazzoni@bootlin.com, andrew@lunn.ch,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: mscc: ocelot: add more features
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180626122849.13174-1-alexandre.belloni@bootlin.com>
References: <20180626122849.13174-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Jun 2018 22:19:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 26 Jun 2018 14:28:47 +0200

> Hi,
> 
> This series adds link aggregation and VLAN filtering hardware offload
> support to the ocelot driver.
> 
> PTP support will be sent later.
> 
> changes in v2:
>  - rebased on v4.18-rc1
>  - check for aggregation type and only offload it when type is hash (balance-xor
>    or 802.3ad)

Series applied, thank you.
