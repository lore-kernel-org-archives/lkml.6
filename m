Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736BCC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D91208E6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D91208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeGGKdv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:33:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44395 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeGGKdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:33:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id f12-v6so10385641edq.11;
        Sat, 07 Jul 2018 03:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8mwl6Ysw9R5GSs0v4SCY7rkdDIoHG/NfGkpkRVcX+a8=;
        b=d7Cka1hrnyK4wD+D2rnrfYHJJjBHV4GgDK/rmhDzpSRtQguhZenq7YFvQy49/ikAdX
         Mkx60hRXEcQklszyb4vZT79Vf4pr97S72JyRcf6f+BWqFh3PiCg/EyhaY8zNoOqLEJWr
         25YqG05ue5VSiu1sZ+hxZZPS6q9fvTs7qw2n4nJ+bDmsqQSddYza2FWzWpgODs0wBgeX
         oTexv87coBw8nrOeHI0MapRwQORIQl93L79cOMg/jsyP9mXIwQ9jwzKEJeoDxcNanCI5
         rqutXwqt2BGbNq/oyhJUWU9p9t/wWcLqh6rJGPLF/G8C7Vj0KNvzndOK+shkj2UDzVis
         hh4g==
X-Gm-Message-State: APt69E0WQpF3zj+eqWvnNa6jQ7nVOctEvAiBuvk6ukjg6TZ2hxe3LKJp
        PMSbTThlVlyQwmXtJ58lB1o=
X-Google-Smtp-Source: AAOMgpezU1qcf5xkwCo0SrUGK6ZZzXAPJOOhzfaP3V7Hcn4Cbfo0xYpeT3emQ2JDNL13bIEaEZUdsA==
X-Received: by 2002:a50:bec2:: with SMTP id e2-v6mr14488180edk.283.1530959628254;
        Sat, 07 Jul 2018 03:33:48 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id n10-v6sm2220682edr.59.2018.07.07.03.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 03:33:47 -0700 (PDT)
Date:   Sat, 7 Jul 2018 12:33:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 4/5] dt-bindings: samsung: Document bindings for
 Samsung aries boards
Message-ID: <20180707103345.vzx2x3sqmfcet3fw@kozik-lap>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530958183-10956-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530958183-10956-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 12:09:42PM +0200, Paweł Chmiel wrote:
> Document the binding for Samsung Galaxy S (i9000) phone
> and whole Samsung Aries devices family (based on S5PV210).
> 
> Also because this is first not Exynos-based devices, document this information
> at beginning of file.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> --
> Changes from v2:
>   - Squashed with patch which was documenting existence
>     of non Exynos-based boards
>   - Added reviewed-by
> 
> Changes from v1:
>   - Added missing commit msg.
> --
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof

