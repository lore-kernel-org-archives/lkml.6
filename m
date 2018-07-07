Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7AEC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F26F20C0F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F26F20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeGGK3m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:29:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35866 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeGGK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:29:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so10387298eds.3;
        Sat, 07 Jul 2018 03:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ljtKpacarH26N9yrOev4I9ZHN6bTlhVVJalVHVCd2MU=;
        b=tAGF4aOG/eNTALJkbDfjtIR4Dy/S10/vaGj35XK2q/spuVLAaYDKWCKUJeFKD7IBCb
         FQS3gvinr/ZTrIQ9RG3jpf0Mu08hz4YXAv1RmVIm46tftRUmOfW0/VRrC5pLY/RFj4/Z
         rzNZT3kpiAZou6hURIx+8Df80eqvzE00/K+SwYYxtsTkiJku0FoGCtbSV22r3y5xzjh8
         FJ1vgj74QPvono+NzMtA4VCajySKntpgcnKVx/hvXnP00HKdq4ETm267jEwOGoZeREYk
         f0/0UccHwrhCmvS8kZuVRWj5eNiS2nc5vfgk+hrKkwb9GOsdy12dPomHpxwjJ8R4KRFy
         j7VQ==
X-Gm-Message-State: APt69E2e/ItynxQW/KF2ItGrxC+oiOFdO2/qf3Kt1knNEZMatGkKVCFS
        lvcC6SIMCGJ9DkZZG3WD9UzNtsXq
X-Google-Smtp-Source: AAOMgpd1XYMcofiyBcTvXQxyn/XAkSAFyDXcZdkIJoXS2wrlfcetqxpTr2dMZrx/ZpOc3JoFwtqs3g==
X-Received: by 2002:aa7:d40a:: with SMTP id z10-v6mr14383017edq.203.1530959378444;
        Sat, 07 Jul 2018 03:29:38 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id m50-v6sm9526314edc.94.2018.07.07.03.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 03:29:37 -0700 (PDT)
Date:   Sat, 7 Jul 2018 12:29:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 1/5] ARM: dts: s5pv210: Add initial DTS for Samsung
 Aries based phones
Message-ID: <20180707102936.eg5htvnx5sikgdwq@kozik-lap>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530958183-10956-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530958183-10956-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 12:09:39PM +0200, Paweł Chmiel wrote:
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
> Changes from v3:
>   - Fix dts warnings
> 
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

Thanks, applied.

Best regards,
Krzysztof

