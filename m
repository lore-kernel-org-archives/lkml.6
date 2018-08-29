Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53EAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975E92084C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975E92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeH2E36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:29:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33330 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2E36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:29:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so6208807oip.0;
        Tue, 28 Aug 2018 17:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgcpQyOQkNZz0ZJHxkfkyKUWE1v9l0Ew1keisycw3+Q=;
        b=MkQmaqpwG6MQrQyxRXCORYXDlh4frAxWRnrxyq2jFwNjWV77RyuQI4Zl6RuORqF80Q
         jl6JkqXiSL6I+vyFctodohIRQvvqLSyGV+UufdAX9w9hhAeIQfbiLYDhdLPtE7Cj68CF
         GuxDIYzOz3lpEFqoxbT6MmMLV1V2m9nXrZ69E2VlwOqDgjaAE5ojmQPuJVs0Q57aKe5s
         1kMpkVkjLUMDEcR3JcE01sO0GRsYPSezf/w2ui8yjzPFdDtgXR0NagfHPrr01hgHbqII
         WAAd05drQjWJIJwCS15s4nxoiaN8RZtHZ9tueXRY2CuiTHasIoQi9OQFUWwLS/vckXaE
         j1zA==
X-Gm-Message-State: APzg51DcAjjdSOsGfVzQs2njO6HOL0EMCR4nPV8rDrhQ1fnRf0s2RFQH
        iUNGxgfyTihUD2XZth7fig==
X-Google-Smtp-Source: ANB0VdYvPnJfMI7J/qnUPRh+fHLW7HKZHHAeQabU76jFZyoRYY/CRcuu3zAyYKkdh8jebYtWhgmjLA==
X-Received: by 2002:aca:3c45:: with SMTP id j66-v6mr479219oia.118.1535502947258;
        Tue, 28 Aug 2018 17:35:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r10-v6sm3288310oif.37.2018.08.28.17.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:35:46 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:35:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: ingenic: Explicitly list
 compatible strings
Message-ID: <20180829003546.GA23234@bogus>
References: <20180823131744.744-1-paul@crapouillou.net>
 <20180823131744.744-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823131744.744-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 15:17:42 +0200, Paul Cercueil wrote:
> This is better than letting the other developers wondering what are the
> supported strings.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     New patch
> 
>  Documentation/devicetree/bindings/clock/ingenic,cgu.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
