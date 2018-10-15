Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA31C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81D220881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81D220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJPCWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:22:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40677 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPCWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:22:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id j68-v6so15901008oib.7;
        Mon, 15 Oct 2018 11:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t6NOvulP2dY9k2uyzb+m7OUqtBOg8vYasQH270pWY7o=;
        b=sN1d8rjtRVzVkl7iT0J0I8l1fdHQXDSkmzU8C9q6Zy1/ODUtuTYPGSaR8JYEJNKmb+
         0F67AlwkZTK4K2ehRqY4YV68cg5Vznu5S/y10LfnRDsfok3qcmsmIdXDORqnsb0CXBxB
         tj43x4KVBgyR7O+KOSHh8uxeZgxbEMh+riWLz11yK72AofvMRZesqVxvZKc62r+wL4va
         fSLFfaP66uU5oS2njWeD9cOCETwOxiRE5LBsE/SrPkGSfP+PC3yqZk0b9pt7wvKpi7No
         pW7HyMlwWsnYHVkQKqWz7ULIJmYDPZDbnchT7NlOpYgudVpWJ7Is2A0TMJGpzQIlg/bq
         6Y3A==
X-Gm-Message-State: ABuFfogwki2N4S0nXesyRIGwUpwNjXfzE7KCrTTkiGT4LusrNM7+S0ap
        EW/5YGS3qqdHQMxNQ5E35A==
X-Google-Smtp-Source: ACcGV6279EkfRp5Y+GZ7ki5SeboqigKlPNvxf9SFVYGUIAA6PwcgAN0Bt+CV0fymgNQpeyafJoRb5w==
X-Received: by 2002:aca:b945:: with SMTP id j66-v6mr148149oif.86.1539628538940;
        Mon, 15 Oct 2018 11:35:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u6-v6sm3228566otk.29.2018.10.15.11.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:35:38 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:35:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [RESEND] dt-bindings: thermal: samsung: Add SPDX license
 identifier
Message-ID: <20181015183537.GB19458@bogus>
References: <20180927170440.12985-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927170440.12985-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:04:40PM +0200, Krzysztof Kozlowski wrote:
> Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> We postponed this patch because in previous discussion [1] Bartlomiej
> expressed willingness to change the license... which did not happen
> since July 2018.  In such case let's take this.
> 
> [1] https://patchwork.kernel.org/patch/10533191/
> ---
>  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Applied.
