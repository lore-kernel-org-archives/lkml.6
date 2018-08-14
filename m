Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68DF2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68DF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbeHNXqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:46:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42949 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbeHNXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:46:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so9776652pff.9;
        Tue, 14 Aug 2018 13:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nwqsnHqjuIfyQ1SfODj0iV0t1f//X7eIwzKCXGJncg=;
        b=hN3C0hDj5KkKCXfikEYJG16ZgEwLmVC8fx5EseN/tv1vGOZNmJK462c/jWqe2u+R76
         f3hNER+kdnS8QxuRsEiq0jwCP+L/CJ/cMDGewiWyFavvansH6jYlvRHUMjT1ni2TqIbL
         6p3XwxlXf2446vDVfhJy00Ejg4MjdaTTGiC/+uxvkX8jUOJhwW4tXSgJQEjlGAoB/hhU
         NQNbq9nIYj6wdezfRxZplEHtmHkQfRAPv4sesD2VfYKHXM/L8XrFJid7B1dDqqDUpEL1
         A1ZdUN0LgMQQvTl4y0myXvkuIF3f7oSFRNZ2/uBCG+Jqd2lbA1zgQJxPho6GEQ9vzNGU
         7i5g==
X-Gm-Message-State: AOUpUlG33W1/X4Mp6W3oHqbzWwTaKMay/nzNtrJ692Fx6nhqTJHonGEy
        6Hdv8KDDwS+mp5WgSiDFhg==
X-Google-Smtp-Source: AA+uWPxH7Jz+dOTDKqKpUnwidkz9MaMG9mLOe0a2+dH/8ACGOOvfa72dPT2EGy0f3TXe9UdoRcdf5A==
X-Received: by 2002:a63:41c6:: with SMTP id o189-v6mr22953959pga.323.1534280221995;
        Tue, 14 Aug 2018 13:57:01 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id e82-v6sm37761500pfd.40.2018.08.14.13.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:57:01 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:57:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smd-rpm: Add sdm660 compatible
Message-ID: <20180814205700.GA23182@rob-hp-laptop>
References: <20180811162417.10143-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811162417.10143-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 17:24:17 +0100, Craig Tatlor wrote:
> Add the compatible for the RPM in SDM660, so that rpm resources can be
> made available.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
>  drivers/soc/qcom/smd-rpm.c                                  | 1 +
>  2 files changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
