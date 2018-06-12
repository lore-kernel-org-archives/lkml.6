Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23F81C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81192086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81192086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbeFLSRq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:17:46 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39199 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeFLSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:17:45 -0400
Received: by mail-yb0-f196.google.com with SMTP id m137-v6so8275523ybm.6;
        Tue, 12 Jun 2018 11:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=snuQSOTYFTaomFbh5w/741td1PTDVO1I1x3857+Mn2g=;
        b=ith/huefNrZ97gEGAPsuVvRRuZQhNVO131BOR0WNjtZ6CuOmbB89OyyBKHYNXTyzcw
         UHLU4BVN+DWgsNzfF5uJ2UjOD4Emwx4N/XtGn1EaKbHuJ2Nqso252LZa/7uQaVdvAmeU
         NmraLg+8S5cTd4PYo9qHLtAULKIuQpYgUsNHAsOZq+xnhYfjUrktjYYhwZMDH1CtkkMg
         GrBrYzYotVTyuy0EhhXzRDeIsS7IDQBNjPkHKNTeHEm39a95/LZB3WYbGn2o2Wh948OV
         kS0yeGxbppVGKAOZFTEi5qnSRJR+BakjrN4/wFCEfwv3YdHHGNBCzRwtoVAGiL8QYgXT
         nPoQ==
X-Gm-Message-State: APt69E0rhmJ7duTGkvKep0T9oU7ai5+mXKi/ww6sIVPIe6H6lJRnA8+9
        W8gyELc6vpEmqD1XzdTJZg==
X-Google-Smtp-Source: ADUXVKIeFpIkfUwIMC4JGK4DH++0hWMSKHxnA+NEPTg0JargFEMuWJR0dcu0Iol8tYPdeNJLfVe+LA==
X-Received: by 2002:a25:b212:: with SMTP id i18-v6mr742141ybj.471.1528827459687;
        Tue, 12 Jun 2018 11:17:39 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h28-v6sm362156ywk.96.2018.06.12.11.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:17:38 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:17:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mediatek: Document Mediatek X20
 Development Board
Message-ID: <20180612181736.GA32301@rob-hp-laptop>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
 <20180605163442.4812-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605163442.4812-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:04:41PM +0530, Manivannan Sadhasivam wrote:
> Document Mediatek X20 Development Board which is a 96Boards Consumer
> Edition platform based on MT6797 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
