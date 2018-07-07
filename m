Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B92C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C2820C0F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C2820C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeGGKdm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:33:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38791 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbeGGKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:33:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so10392191edt.5;
        Sat, 07 Jul 2018 03:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n4PJPZ2xqfhU/aSJ02HpoYr26AMrnY1zUOUwGaNr+Uw=;
        b=eHhXai83n9TQfSqKtrmXJtF0UU1HlIdZ0Y1oYIehNK4d4kUAf1uiLB8N4iIKSV6gWA
         PhzljnCx+1tuX/LiInXbKab+eiLDtonN1oenMGYfrthV2hqAYbQ5jGcUUgdLdAmVthMx
         5O9sD/oOTDB+EV/ndWQ98GoJBX7zGsVi4Jn80D/qapHC1raevCkeKNQ+zxvMMKRjcTVI
         dYDgY9P6P4aKLA/OtSj1pn3mpQ9VOFyqPbROzhf3WhX+yinuPWOF2oydzLfrrkXm/Gj5
         nPxlCHUAfRd5sEHseVVE8bN5Prf23jsoqFI2M8DvRpMrb52WwCYg3qAnyqs/8qyjHFon
         EZ1w==
X-Gm-Message-State: APt69E0zaBn6DWECLr7gd0gHp/d4KtwtZitmwx4/2D/GMT83LBrtex2I
        Dp9jO6lGH4UDzGbvK9ID+TY=
X-Google-Smtp-Source: AAOMgpfGTcZcpCByxejzOAL/y7SI+C6eaJcpnyMA2q9ozYofJlLyncxBZ3dfhruEmIzcWK2E8Mylgw==
X-Received: by 2002:a50:b1bc:: with SMTP id m57-v6mr14759720edd.3.1530959617195;
        Sat, 07 Jul 2018 03:33:37 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id d7-v6sm4324911edi.79.2018.07.07.03.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 03:33:36 -0700 (PDT)
Date:   Sat, 7 Jul 2018 12:33:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 3/5] ARM: dts: s5pv210: Add initial DTS for SGH-T959P
 phone
Message-ID: <20180707103334.rnvgdnfxvoogudrg@kozik-lap>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530958183-10956-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530958183-10956-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 12:09:41PM +0200, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> This DTS file have initial support Samsung SGH-T959P phone,
> also known as Samsung Galaxy S 4G or fascinate4g.
> It belongs to Samsung Aries devices family.
> Initial version have support for:
> - sdcard
> - max8998 pmic and rtc
> - max17040 fuel gauge
> - gpio keys
> - fimd (no panel driver yet)
> - usb (peripherial mode)
> - wifi
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> 
> Changes from v1:
>   - Added missing commit msg
>   - Removed duplicated and unneeded headers
>   - Added stdout-path
>   - Added information why we hardcode bootargs
> ---
> ---
>  arch/arm/boot/dts/Makefile                |  1 +
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 45 +++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

