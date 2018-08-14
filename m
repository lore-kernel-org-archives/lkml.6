Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B27FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B2D2154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B2D2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeHNX1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:27:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeHNX1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:27:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so9635953pgv.0;
        Tue, 14 Aug 2018 13:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T4c6XagcR5g1nqpYbqzQwv2qo/ev99pkbjrm4zTHPI4=;
        b=NkgfN8719M4TDF5iy3YEU+LLHzfDHW/87t6ENM+av9byxPYssMd59HUvhAzugBcFwE
         TFXVwATUN7P3tGkPJXidzN/UiYlYYSXPbsTq1kGOaNZGX5AqKFL18Wf/6PqrtFAHa/Bj
         TgWaK/JrXgd2rsDk4u9y81UFg9pn0R1qx0FBUX9M2VQ0LIfJ9lKojXAHWQGPfvViTvYY
         kxffJ5+uLgo/2kTCMvf68ZevS84sYctJyuVn/oU6ZpBS36kQRenik75IRTRxsLPTZmkZ
         vqRyIm5AMA9YQFfVVZQeAGDFJdTjxj4qzIg96pvFWeZQF1vZflYWNuZ4aNxeF525+xre
         QrEQ==
X-Gm-Message-State: AOUpUlERY8H8Xi7espJmY14qS3q7H6x83i7QLYe4EF7yg2Vmq5Z+kzlT
        XsFighttHdMUOJ/4ST6XqQ==
X-Google-Smtp-Source: AA+uWPxkINcd8rviYwOYe55Fdxxivsf6QNBEuu3Dfh4AWMZP6Ph4D4GZrmakuMK/tk/4LKo5UMDynw==
X-Received: by 2002:a63:1a49:: with SMTP id a9-v6mr23073551pgm.423.1534279103297;
        Tue, 14 Aug 2018 13:38:23 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id u11-v6sm36523497pgj.71.2018.08.14.13.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:38:22 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:38:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: s2mps11,s3c64xx: Add SPDX license identifiers
Message-ID: <20180814203821.GA29323@rob-hp-laptop>
References: <20180807161713.28073-1-krzk@kernel.org>
 <20180807161713.28073-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807161713.28073-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 18:17:12 +0200, Krzysztof Kozlowski wrote:
> Replace GPL v2.0 and v2.0+ license statements with SPDX license
> identifiers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/clk-s2mps11.c                         | 21 +++++----------------
>  include/dt-bindings/clock/samsung,s2mps11.h       |  5 +----
>  include/dt-bindings/clock/samsung,s3c64xx-clock.h |  7 ++-----
>  3 files changed, 8 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
