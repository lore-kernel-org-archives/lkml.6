Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174CEC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D22218C0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D22218C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeGGIoE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:44:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37167 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeGGIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:44:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so10272100edq.4;
        Sat, 07 Jul 2018 01:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1YkurZWi/LT0DDANM59t6VNyir6/ecy7XNVGN8JYjFE=;
        b=XRgw3zAMhMBpsYlEcNJscKWxY7Mkh3lq6+r6IbTjuj0uA2C3mGaI7lRX9Wa9Sick8l
         HDWiuafWnBkfcIbbo6R1jXHD5EjTgsMA6+wYtrzdNupKte2hGv7Tn42ahO9k/M9iL4vZ
         Mha1fHHHYluM+S58DErjg3qW75XIDCLe3AnMx8zPiQMLKFOcXUVl+8Ntl/4TyNtNvDFM
         Pvv5mMIY44O7BHrauGYdf2Yaa8YaOnkrLtw95aSiyo5I4WrPILi0hsQa9TEL8eZngZBu
         gDAx3iig9XHqrEk381qKNEIgebYA22hxqjZq+KDfQ4VPY1hhArEJfmd4SrzoycSAxde9
         eIYA==
X-Gm-Message-State: APt69E1GU6fPGLrRFo5vGVxUnOnooEG9lTv5ITf3eISzAynVH5nXCPBG
        JcdUKV3nVDCtg+E0qDpd1xw=
X-Google-Smtp-Source: AAOMgpcs9+3iBFCs1d0V3HwOf2gj6ytEt6eBjo5QODdQnSBKzSzFjAiFrMoeWm+/SN6BC6xYtFwZ/A==
X-Received: by 2002:a50:a725:: with SMTP id h34-v6mr14210369edc.297.1530953040426;
        Sat, 07 Jul 2018 01:44:00 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id h4-v6sm1431927edq.89.2018.07.07.01.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 01:43:59 -0700 (PDT)
Date:   Sat, 7 Jul 2018 10:43:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v3 2/9] ARM: dts: s5pv210: Add initial DTS for Samsung
 Aries based phones
Message-ID: <20180707084358.4o53vtwycaul7vcu@kozik-lap>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530901970-14972-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:32:43PM +0200, Paweł Chmiel wrote:
> This DTS file have initial support Samsung Aries based phones.
> Initial version have support for:
> - sdcard
> - internal memory (present only on non 4g variant)
> - max8998 pmic and rtc
> - max17040 fuel gauge
> - gpio keys
> - fimd (no panel driver yet)
> - usb (peripherial mode)
> - wifi
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>   - Restored pinctrl nodes order
>   - Correct order of nodes
> 
> Changes from v1:
>   - Removed duplicated and unneeded headers
>   - Corrected node names
>   - Added missing spaces
>   - Removed unneeded pinctrl and sorted entries
>   - Set correct interrupt type for max8998 pmic
>   - Add missing regulators
> ---
> ---

I applied this and 3/9 but then dtc complained about warnings
make dtbs W=1:

arch/arm/boot/dts/s5pv210-galaxys.dtb: Warning (unit_address_vs_reg): /soc/fimd@f8000000/display-timings/timing@0: node has a unit name, but no reg property
arch/arm/boot/dts/s5pv210-galaxys.dtb: Warning (avoid_unnecessary_addr_size): /soc/fimd@f8000000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

These should be fixed (unless such warning come from following bindings,
e.g. like in case of ports for Exynos HDMI nodes).

Please, always run dtbs W=1 for DTS patches, check with sparse for
regular code and checkpatch for everything.  Checks with smatch
and coccinelle are also appreciated (although coccinelle is run by
kbuild bot).

Best regards,
Krzysztof

