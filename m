Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E536C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F7B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F7B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeIYW6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:58:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40445 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIYW6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:58:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so2078657oib.7;
        Tue, 25 Sep 2018 09:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3GlzczyUl2Z6t53k93le8AdyR7vPjr9yYVJEMifYBVc=;
        b=L8J0OPKdJgQD8j+xLb8FSyO5Rq7tbanDOm1nm4oBhKq9Tqy1TKqYulhI2yFlwzqir1
         J9jNqVS3f58qcQWoVNRjwLvw0LL5GatMKWd6hYY29oM3bwEZN1eKZP1rhrwsoF/v17za
         OyjxkUUl/dxg4F310t45LYCWLhEuxmn2yMy0MGrM4QevUPtjCznbFadhLyBq9o0fopuH
         +aGLbpvB6w+Q1av9yGe5UpAS9iJ6mYxwbMb5dgBcLer/slPbnruLMetB8LBabKbPSRdH
         r+ytPD5Cx6pQboW1I5BqzPwpO0L0FekozysiAHoE6P9iZusClZHYBc50WfQdyKOWu3A5
         WtaA==
X-Gm-Message-State: ABuFfohblH0vDdMzfEf7AXClx1ZMBANAT6CuvBoVoQxGcZTwKQyHsZMl
        Hy9cm4t151ExKt2PYCE2uQ==
X-Google-Smtp-Source: ACcGV62SBSkIh2mrlQXR9weMYlrtk/eVZ7+PAAf1SrWcUvbhmFzjojoTRJtFFLai/PJ0G9xdjlmhUA==
X-Received: by 2002:aca:e046:: with SMTP id x67-v6mr875750oig.328.1537894189823;
        Tue, 25 Sep 2018 09:49:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n30-v6sm1100535otb.73.2018.09.25.09.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 09:49:49 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:49:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     p.zabel@pengutronix.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] dt-bindings: reset: imx7: update the compatible string
Message-ID: <20180925164948.GA30958@bogus>
References: <1535616325-17445-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535616325-17445-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:05:25PM +0800, Anson Huang wrote:
> The i.MX7 SRC's compatible string should be "fsl,imx7d-src".
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
