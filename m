Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B169C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5EF20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5EF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeJRWhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:37:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40738 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeJRWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:37:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id j68-v6so24192740oib.7;
        Thu, 18 Oct 2018 07:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/oeVaEa0OqIt+kCn5KfISwsznvbszNXBOuo7gcoPmUM=;
        b=dMgsH3P5OQqptv6zkBkYUFnM4z3P69aN1P1S7qYMM2c2h/hjdQ26h7z8l/ywY1wj2l
         qIjSaiQj+N5dDfyQBEIBG+VNE4w0vdf+TyQ0lesYy4md06NwsH1UC1pAd7tJkj3rqLD0
         /NwC26626glC80lIGm7JqvD08QMW7vqRL9mLe70ttknUevxE/1XDLK6+0+1QvM7Ieh5Q
         kOZQg6yhTtyCu9ViWwpuM0qeJyQMW00y4gI6Ehw//OUToaKFc+8EO5eOaR4a9/5d0gKY
         wJz4lcBSHrvc1dtBVHvWWMaDZA5RIYOsjW2VvscqTzEJ4CIEpuH94p1z5AYQEhdsj5K7
         fxOg==
X-Gm-Message-State: ABuFfojdKY5pAjaVRQaoaxXGQ+LySl8FTqGic8wGB2C0Cv7NQ2ZPklIn
        sQeeIjf0CQ6IurYdxoiQkQ==
X-Google-Smtp-Source: ACcGV63y+zwUXJrjqLtAdZlDBPFJS6C+Zz6KOle3lvRhW21iWz/Z6g4OcohN27YC0N5qjMUtSvB8xw==
X-Received: by 2002:aca:ec84:: with SMTP id k126-v6mr15534760oih.104.1539873394575;
        Thu, 18 Oct 2018 07:36:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s11sm7678619ota.80.2018.10.18.07.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 07:36:34 -0700 (PDT)
Date:   Thu, 18 Oct 2018 09:36:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
Message-ID: <20181018143633.GA29126@bogus>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
 <1539702680-3746-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539702680-3746-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 20:41:18 +0530, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Add binding document for supported thermal implementation
> in Stingray.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/thermal/brcm,sr-thermal.txt           | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
