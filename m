Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9588C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7570120851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7570120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLCIfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:35:38 -0500
Received: from mail1.skidata.com ([91.230.2.99]:56542 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbeLCIfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:35:37 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 03:35:35 EST
X-IronPort-AV: E=Sophos;i="5.56,309,1539640800"; 
   d="scan'208";a="13742116"
Subject: Re: [PATCH v2 0/7] Input: sx8654 - reset-gpio, sx865[056] support,
 etc.
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
From:   Richard Leitner <richard.leitner@skidata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=richard.leitner@skidata.com; prefer-encrypt=mutual; keydata=
 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
 P3I6bcPJefUstj65yFQnTw==
Message-ID: <1c5c06fd-35aa-2e6c-d851-3f675dc87a11@skidata.com>
Date:   Mon, 3 Dec 2018 09:25:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
another friendly reminder for this patchset...

Any comments/objections?

regards;Richard.L

On 17.10.18 14:51, Richard Leitner wrote:
> Add reset-gpio, sx8654[056] and common of_touchscreen functions support
> for the sx8654 driver.
> 
> Changes v2:
> 	- use devm_gpiod_get_optional in probe instead of in #ifdef CONFIG_OF
> 	- convert flags to BIT() in a separate patch
> 	- replace hrtimer with "regular" timer
> 	- use of_device_get_match_data instead of of_match_device
> 	- add driver data to i2c_device_id table for non-DT fallback
> 	- fix sequence of common touchscreen initialization
> 	- div. minor stlye changes
> 
> Richard Leitner (8):
>   dt-bindings: input: touchscreen: sx8654: add reset-gpio property
>   Input: sx8654 - add reset-gpio support
>   dt-bindings: input: touchscreen: sx8654: add compatible models
>   Input: sx8654 - add sx8655 and sx8656 to compatibles
>   dt-bindings: input: touchscreen: sx8654: add sx8650 to comatibles
>   Input: sx8654 - add sx8650 support
>   Input: sx8654 - use common of_touchscreen functions
>   Input: sx8654 - convert #defined flags to BIT(x)
> 
>  .../bindings/input/touchscreen/sx8654.txt          |  10 +-
>  drivers/input/touchscreen/sx8654.c                 | 245 ++++++++++++++++++---
>  2 files changed, 229 insertions(+), 26 deletions(-)
> 
