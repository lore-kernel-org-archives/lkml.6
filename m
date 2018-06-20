Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134FCC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60C620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60C620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbeFTTRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:17:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:37417 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeFTTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:17:10 -0400
Received: by mail-yb0-f194.google.com with SMTP id h141-v6so262406ybg.4;
        Wed, 20 Jun 2018 12:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1W3uggJWxn/IHZh4qMzKk+pjCdWL8iYm672RIfx1IOA=;
        b=Uz+KXNwLiGzgVYCNJMxSJNoiLKBJdD8AC3u9cpGKzPN0iqO5pNZChiazLo3Pzem/P7
         LJPpK9ZTx7y5Ctv1Rw6TKUwm7VPcN7C/qzQBCV5ayh4O5KsqFBOZRBely63HosDD2h7X
         sFRcwKpHtLJ6YpSM82g2CaKCQHj6s5+3OyCVUXtt2koOm87eOyEWc9qmv1r41I6mm1Fb
         i8pWPwX5aeCzoTbw0gtbqydhs2SYyStX/d7gBSSdyRQUY6uERbtgPeFHVd3JZ/cnU3Ut
         Iothl6lQhftZMkmpHR4sSFroQhqdPyGQsAfJYR2Y/2kjffX3jglnrY27rgrlBzlYrt56
         40Jw==
X-Gm-Message-State: APt69E3GMrxcTqWm9XirlnCR/KjSCdxvZWcljUd8TDjaC1ggeOKSz6jr
        FdxfVqhQ7ID/AQUtliR7Zg==
X-Google-Smtp-Source: ADUXVKJ2PUcv0UBdBxbrIqRdJveczKOJjHVF8/IvNuqcA1Hoo3/f26aYUK+khxa7W7yUl0XpVVmshg==
X-Received: by 2002:a25:a467:: with SMTP id f94-v6mr11038417ybi.57.1529522229797;
        Wed, 20 Jun 2018 12:17:09 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id f129-v6sm1094081ywe.79.2018.06.20.12.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:17:09 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:17:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 18/27] dt-bindings: display: sun4i-drm: Add
 description of A64 HDMI PHY
Message-ID: <20180620191708.GA6846@rob-hp-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-19-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612200036.21483-19-jernej.skrabec@siol.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:00:27PM +0200, Jernej Skrabec wrote:
> A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
> clock parents. It is compatible to other HDMI PHYs, like that found in
> R40.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

