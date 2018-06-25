Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E5CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1741625F5C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1741625F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964833AbeFYRdW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:33:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34010 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbeFYRdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:33:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id y1-v6so775518pgv.1;
        Mon, 25 Jun 2018 10:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ve/0ePpJYgZ6xMPmi4Guh2qlFKx+/MSUrNtiHQkldnM=;
        b=YTzFaEf49Lr0T1Z+q99dlgINl1LbhIV15n0blYd1CL3g8PPTd1heM5mT3vgSetbYLs
         V/kHJoHsmS9FeNKocWvsACJJUkoVfPqeFSTqosTBj5llmwPUSXfhK3gbDzd5LYedgB0s
         M8USvcQO13L0ZGDUvxRjW1UGHPvQ8AupZQVxhasA5ke6GAvDS/zXfGIq0D5O60txWzrS
         vHcbbeykzwMvEqPIdrll0kvBaucIliIdYrRq/8bHWAZVEcrOM7wuSIiqt4tbhdnI8fSb
         x/K050BVXW1IZ5/j2cWz2g8J9hPrWT5x9Z9SoQ+l+2c/RxWCEey4DQucrv1ctxQ7sN7g
         G8/A==
X-Gm-Message-State: APt69E2PslgwvAIBIjE+PQUcqcF01OmoiCtp2b2xmen3bzrl3ub5ymzR
        tZ66nO/by2wdmyGS5/T/NraezNQ=
X-Google-Smtp-Source: ADUXVKIxrLkuoHldmQ933KOmdpFx+RkJHkiYHxZUkGCu/O/Tdrjn7vmKLrMP4aRCL4ELSJ8ucW7TgQ==
X-Received: by 2002:a63:8648:: with SMTP id x69-v6mr8028905pgd.172.1529947999363;
        Mon, 25 Jun 2018 10:33:19 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id a25-v6sm21078212pff.8.2018.06.25.10.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:33:18 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:33:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 04/24] dt-bindings: display: sunxi-drm: Add TCON TOP
 description
Message-ID: <20180625173317.GA3691@rob-hp-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-5-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625120304.7543-5-jernej.skrabec@siol.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:02:44PM +0200, Jernej Skrabec wrote:
> TCON TOP main purpose is to configure whole display pipeline. It
> determines relationships between mixers and TCONs, selects source TCON
> for HDMI, muxes LCD and TV encoder GPIO output, selects TV encoder
> clock source and contains additional TV TCON and DSI gates.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt      | 56 +++++++++++++++++++
>  include/dt-bindings/clock/sun8i-tcon-top.h    | 11 ++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h

Reviewed-by: Rob Herring <robh@kernel.org>

