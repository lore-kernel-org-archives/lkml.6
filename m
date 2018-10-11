Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA88BC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C9C20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C9C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJLFps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:45:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34892 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJLFps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:45:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id 22-v6so8384348oiz.2;
        Thu, 11 Oct 2018 15:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jIaV3KjejdbYoGC20+h6RxGLNKJklc8B2cKJ3PoWx4k=;
        b=BYHE3tEs3UlJNq+cI5vsai2gitLHWSkNYj7bjL/eArGgNWbh1BESQAOjxj5FaJ8RsH
         Jw85pKypFQ3sK2IgLCFG2uFuCVyWmXyxyJFMvqCLXl0Ksf8teWSyrZyc3+YID6vZgNBN
         JC4j7ZqI0k5pd6Qpn3zsaBLT/V4Ss9nZDXg6aILI7GiikMZcuRWUwMZ9idKnu8Ax1CpK
         yKjngmYjpTqPLz6D1XLONi8cHPnT1LcaQglaWtIMnc2gZ27N64l+3+62l+b9zz55Gbv3
         40OxyWZtaJeG4KNlH44HpaY4RQo3BRH+zsg7T79bwdw7oSSSkw5ocJ4lRJVIgNDSXoZo
         xoPg==
X-Gm-Message-State: ABuFfoiIfxrnMURoFQg7lmyuLSJtMJ31s1iPYIEt90WuY12LZPBvh9kn
        MMBo4bHpLib4Eu8cDBcliw==
X-Google-Smtp-Source: ACcGV611jVEJlZr4qCdbRVjtICh2bxMz43YaOb8JiOHiFPW1Efl2ZXwv/1UD4T1cMEQBLy8X4vSUPQ==
X-Received: by 2002:aca:e385:: with SMTP id a127-v6mr2052836oih.261.1539296191667;
        Thu, 11 Oct 2018 15:16:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j79-v6sm14413203oiy.13.2018.10.11.15.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:16:31 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:16:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, will.deacon@arm.com, dianders@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom
 smmu-500
Message-ID: <20181011221630.GA5841@bogus>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-2-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011094930.17010-2-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 15:19:29 +0530, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 works well with current
> arm-smmu driver implementation. Adding a soc specific compatible
> along with arm,mmu-500 makes the bindings future safe.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> Changes since v3:
>  - Refined language more to state things directly for the bindings
>    description.
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
