Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0CC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31EA21566
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31EA21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeGGKeA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:34:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35725 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeGGKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:33:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so10389224edi.2;
        Sat, 07 Jul 2018 03:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7Mg3pXNT9TydcrCrMkKqW8FIcbolDCx2mKaKwo3UJkc=;
        b=NnQx5mKXoj3o0k41vm6/CscUVnDh2/R8WF8j1t+f6EIjVwV66mlVVOrhEgYXUFD/LT
         cT26TIS5fs8ePAo02jmPNOxJsHrh9OJ/fgy5WQ1cSktOyBtqDoDlhkTvGLzkzmuXW0gc
         jg6rFYtxjR2DqIADAtCIbs9iiu26kKfzTlKsvrmKb79fYrPs9uUrjuTsjGP1nX7ewhd4
         GIppLCW7m87mle02m+Tvv9aVT3Q5PGG+kP2r9IutqZ4GLtWgfz9jrJn4LSIv3/PBc7RT
         n5ivBm4Zt6Oj5aFMijezVNMOW4KQFW8+PNNuRAR/9tzh+lSO4rdhyKrVZayrC5S9A3kx
         Jr7A==
X-Gm-Message-State: APt69E0EEA60JDIEGZ0VrUBgVEhwzD3e+6MNbuq/Vkk87mqyYHBQuJHa
        clyGNq9pJ9YWejhFAQrQUSo=
X-Google-Smtp-Source: AAOMgpcmnWZKrBDP8OQPyTy4PbDBQSW+GKw6KiLFd63Mo8kw25OTxebKIUDrNiZUm30uX0//4Vwt6g==
X-Received: by 2002:a50:a9a4:: with SMTP id n33-v6mr1728107edc.208.1530959636907;
        Sat, 07 Jul 2018 03:33:56 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id e25-v6sm5025008edq.65.2018.07.07.03.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 03:33:56 -0700 (PDT)
Date:   Sat, 7 Jul 2018 12:33:54 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 5/5] dt-bindings: samsung: Document bindings for
 SGH-T959P board
Message-ID: <20180707103354.tyqenmmj2ry7l7ko@kozik-lap>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530958183-10956-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530958183-10956-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 12:09:43PM +0200, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document the binding for Samsung Galaxy S Fascinate 4G (SGH-T959P).
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> --
> Changes from v2:
>   - Added Acked-by
> 
> Changes from v1:
>   - Added missing commit msg.
> --
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks, applied.

Best regards,
Krzysztof

