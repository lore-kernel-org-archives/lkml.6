Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ADAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A85F20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A85F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbeGWLlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:41:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51630 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbeGWLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:41:36 -0400
Received: from 095-097-149-005.static.chello.nl ([95.97.149.5] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fhYGv-00083O-U9; Mon, 23 Jul 2018 12:40:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH 1/5] arm64: defconfig: Enable sound support for Samsung Chromebook Plus.
Date:   Mon, 23 Jul 2018 12:40:56 +0200
Message-ID: <1845030.GmhzmUT5kH@phil>
In-Reply-To: <20180717160610.26501-1-enric.balletbo@collabora.com>
References: <20180717160610.26501-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. Juli 2018, 18:06:06 CEST schrieb Enric Balletbo i Serra:
> Enable the Rockchip sound driver with MAX98357A/RT5514/DA7219 codecs
> needed for the Samsung Chromebook Plus.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied all 5 for 4.19.

As Olof requested less granularity for defconfig changes, I squashed
all of them into one patch enabling Chromebook Plus peripherals.


Thanks
Heiko


