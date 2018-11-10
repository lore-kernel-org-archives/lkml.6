Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F39C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 12:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC6E20818
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 12:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC6E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeKJWEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 17:04:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33723 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbeKJWEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 17:04:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5C9F1224DE; Sat, 10 Nov 2018 13:19:18 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 33F3D20510;
        Sat, 10 Nov 2018 13:19:08 +0100 (CET)
Date:   Sat, 10 Nov 2018 13:19:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zoro <long17.cool@163.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Message-ID: <20181110121908.GF29768@piout.net>
References: <1541839433-28811-1-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541839433-28811-1-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/11/2018 16:43:51+0800, zoro wrote:
> Introduce vendor prefix for whwave, Inc.
> for SD3078 rtc device.
> 
> Signed-off-by: zoro <long17.cool@163.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8..3d59d6a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -440,3 +440,4 @@ zidoo	Shenzhen Zidoo Technology Co., Ltd.
>  zii	Zodiac Inflight Innovations
>  zte	ZTE Corp.
>  zyxel	ZyXEL Communications Corp.
> +whwave	Shenzhen whwave Electronics crop

This file must be sorted alphabetically.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
