Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5498FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4C720844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4C720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeGYU0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:26:10 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56118 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbeGYU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:26:10 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so10254779itl.5;
        Wed, 25 Jul 2018 12:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gus1AnFJTbrTLsYvp6XQonogMjOwTeYNcXfplE0R/mM=;
        b=aCaAUrk0/Gr0IbCGFvA3VQ72KcVn5mnnPLn8ChSDEzBhUdDFOEXvd37pqLsDaZwQIT
         reTEH1VlzNnAHxYFMpXWezg1UnHgS45jqsWKEpD2oNn8wkmZKtnemMapF+s65PqevWcC
         wbUKIbQPWz2/T+uK1abwgBh28r+gWYmaqOVhXDKK5UDSv7FkMu9QQ6wuaseaMHYVT5DP
         3242GSa4f17OFeTkp+uflUTnAxYDXQMtl+9l2xCAviCIfcU9WZeyOUde03IKu7EUvWMb
         ao3zyo9ocd1W8Cg7H53W4jM/21jc0AnnShPFMF59lDJOfkx09dlcOTX7oOkfSNeqnbJz
         djcQ==
X-Gm-Message-State: AOUpUlGVLBH3fuo0x40ZIqFCW+8p8d1cw8jsc3Z20vpjP0uzuSn1fFG8
        WdZ5P6vcd8W6qGxrpUOXMTgYsVOCrg==
X-Google-Smtp-Source: AAOMgpdl90UkQsKZiAVDuF0Cc8GF51FoL1tlOgaJ2y4O7AKPbxDdwXDcralZLPihrDxyLt41Pw1mlA==
X-Received: by 2002:a02:5e42:: with SMTP id h63-v6mr20932451jab.117.1532545988764;
        Wed, 25 Jul 2018 12:13:08 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z14-v6sm4682842iob.68.2018.07.25.12.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:13:08 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:13:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: clock: samsung: Add SPDX license identifiers
Message-ID: <20180725191307.GA32217@rob-hp-laptop>
References: <20180718200216.6389-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718200216.6389-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:02:16PM +0200, Krzysztof Kozlowski wrote:
> Replace GPL license statements with SPDX license identifiers (GPL-2.0).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/clock/exynos3250.h            | 5 +----
>  include/dt-bindings/clock/exynos4.h               | 7 ++-----
>  include/dt-bindings/clock/exynos5250.h            | 7 ++-----
>  include/dt-bindings/clock/exynos5260-clk.h        | 7 ++-----
>  include/dt-bindings/clock/exynos5410.h            | 7 ++-----
>  include/dt-bindings/clock/exynos5420.h            | 7 ++-----
>  include/dt-bindings/clock/exynos5433.h            | 5 +----
>  include/dt-bindings/clock/exynos7-clk.h           | 7 ++-----
>  include/dt-bindings/clock/s3c2410.h               | 5 +----
>  include/dt-bindings/clock/s3c2412.h               | 5 +----
>  include/dt-bindings/clock/s3c2443.h               | 5 +----
>  include/dt-bindings/clock/samsung,s2mps11.h       | 5 +----
>  include/dt-bindings/clock/samsung,s3c64xx-clock.h | 7 ++-----
>  13 files changed, 20 insertions(+), 59 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
