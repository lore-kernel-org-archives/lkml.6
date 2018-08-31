Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FA720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FA720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeHaQ0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:26:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42472 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeHaQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:26:00 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so14211935qto.9;
        Fri, 31 Aug 2018 05:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bIvwO2k16JmokORIYNK+S0BqwAHcxkHoHwlHfqQLNEw=;
        b=UVuVqUKQTS5B/TsGTo91g+FpgfhGg66soi5IiIJ5GJ4Q/JkfFUgbvpAwvQXU9utFGR
         NNqmOVOKE4w8N0e9Uqocy09m3YeZEaF4nsomsw1ekI53Og8C0JPYdK2DMraEidxmI+h3
         3NNPNgtz4ZLKK3F2OqhjwQmIeIwaCfUjJlGjcmniGhWsTH1FATCilhu/eN8o0cL/SOYF
         dvGazvfJDLZzMoIydDMp7jQgB6NIgxYV+Lt/7QjCgJXDIfpdqslmR2BWExG5MRqJ9pb3
         9w8y/hVtAdpIvVXkl2x3obKNg/Yp9Vk2VkzzIHRF5+vVm+ur7EpRyac0Hhf3jjd2U5Jh
         eqYw==
X-Gm-Message-State: APzg51Bgblz6Nds22tMisLauFwwO9vMXi/tL8N2pvYR1LY3bYQ0dqkpD
        r7q7q3PMsRlWT3Qyuu3tlA==
X-Google-Smtp-Source: ANB0VdaxsH/2KhnD3lS397pejSnZIg/uP600wZ5s03A/uOorG4X8NUqdanjueUxdMIozOoaVnz5ptQ==
X-Received: by 2002:a0c:e74c:: with SMTP id g12-v6mr15302482qvn.118.1535717925746;
        Fri, 31 Aug 2018 05:18:45 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id l23-v6sm6242705qta.30.2018.08.31.05.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:18:45 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:18:42 -0400
From:   Rob Herring <robh@kernel.org>
To:     Jan Tuerk <jan.tuerk@emtrion.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix typo in compatible description.
Message-ID: <20180831121842.GA23617@bogus>
References: <20180822134348.49165-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822134348.49165-1-jan.tuerk@emtrion.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 03:43:48PM +0200, Jan Tuerk wrote:
> This fixes the error in the compatible documentation for the EDT
> etm0700[g].. panels which have accidentally documented as etm0700[8]0..

This needs a more specific subject.

> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  .../devicetree/bindings/display/panel/edt,et-series.txt     | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/edt,et-series.txt b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
> index f56b99ebd9be..5759d64d0c15 100644
> --- a/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
> +++ b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
> @@ -23,13 +23,13 @@ simple-panel.txt
>  +-----------------+---------------------+-------------------------------------+
>  | Identifier      | compatbile          | description                         |
>  +=================+=====================+=====================================+
> -| ETM0700G0DH6    | edt,etm070080dh6    | WVGA TFT Display with capacitive    |
> +| ETM0700G0DH6    | edt,etm0700g0dh6    | WVGA TFT Display with capacitive    |
>  |                 |                     | Touchscreen                         |
>  +-----------------+---------------------+-------------------------------------+
> -| ETM0700G0BDH6   | edt,etm070080bdh6   | Same as ETM0700G0DH6 but with       |
> +| ETM0700G0BDH6   | edt,etm0700g0bdh6   | Same as ETM0700G0DH6 but with       |
>  |                 |                     | inverted pixel clock.               |
>  +-----------------+---------------------+-------------------------------------+
> -| ETM0700G0EDH6   | edt,etm070080edh6   | Same display as the ETM0700G0BDH6,  |
> +| ETM0700G0EDH6   | edt,etm0700g0edh6   | Same display as the ETM0700G0BDH6,  |
>  |                 |                     | but with changed Hardware for the   |
>  |                 |                     | backlight and the touch interface   |
>  +-----------------+---------------------+-------------------------------------+
> -- 
> 2.18.0
> 
