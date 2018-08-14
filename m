Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267A4C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CA12171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CA12171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbeHNX22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:28:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42315 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeHNX22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:28:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id g6-v6so8775550plq.9;
        Tue, 14 Aug 2018 13:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d04twGrybtp6qmdrdldCymSHqbU7m66JcjtB7/BdNY4=;
        b=HGn3GZc2ggaz3Z7dHoO+fOGyLBjmgnGliYw1kyqXkSRtfHQnIHj/+tstdnwfZag+aI
         O0Gf/KAyAmDO1gM8l7Jzr3fCNhweK0EZsyAkLp4iJxRhpn5X6ktGXfsgvmDQxFl76fJ9
         cn5SC8MKjCR0XT4jdSKUNZ9y713i5swNTulA9sSOVcPpeBkVWCH4LcGcj2gc1ey60rxn
         M3RhBriyG+WbofgiA4O5g+BpV0Qk/DW9Bx+RoVx7zbcCE/zjH2/SB0ZDSL6qyThnUt3N
         EyikMu33WBFqx0vJka76ZVohbCufwFkPw/zndTNfVaYYLYk+Vo+8sjdbqj8WE3TYrlS5
         +K8w==
X-Gm-Message-State: AOUpUlHy7Ev2jQsTmrRAGC7FgXp/8k6fH0/bamoXkhwozvl0HNnw7X5L
        ufzER2JfYPU8Xijs4GgAng==
X-Google-Smtp-Source: AA+uWPyq5C/HpEsjNtRjJWNZKcHUgQ7cVT1NneU8mzF41tluwNZStN3n8CmAVo0U5WQJ7UFgYzcVFQ==
X-Received: by 2002:a17:902:342:: with SMTP id 60-v6mr21623756pld.15.1534279173510;
        Tue, 14 Aug 2018 13:39:33 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id 2-v6sm43058080pfs.58.2018.08.14.13.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:39:32 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:39:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: maxim: Add SPDX license identifiers
Message-ID: <20180814203927.GA31064@rob-hp-laptop>
References: <20180807161826.2222-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807161826.2222-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 18:18:25 +0200, Krzysztof Kozlowski wrote:
> Replace GPL v2.0 and v2.0+ license statements with SPDX license
> identifiers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/regulator/max14577-regulator.c         | 22 +++++------------
>  drivers/regulator/max77686-regulator.c         | 32 +++++++-----------------
>  drivers/regulator/max77693-regulator.c         | 32 +++++++-----------------
>  drivers/regulator/max77802-regulator.c         | 34 +++++++++-----------------
>  drivers/regulator/max8997-regulator.c          | 30 ++++++-----------------
>  drivers/regulator/max8998.c                    | 28 ++++++---------------
>  include/dt-bindings/regulator/maxim,max77802.h |  5 +---
>  7 files changed, 52 insertions(+), 131 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
