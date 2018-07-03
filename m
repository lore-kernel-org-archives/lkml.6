Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4896C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5003C214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5003C214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeGCTv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:51:56 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35032 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCTvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:51:55 -0400
Received: by mail-yw0-f196.google.com with SMTP id t18-v6so1130104ywg.2;
        Tue, 03 Jul 2018 12:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5uJJwXne69vcz596G9T2Pt2mzqt1QZfnCFidRgPspeA=;
        b=TlLMZVSK5rngl0jyHf/Tewy+SXdaYfUvv9H7UV5j7CWGsTxU4nTvETMWA1ZEET7mVV
         XRhu+xG7oze8H1YgDCe0eUMADXrgBkAxFR7YSzTJJVEAaRnJgxpcGADFhseXka+bkvpY
         2Ejpy7kEKrysiNw0pzJ0Q0FZ8Anwd5otbWAkF1nvYMELDWKqRAM+iLld8/6Jofnmu51b
         FRXESpqHkRHFVfEXtzVT81HCW795WTaXvtdsnhvB3IJw/eBFx3ywEiCqmPeZbYFU5DWn
         cXBUmP3IBoPbUGeAaHCu7AwRI1qeQTyuV8jWMIY1zA3FImbCEzaFJ+6LfgmOsd/goDYf
         644w==
X-Gm-Message-State: APt69E2M4vhMT4UurHOyL/GtDrKTpuoFznkgmEOqPMm1VYr/ENKNp7D1
        cPChwLD1ZE/cUIMaCFStqA==
X-Google-Smtp-Source: AAOMgpe+3uzbFKAi3mrDs7HAeHXlRsOIw6+XjeASixWAuldPuH01QxQ7r1R9zQlgbBkIuUM4dWS+9A==
X-Received: by 2002:a81:344d:: with SMTP id b74-v6mr6704721ywa.77.1530647514413;
        Tue, 03 Jul 2018 12:51:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r132-v6sm793608ywb.0.2018.07.03.12.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:51:53 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:51:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 15/32] media: dt-bindings: media: qcom,camss: Add 8996
 bindings
Message-ID: <20180703195151.GA3261@rob-hp-laptop>
References: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
 <1529681621-9682-16-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529681621-9682-16-git-send-email-todor.tomov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 06:33:24PM +0300, Todor Tomov wrote:
> Update binding document for MSM8996.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,camss.txt       | 44 +++++++++++++++++++---
>  1 file changed, 38 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

