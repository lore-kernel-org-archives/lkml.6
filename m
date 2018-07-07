Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3FAC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD22086A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DD22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753687AbeGGIjA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:39:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33047 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeGGIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:38:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so6583377edr.0;
        Sat, 07 Jul 2018 01:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HJ5zqhV6+xVgnrR2gxA4xoOLIzt7i5SH1p/KAEK5Apo=;
        b=rpN03Wv0izxya5EVrVPhpwG164s0TjovAdp5Zv/NIITBWlitZryKWDTD8PupZxKK/6
         dYc2psAwnEx3z7pHLMHt0IDcQAhGuHjhfX720uHZvvd1dkFXD2iTlM4IemeRgpWN1+dz
         DXR4t+qkpjqLzN9GCUg4JSAg49NzfDOyPe4QqYcw1XFA8DFf3XK8eoAXyHFyXCMiR4lx
         LwwJND+vN9LNgzs01NMKBKPeMc/UXhOIOsT2j0ZoMX1+fmVPjKMmVngwbIalgsGb+pSw
         ujXbqPB69SaMc54OuMuZgkNydD+EOCWOpYj5VzUSNi7UaANQRHUjfcmPZLM6Qvpbd4h8
         mz5g==
X-Gm-Message-State: APt69E2rdyOSl6du4VHuMjG0m6wDO/GyuVfhlfPWJ3KKxoc7B9ntPUfL
        UgEh268xyfKYfxm6/ImhDQU=
X-Google-Smtp-Source: AAOMgpdJb2HTT1rkrXEOBS7xFCFsqWs/KmP7IHeGoAHP4jsutJyRrSspijV/PjMgIHXZSgsu+RNf5Q==
X-Received: by 2002:a50:925c:: with SMTP id j28-v6mr14564544eda.209.1530952736717;
        Sat, 07 Jul 2018 01:38:56 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id n10-v6sm2065671edr.59.2018.07.07.01.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 01:38:56 -0700 (PDT)
Date:   Sat, 7 Jul 2018 10:38:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v3 1/9] ARM: dts: s5pv210: Add missing
 interrupt-controller property to gph2
Message-ID: <20180707083852.sqjfcxyicilwekuv@kozik-lap>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530901970-14972-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:32:42PM +0200, Paweł Chmiel wrote:
> Adds missing interrupt-controller property to gph2 block,
> to silence following warnings during build
>   /soc/pinctrl@e0200000/gph2: Missing interrupt-controller or interrupt-map property
> 
> It's reguired by Samsung aries boards, an S5PV210 based
> Samsung Galaxy S (i9000) and Galaxy S 4G phones, which are added in next patches.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

