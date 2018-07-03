Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADF0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5EE24526
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5EE24526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeGCXBl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:01:41 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32979 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:01:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so1610478pgq.0;
        Tue, 03 Jul 2018 16:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fyTlYoRb+pxsqbzFXa2W9MrQp54noXMYG2w9Nyv+/0k=;
        b=H741eMlKJcTwrvW21PnwoCjb9l4lHfUYMF6X7jZEDTzn2Z8tK2st5fxpTs4XFru1QN
         uFXVnrn+BvYQQVYIARFOyXKYdAse1ihpjUB2uQiazn5UDU7NRjxg6VZQtmYSnQNCMS9k
         FZwXZWJ0Kiu/haBSiY3el57NYH86UzhZ9jxSRvVnGqe1wxOQWZXK59jq0kJXtvE4UEN1
         fr2xYSf5vQGUzRAnN0e45m21VylTgck8wcahJiA3avvPeR09IBo4fqYhtYgFWu5/c+QK
         l9hA7/Ue0w5Og6qvBmF77V1XtpxOoIggZKX9Iwo96hl5AEXOw2+Lq1iGkNT5Dv159g3X
         Wbog==
X-Gm-Message-State: APt69E0/FjxUGrL5mKIH3Ou5PhiX5YfCR9qqTecqCDjG2yRmKqBucTM2
        J/f4gevrC0huOUt94FD1nwusWKDiTA==
X-Google-Smtp-Source: ADUXVKIWrJhbDyGXzJD/Z7rUK3DgvP7E+F3vmyPdAYk7AMaMm7+Vvx1DJq2GGHeLEgj6ug/BcTXbAA==
X-Received: by 2002:a63:842:: with SMTP id 63-v6mr28002616pgi.406.1530658899602;
        Tue, 03 Jul 2018 16:01:39 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id w18-v6sm3444044pgq.1.2018.07.03.16.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:01:38 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:01:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for AsusTek Computer Inc.
Message-ID: <20180703230137.GA30170@rob-hp-laptop>
References: <20180627203315.348-1-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627203315.348-1-luaraneda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 04:33:15PM -0400, Luis Araneda wrote:
> "AsusTek Computer Inc. is a Taiwanese multinational computer
> and phone hardware and electronics company headquartered
> in Beitou District, Taipei, Taiwan." - Wikipedia.org
> 
> Website: https://www.asus.com
> 
> The prefix is already in use by at least 5 ARM boards
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
