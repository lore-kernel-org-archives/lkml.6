Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CCC20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CCC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLCXlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:41:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49998 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeLCXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:41:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 53960133E98F5;
        Mon,  3 Dec 2018 15:41:00 -0800 (PST)
Date:   Mon, 03 Dec 2018 15:40:59 -0800 (PST)
Message-Id: <20181203.154059.2288769104592341753.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     grygorii.strashko@ti.com, nicolas.ferre@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        robh+dt@kernel.org, frowand.list@gmail.com, nsekhar@ti.com,
        khilman@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        bgolaszewski@baylibre.com
Subject: Re: [net-next][PATCH 0/4] davinci_emac: read the MAC address from
 nvmem
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181130082100.6241-1-brgl@bgdev.pl>
References: <20181130082100.6241-1-brgl@bgdev.pl>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Dec 2018 15:41:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 30 Nov 2018 09:20:56 +0100

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series is part of a bigger series that aims at removing the platform
> data structure from the at24 EEPROM driver[1].
> 
> We provide a generalized version of of_get_nvmem_mac_address(), switch the
> only user of the of_ variant to using it, remove the previous
> implementation and use the new routine in the davinci_emac driver.
> 
> [1] https://lkml.org/lkml/2018/11/13/884

This looks good, series applied.
