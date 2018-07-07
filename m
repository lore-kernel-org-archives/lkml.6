Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BEBC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF92720C0F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF92720C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeGGKd2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:33:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45500 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeGGKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:33:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id g15-v6so10384183edr.12;
        Sat, 07 Jul 2018 03:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LnNhqpkG8xiI6rzcYL5rm6e1SaXEoRGWw7AfJO1SET0=;
        b=EkuWjdICUq7oyBDKXjeT9JcJbMix43kOrnZ/OgH+E2bfUOId4DDD17yr2caPzp0sk5
         G1Nd8D+Xd1+PhxYDADeOWjyUrPB0p3oWzpbTO8RMN1ziHeV6hnEfbm1AT31NNdsH3QvX
         Cx5lGH+flegtpMhplvMEtq6ol7vzLFagzL/A8i7+ijh0Dy9ypIM86OPJuB4rK3CnI3B5
         ZOlTNV0gqHSCcLsQKQxbcvAdySzc2SeyOqBcDNRswpJNFionvrt7ALuoFrW7rQwlG6bV
         4LQ9pVZZnqDuLzZ0vhDDR/0wGRnzQkk9jIIatYpQmPxB7lEbs/5IENhXhPNZAMT7s82f
         oDXg==
X-Gm-Message-State: APt69E23lZSaoyBSwp3pGMGeJx3et1qbXlHzD+ffgPx9I6grKPOL8Z57
        VdJYXO+3eVXwCcgQdyu7uqM=
X-Google-Smtp-Source: AAOMgpeWmr7svs+bHuIM3vdQaKVFrjiO2bL+Ghd+TMx6J+jdaHCQ4gBkHE7jcs/YBs8+F+qLjrFOMg==
X-Received: by 2002:a50:e40d:: with SMTP id d13-v6mr1783680edm.263.1530959604455;
        Sat, 07 Jul 2018 03:33:24 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id m50-v6sm9530715edc.94.2018.07.07.03.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 03:33:23 -0700 (PDT)
Date:   Sat, 7 Jul 2018 12:33:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 2/5] ARM: dts: s5pv210: Add initial DTS for Samsung
 Galaxy S phone
Message-ID: <20180707103322.45obxwe5jqtfkgqg@kozik-lap>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530958183-10956-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530958183-10956-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 12:09:40PM +0200, Paweł Chmiel wrote:
> This DTS file have initial support Samsung Galaxy S phone,
> also known as i9000.
> It belongs to Samsung Aries devices family.
> Initial version have support for:
> - sdcard
> - internal memory
> - max8998 pmic and rtc
> - max17040 fuel gauge
> - gpio keys
> - fimd (no panel driver yet)
> - usb (peripherial mode)
> - wifi
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> 
> --
> Changes from v1:
>   - Added missing commit msg
>   - Removed duplicated and unneeded headers
>   - Added stdout-path
>   - Added information why we hardcode bootargs
> ---
> ---
>  arch/arm/boot/dts/Makefile            |  1 +
>  arch/arm/boot/dts/s5pv210-galaxys.dts | 77 +++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

