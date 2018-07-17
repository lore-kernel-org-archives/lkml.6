Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76859ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9F92146F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9F92146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeGQIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:37:25 -0400
Received: from muru.com ([72.249.23.125]:51846 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeGQIhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:37:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D6D9D8153;
        Tue, 17 Jul 2018 08:09:13 +0000 (UTC)
Date:   Tue, 17 Jul 2018 01:06:00 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Koen Kooi <koen@dominion.thruhere.net>
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Message-ID: <20180717080600.GF99251@atomide.com>
References: <1531810311-29915-1-git-send-email-koen@dominion.thruhere.net>
 <1531810311-29915-3-git-send-email-koen@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531810311-29915-3-git-send-email-koen@dominion.thruhere.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [180717 06:55]:
> The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
> but with the following differences:
> 
>  * Gigabit capable PHY
>  * Extra USB hub, optional i2c control
>  * lps3331ap barometer connected over i2c
>  * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
>  * 1GiB DDR3 RAM
>  * RTL8723 Wifi/Bluetooth connected over USB

Applying into omap-for-v4.19/dt thanks

Tony
