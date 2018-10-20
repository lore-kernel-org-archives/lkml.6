Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03DEECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DC021486
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DC021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJTIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:10:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51342 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeJTIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:10:59 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0F64A12107044;
        Fri, 19 Oct 2018 17:02:41 -0700 (PDT)
Date:   Fri, 19 Oct 2018 17:02:40 -0700 (PDT)
Message-Id: <20181019.170240.1751894482425967587.davem@davemloft.net>
To:     yuiko.oshino@microchip.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, m.felsch@pengutronix.de,
        Markus.Niebel@tqs.de, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v3 net-next 0/2] Add support for Microchip Technology
 KSZ9131 10/100/1000 Ethernet PHY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
References: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Oct 2018 17:02:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuiko Oshino <yuiko.oshino@microchip.com>
Date: Thu, 18 Oct 2018 15:06:00 -0400

> This is the initial driver for Microchip KSZ9131 10/100/1000 Ethernet PHY
> 
> v3:
> - KSZ9131 uses picosecond units for values of devicetree properties.
> - rewrite micrel.c and micrel-ksz90x1.txt to use the picosecond values.
> v2:
> - Creating a series from two related patches.

Series applied.
