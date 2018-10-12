Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60B820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60B820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeJLWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:09:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37800 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:09:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id o14so12585592oth.4;
        Fri, 12 Oct 2018 07:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eUvWL5SSUqDX8Gu55QbSqeMG+bs5NR0AwqS1Q0dpwUE=;
        b=jdi26IIbg4LkyXFWSQeiq+sxnla7qbVrziCZ4FUzyMIlOYGzjhqHn+KwCxr7t+oHUs
         /gvQj8/TIoXbjn4vIEaVdZItrNZbpmGi1JIQiivVX1XpyYm81QbT/z4JfVwSKXKTgY/P
         YIChLfhr4+/uiqk4vKPB/PpNK6HK7v7SjOBLBwHnoap37Elr6Kju0skKBV0Svh1BjexK
         soI/EiLzuSzoiQqJKSRJ777LoC4YgWFPmIIrOfR/Gm7q7z+BRIo5RyxxOCuhC9OnmTvz
         Q2N23VQw5wd8L4IBODSrzgM1GJLSuTPv4m8Lg/Uz02PS5s+OVORlcpmHsj2bRidi0+nQ
         2EYw==
X-Gm-Message-State: ABuFfoizeLEagbXPLFt5J+2saa5BH0BUEyIKAv9Fat75Ku6jkBRVFM92
        z3MwMq/wp7pf61DXeMbsOg==
X-Google-Smtp-Source: ACcGV61LjH4U3PRUgCDyvn3lQ5u4JMCvjEOv82gL5InX+DBlDygA+o8K22fY5VWb3r4KfsVjQKcj9A==
X-Received: by 2002:a9d:44d7:: with SMTP id p23mr3893359otg.316.1539355004587;
        Fri, 12 Oct 2018 07:36:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w128-v6sm322766oiw.15.2018.10.12.07.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:36:43 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:36:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v3 3/4] dt-bindings: power: Add Spreadtrum SC27XX fuel
 gauge unit documentation
Message-ID: <20181012143642.GA9323@bogus>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
 <f87afb701f33f46928c682361235083db8d3d2fc.1538033078.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87afb701f33f46928c682361235083db8d3d2fc.1538033078.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 15:26:56 +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
> fuel gauge unit device, which is used to calculate the battery capacity.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v2:
>  - Add reviewed tag from Linus.
> 
> Changes from v1:
>  - Renamed GPIO property.
>  - Use standand battery properties instead of 'sprd,inner-resist' and
>    'sprd,ocv-cap-table'.
>  - Remove battery node's description.
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   52 ++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
