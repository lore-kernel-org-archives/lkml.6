Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A7F21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfBTCOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:14:04 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:47324 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTCOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:14:03 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2019 21:14:02 EST
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.224])
        by lucky1.263xmail.com (Postfix) with ESMTP id 773D95A66;
        Wed, 20 Feb 2019 10:06:43 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2315T140013062825728S1550628401673389_;
        Wed, 20 Feb 2019 10:06:42 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b97b291e2684d941d9f3d8b3ab642bdc>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_ARM=3a_dts=3a_rockchip=3a_remove_disabl?=
 =?UTF-8?B?ZS13cCBmcm9tIHJ2MTEwOC1lbGdpbi1yMSBlbW1jIG5vZGXjgJDor7fms6jmhI8=?=
 =?UTF-8?B?77yM6YKu5Lu255SxbGludXgtcm9ja2NoaXAtYm91bmNlcytzaGF3bi5saW49cm9j?=
 =?UTF-8?B?ay1jaGlwcy5jb21AbGlzdHMuaW5mcmFkZWFkLm9yZ+S7o+WPkeOAkQ==?=
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
References: <20190219130317.2817-1-jbx6244@gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a8251244-44e5-0423-16cf-de035a760248@rock-chips.com>
Date:   Wed, 20 Feb 2019 10:06:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190219130317.2817-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/19 21:03, Johan Jonker wrote:
> The mmc.txt didn't explicitly say disable-wp is for SD card slot only,
> but that is what it was designed for in the first place.
> Remove all disable-wp from emmc or sdio controllers.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm/boot/dts/rv1108-elgin-r1.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
> index 1c4507b..b1db924 100644
> --- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
> +++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
> @@ -37,7 +37,6 @@
>   &emmc {
>   	bus-width = <8>;
>   	cap-mmc-highspeed;
> -	disable-wp;

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>   	no-sd;
>   	no-sdio;
>   	non-removable;
> 


