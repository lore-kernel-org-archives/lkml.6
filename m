Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE41C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850EE223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850EE223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbeKMBnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:43:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51430 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeKMBnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:43:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B113B207CF; Mon, 12 Nov 2018 16:49:19 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8167E20701;
        Mon, 12 Nov 2018 16:49:19 +0100 (CET)
Date:   Mon, 12 Nov 2018 16:49:19 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zoro <long17.cool@163.com>
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: rtc: sd3078: add device tree
 documentation
Message-ID: <20181112154919.GB26341@piout.net>
References: <1542001514-8167-1-git-send-email-long17.cool@163.com>
 <1542001514-8167-3-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542001514-8167-3-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch should come as 2/4 (BTW, I never got 4/4)

On 12/11/2018 13:45:14+0800, zoro wrote:
> The devicetree documentation for the SD3078 device tree
> binding is added with a short example.
> 
> Signed-off-by: zoro <long17.cool@163.com>
> ---
>  .../devicetree/bindings/rtc/rtc-sd3078.txt         |   15 +++++++++++++++
>  MAINTAINERS                                        |    1 +
>  2 files changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
> new file mode 100644
> index 0000000..9b45c8e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
> @@ -0,0 +1,15 @@
> +SD3078 Real Time Clock
> +============================
> +
> +Required properties:
> +- compatible: Should contain "whwave,sd3078".
> +- reg: I2C address for chip.
> +
> +Example:
> +
> +sd3078: sd3078@32 {
> +       compatible = "whwave,sd3078";
> +       reg = <0x32>;
> +};
> +
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 002fcd7..50c038d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16130,6 +16130,7 @@ M:	Zoro Li <long17.cool@163.com>
>  L:	linux-rtc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/rtc/rtc-sd3078.c
> +F:	Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
>  

There is no need to list this file here if it is only done to silence
checkpatch.

>  WIIMOTE HID DRIVER
>  M:	David Herrmann <dh.herrmann@googlemail.com>
> -- 
> 1.7.9.5
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
