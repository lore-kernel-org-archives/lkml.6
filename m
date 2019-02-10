Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA00C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A495E21736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfBJVVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:21:39 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51795 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfBJVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:21:39 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C73EA60003;
        Sun, 10 Feb 2019 21:21:35 +0000 (UTC)
Date:   Sun, 10 Feb 2019 22:21:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ben.dooks@codethink.co.uk,
        ccaione@baylibre.com
Subject: Re: [PATCH v7 1/2] dt-bindings: rtc: add device-tree bindings for
 the Amlogic Meson RTC
Message-ID: <20190210212135.GJ23062@piout.net>
References: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
 <20190209001813.6792-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209001813.6792-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2019 01:18:12+0100, Martin Blumenstingl wrote:
> The 32-bit Amlogic Meson SoCs (Meson6, Meson8, Meson8b and Meson8m2)
> have a built-in RTC block.
> It has the following inputs:
> - an 32.768kHz crystal oscillator
> - an interrupt line
> - a reset line
> - 0.9V voltage input
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [resurrected patches from Ben after 2 years]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/rtc/rtc-meson.txt     | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
