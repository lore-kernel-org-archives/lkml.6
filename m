Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F7C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25DC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25DC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbeGXVLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:11:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33759 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbeGXVLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:11:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so5161144edr.0;
        Tue, 24 Jul 2018 13:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QjoKfZgOTSvRLmQwtIciRh50fEOE4svFkCWA30/dM0=;
        b=C/DH0OOnzSs6l7ZKkPOEpnbFat1zsZDLTMJTWwRLLqN2CE8yzAy2dOX2C5jRWu4TPa
         V8P7Quf89klpG57jVFZ4BEB8gOe9SqeH69SxADd40exdteeAQcmF1ptWToBqG2C+Qa4f
         xsq0QuTfHF5a/aQX/rAH4Ugci9aTumt/QXqpazga71Nj87yxOYHak2dWONNxOJRThSUc
         aeS6BjYl4kPm/y3T5AaqG0/yGvYi/aNBU72J2khpEFfrj2elkYJrSte532rUm5/3/eA7
         PftB/sRvm+mv5+ubVEGTZrZpbeiSP2l3tydD16kfJPDIEGtJlp5hmTsOXN9eesinTcTI
         BYzA==
X-Gm-Message-State: AOUpUlEf07rMIA9x+3XBqOpIRLwLqnQCq1PH+g/Ktn+MbyZ38tLAo3na
        hS9wVpdsdLnJzDaegYp8Xn6kfcto
X-Google-Smtp-Source: AAOMgpegy882S6cR9wF3uBvjQPFSugNAdCjpTC1zeOcAbkCkeV0Q6n9GHjFJBIZV+Bh5yJRTVf3Lpw==
X-Received: by 2002:a50:87a8:: with SMTP id a37-v6mr20039565eda.31.1532462595098;
        Tue, 24 Jul 2018 13:03:15 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id j50-v6sm11752214ede.0.2018.07.24.13.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 13:03:14 -0700 (PDT)
Date:   Tue, 24 Jul 2018 22:03:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: thermal: samsung: Add SPDX license
 identifier
Message-ID: <20180724200312.xs6u4nvhjckukkig@kozik-lap>
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
 <20180718200250.6478-1-krzk@kernel.org>
 <2442216.oppRSGRAaL@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2442216.oppRSGRAaL@amdc3058>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 06:46:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
> > Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> > 
> > diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
> > index 0646500bca69..642e4e7f4084 100644
> > --- a/include/dt-bindings/thermal/thermal_exynos.h
> > +++ b/include/dt-bindings/thermal/thermal_exynos.h
> > @@ -1,19 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> 
> This code should be GPL-2.0 only, original license statement is most
> likely result of using wrong file as the source of copy-paste. So I
> would like to have the license fixed first before doing conversion to
> SPDX.

If you think that's the case, then it makes sense and please go ahead.
As fair as I remember this required signed-off from all contributors...
so probably just Lukasz and Eduardo?

Best regards,
Krzysztof

