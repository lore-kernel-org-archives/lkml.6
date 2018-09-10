Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB67EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830C42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeIJXXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:23:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35685 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJXXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:23:33 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so42132053oic.2;
        Mon, 10 Sep 2018 11:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ygh466OvkSsy9mPeYzF1fPpN7AzkT7pDNoditp19vjs=;
        b=CzMGokTjh5NalQxoLpbsZRs8DJgmRKxphu+Pk561YBl4Vky1YZQfIAToMYiMBmPadn
         3sxVcMb1+itqVWnJTAyc4KEFIGzl0+LVxzZv+U/XYxF7p90BcPYlhj6LZIIk316AEJ8P
         d4DZjuo0vrMSOjZi2ZNvhYsZ+8Il75asNeApkviZGDTh/nYHvx8obMsnqBAfW1ztGCtp
         ixnC+m/4k+5GxdToI7I+bL9pZHRL79v/fhm6McpfjUkVi24RJ7tM6cXQy5L/2PpKkYdz
         ZFy2OP27tI3ZHeKqYqXbx3Ge+T8OYZfLGXBB4qRXiw1hEvb/3EjuF05Ax7Cjpf2fTZqx
         lxDA==
X-Gm-Message-State: APzg51BxOQ+c1z9QTl9XPdET10Hl8arOBD5qOX5KPjTw4MrX6JO3sARR
        GeTB5RGw3Y6OM8ze/AHFrA==
X-Google-Smtp-Source: ANB0VdZlyba2SB7IzlKRJgT3JohagixrIQoUitM5rPAFhhLNgTWxBaJqhLidVmDnY1J+YK8MwlCNsw==
X-Received: by 2002:aca:edd8:: with SMTP id l207-v6mr24019641oih.65.1536604090814;
        Mon, 10 Sep 2018 11:28:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 207-v6sm23274175oie.14.2018.09.10.11.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:28:10 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:28:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: remoteproc: qcom: Remove additional
 definition tag
Message-ID: <20180910182809.GA25894@bogus>
References: <20180829191215.10071-1-sibis@codeaurora.org>
 <20180829191215.10071-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829191215.10071-4-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 00:42:12 +0530, Sibi Sankar wrote:
> Remove the additional definition tag declared for WCSS sub-system
> under reset-names.
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
