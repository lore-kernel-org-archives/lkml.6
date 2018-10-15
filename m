Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB2C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8012083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8012083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJPCVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:21:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38328 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:21:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id l1so19892658otj.5;
        Mon, 15 Oct 2018 11:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSodHYOolLwjxFJ9gIlOnGuMUDPA4f3OUzcPYKw2Tng=;
        b=A9y1g2lInA4Q5ajFPrKwFxkPdaTQ2Yx06O3j/nDgQWIPsxX5Xj3KMcVLw3Dibg88Ht
         PDLkCY7sSq/9y0f0Xfc2gy3rzDW7Blf90W9UbCSO6GWWCC9mp7cmHO1+ZU+XBl1ih5cx
         +Ogp65MsjM2dEmebF9vx4owzJQaFdAJrQfPkebm7bx4egZx5efVWV88CAmeUsJlRGDiA
         +NqBad0i8WtuYzYgyv8J3tMD8y/gpsEqE2ulLR37S+AkDepBSlBQ4jNas0VwoeubK3V0
         JgnlR69hlFzglHgYIKUzB1OJYTZQxHqSLkiqhIBHjT6XZhjKvkZzTTkNyuS5hJh8otbo
         hUJw==
X-Gm-Message-State: ABuFfogJL5bdAfWkrSeYjvOOYECsbUZCOSb7FMG3AT1BaScZc2MYRMM/
        Zl2KS962VogzsGX10/Fxeg==
X-Google-Smtp-Source: ACcGV60x8eXjagK1aG1enZrWPHycd8Iwq5N9TnxT1FByTSkIWwdU/XIBHHjvjXSMQ66X7VYs49aP1w==
X-Received: by 2002:a9d:11c8:: with SMTP id y8mr12405304oty.293.1539628514235;
        Mon, 15 Oct 2018 11:35:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r33sm4689207otc.37.2018.10.15.11.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:35:13 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:35:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] dt-bindings: clock: samsung: Add SPDX license
 identifiers
Message-ID: <20181015183512.GA19458@bogus>
References: <20180927170347.12909-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927170347.12909-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:03:47PM +0200, Krzysztof Kozlowski wrote:
> Replace GPL license statements with SPDX license identifiers (GPL-2.0).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/clock/exynos3250.h     | 5 +----
>  include/dt-bindings/clock/exynos4.h        | 7 ++-----
>  include/dt-bindings/clock/exynos5250.h     | 7 ++-----
>  include/dt-bindings/clock/exynos5260-clk.h | 7 ++-----
>  include/dt-bindings/clock/exynos5410.h     | 7 ++-----
>  include/dt-bindings/clock/exynos5420.h     | 7 ++-----
>  include/dt-bindings/clock/exynos5433.h     | 5 +----
>  include/dt-bindings/clock/exynos7-clk.h    | 7 ++-----
>  include/dt-bindings/clock/s3c2410.h        | 5 +----
>  include/dt-bindings/clock/s3c2412.h        | 5 +----
>  include/dt-bindings/clock/s3c2443.h        | 5 +----
>  11 files changed, 17 insertions(+), 50 deletions(-)

Applied.
