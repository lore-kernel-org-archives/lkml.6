Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE28C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1FB2190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfBLStT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:49:19 -0500
Received: from muru.com ([72.249.23.125]:38290 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbfBLStS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:49:18 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 07A07803A;
        Tue, 12 Feb 2019 18:49:27 +0000 (UTC)
Date:   Tue, 12 Feb 2019 10:49:15 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am335x: Add support for Bosch Guardian
Message-ID: <20190212184915.GN5720@atomide.com>
References: <20190211122727.5582-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211122727.5582-1-martyn.welch@collabora.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Martyn Welch <martyn.welch@collabora.com> [190211 04:27]:
> The Bosch Guardian is a TI am335x based device.
> 
> It's hardware specifications are as follows:
> 
>  * 256 MB DDR3 memory
>  * 512 MB NAND Flash
>  * USB OTG
>  * RS232
>  * MicroSD external storage
>  * LCD Display interface

Thanks applying into omap-for-v5.1/dt.

Do you have some link for this device for more
information?

> +/include/ "tps65217.dtsi"

I'll update this to use #include "tps65217.dtsi"
while applying.

Regards,

Tony
