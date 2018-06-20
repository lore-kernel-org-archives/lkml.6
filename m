Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E04AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD00420020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD00420020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbeFTSrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:47:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38240 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeFTSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:47:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so1310258wmf.3;
        Wed, 20 Jun 2018 11:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RyF3ZRveHQZmmqysjvz/kiI7jXudZoi3wrvCsRzNGGw=;
        b=dnZvJc1nLuUqApXXZFFGbIFdaw1KszxUYcT+uOj+GZGR+Bsq84J8XErWwagRSeUlLo
         SRTmgZRYPTlRtlNBlFJXa/JNSr23hRyv5uAsbAkJCxSQOqcphROLtn9DUASW8xn7UojS
         4kec97Sdx97xMyWE92mhT5mlSkF4zeDoXrsYulzhZ/FrpL3jwPUhYztBoXxk+5lYD6aa
         I+OZqPEJ16R3gbiGf6NbhBnElW9EG2RuQVdnIsUceg+Uw7vBN+RzM33UEhMhZ6gOEpJA
         LDfFTUxz2FB5YF8v/j3+BX5oK2MaAJ1FwoUl/mbPpNNnWscLluF9tCw5/FQpguk6E8cX
         wOzA==
X-Gm-Message-State: APt69E1r1wkeJdlWEp89gyL6ml3r1co/vY3bRLGG0GrYQW67it3LhWXj
        DILNn1o0t3Njzz7894cg5u5RwuFa
X-Google-Smtp-Source: ADUXVKJ/RvHhCwRyz2oEmo7wcp2102xUR5cTkXQUL6APaQItARcWyhEgjzFxpdH6cLVWXFRut6YSig==
X-Received: by 2002:a50:9b5b:: with SMTP id a27-v6mr19213331edj.60.1529520469612;
        Wed, 20 Jun 2018 11:47:49 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id r22-v6sm1138583edq.40.2018.06.20.11.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:47:48 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:47:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Remove obsolete insignal-boards.txt
Message-ID: <20180620184747.ermfvtqzllofwoub@kozik-lap>
References: <20180528185310.21971-1-krzk@kernel.org>
 <20180531165007.GA29098@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531165007.GA29098@rob-hp-laptop>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:50:07AM -0500, Rob Herring wrote:
> On Mon, May 28, 2018 at 08:53:10PM +0200, Krzysztof Kozlowski wrote:
> > The compatibles mentioned in insignal-boards.txt are already documented
> > under devicetree/bindings/arm/samsung/samsung-boards.txt.  Also the
> > contents of insignal-boards.txt is not accurate, e.g. does not mention
> > Arndale boards.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/insignal-boards.txt | 8 --------
> >  1 file changed, 8 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt
> 
> Reviewd-by: Rob Herring <robh@kernel.org>

Applied to samsung-soc (with fixed typo for Reviewed-by tag).

Best regards,
Krzysztof

