Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054042173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfBZRJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:09:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57216 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBZRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:09:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1791514F1DCCE;
        Tue, 26 Feb 2019 09:09:26 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:09:25 -0800 (PST)
Message-Id: <20190226.090925.519127791573392596.davem@davemloft.net>
To:     Nicolas.Ferre@microchip.com
Cc:     f.fainelli@gmail.com, pthombar@cadence.com, netdev@vger.kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
        rafalc@cadence.com, piotrs@cadence.com, jank@cadence.com,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 1/3] net: ethernet: add support for PCS and 2.5G speed
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a0f7be10-ff9b-c11c-fde9-30876940d719@microchip.com>
References: <CO2PR07MB2469FCDFEE81BE4D3ECE9C92C17A0@CO2PR07MB2469.namprd07.prod.outlook.com>
        <65c93555-f0d2-1139-a4fd-5c6a80acd9bf@gmail.com>
        <a0f7be10-ff9b-c11c-fde9-30876940d719@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Feb 2019 09:09:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Nicolas.Ferre@microchip.com>
Date: Tue, 26 Feb 2019 09:23:04 +0000

> This patch series seem pretty intrusive, so I would like that you wait 
> for my explicit ACK before applying even next versions of it.

Ok.
