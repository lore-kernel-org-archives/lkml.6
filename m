Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C30C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6CE2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfA1UL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:11:59 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44371 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1UL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:11:59 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EDF851C0005;
        Mon, 28 Jan 2019 20:11:53 +0000 (UTC)
Date:   Mon, 28 Jan 2019 21:11:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        a.zummo@towertech.it, robh+dt@kernel.org, paul.burton@mips.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Re: [PATCH 2/3] Dt-bindings: RTC: Add X1000 RTC bindings.
Message-ID: <20190128201153.GC18309@piout.net>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
 <1548696599-53639-3-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548696599-53639-3-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2019 01:29:58+0800, Zhou Yanjie wrote:
> Add the RTC bindings for the X1000 Soc from Ingenic.
> 

The subject is not properly capitalized and this patch should either
come first or be squashed in the previous one.

> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> index 41c7ae1..7ce0018 100644
> --- a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - compatible: One of:
>    - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
>    - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
> +  - "ingenic,x1000-rtc" - for use with the X1000 SoC
>  - reg: Address range of rtc register set
>  - interrupts: IRQ number for the alarm interrupt
>  - clocks: phandle to the "rtc" clock
> -- 
> 2.7.4
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
