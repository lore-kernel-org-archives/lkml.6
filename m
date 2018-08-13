Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DEC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9621470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbeHNAeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:34:00 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40513 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbeHNAd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:33:59 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so16604282ita.5;
        Mon, 13 Aug 2018 14:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u7O5exC2ywj0OBfotL42sB91N1hA9VKh8K3fniN8/i0=;
        b=Z9QNq21DJrBfQzToU4idn4wQr5vDxHlIx/Xj32mOYoWJNKIKTCndHoRq9ROl6LjcnC
         oMiNhJElnLzcjwInv4pbOXTRv0sQETTFneOremE0o6agH6oUDlKWvxDp1qLT9dnkKHtN
         6A+deRW71PwicW26nfJBAhfbee/I8mGExEkXzQZ1GG0hYoD7C/97VozmJpBl+Fz4ervd
         EwAPYExMGo/3nL7OuUqi4xk9NWy0w70xOly3y+yuaN3AvTDXE3UYvdwjUzi8nq3I98q/
         uBBj4qdRe/zqewKuRpZaX5QCaEt8/38HUGe6zvCfYE1rDsH7sMjrEp2DtaI3ZecltxE7
         80Sg==
X-Gm-Message-State: AOUpUlFrFhrRyU3VKfj7tkSaurtu3YFtBbC11Ul4oOfqmhQwNLRe+YfR
        OsJdxJGQM7cCpTZOk+x5sg==
X-Google-Smtp-Source: AA+uWPzfHakmOeTKL4RYxB0REkgFnF87kMniFkUrsk4ofIEmY704DZWp2MhBYqKxxMiCjyS9+SutEA==
X-Received: by 2002:a24:ac0d:: with SMTP id s13-v6mr13398308ite.74.1534196995480;
        Mon, 13 Aug 2018 14:49:55 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id r12-v6sm6671059iog.13.2018.08.13.14.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:49:54 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:49:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 02/10] dt-bindings: thermal: Fix a typo in
 documentation
Message-ID: <20180813214953.GA27382@rob-hp-laptop>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b528ddc26adcb57539b1ac9d352850d7d80bfb.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:34PM +0530, Amit Kucheria wrote:
> c(1) + x(1) was actually meant to be c(1) * x(1).
> 
> While we're at it, add some brackets to make it nicer to read.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
