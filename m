Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17868C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF59122BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF59122BD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934080AbeGFUk5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:40:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41531 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeGFUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:40:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so25719613oiw.8;
        Fri, 06 Jul 2018 13:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HEfb2FK/RPkdAEhKGyY7mBy/am8FjF+75gd2lVgZYZY=;
        b=o6GwgAGfs6KrisGcLKi/OKYuNbBnz4hPz2Rb22yql7u+4SFgNzceci4ZMf0eDFcuUi
         3S2aMdcuN2I5Y6sLSBWYz6LeYVS4YmBxYFOHkBDM/w05UPXAsXUnVt4vbhTZFB6WneXr
         iVXQ2bxTmsnD0h66bYXlLo6UIKqcTEUeVer/Aj7IYCWf2O33yzWAH2PHs4j4dFQ5aju1
         DLtcbpZ8LtM9NjVYXan4mP0Sf1TnhpYhk8u/3Yw47JsDcEHCEIgwSIQLo7Id63gv6p7L
         HWx3VKWo0aZbjWBO2z9mVWhD5vLcyh20BZ+DcP0fJGFHaShmg3rZI/kCI/S03U9b1+au
         +Nuw==
X-Gm-Message-State: APt69E2Y5gcZCcQcl3jjwhnfxWMOCjvgC/2qc3L77xRPDIOkLCG65Q99
        uBkBJWiG2hQMZB6tlnM4ZA==
X-Google-Smtp-Source: AAOMgpdQxSFL91Wnd2joiiCuqXqTTwUNOSlSqbO4BOQNsAwQfmmRxvwmmdcWPsfjTbZSU8l1tNkXoQ==
X-Received: by 2002:aca:6144:: with SMTP id v65-v6mr14591532oib.147.1530909654485;
        Fri, 06 Jul 2018 13:40:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p2-v6sm8022444oih.38.2018.07.06.13.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:40:53 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:40:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 06/17] dt-bindings: display: sun4i-drm: Add R40 TV TCON
 description
Message-ID: <20180706204052.GA9680@rob-hp-laptop>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-7-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706175113.26698-7-jernej.skrabec@siol.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:51:02PM +0200, Jernej Skrabec wrote:
> TCON description is expanded with R40 TV TCON compatible. It is a bit
> special, because it is connected to TCON TOP instead directly to mixer
> and it needs special handling.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Please add acks/reviews when posting new versions.

Rob
