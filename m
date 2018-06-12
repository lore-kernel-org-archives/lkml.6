Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF385C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F36E2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F36E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934437AbeFLVxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:53:42 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37879 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeFLVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:53:40 -0400
Received: by mail-yb0-f196.google.com with SMTP id h141-v6so187069ybg.4;
        Tue, 12 Jun 2018 14:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIq1eVW1IhgFrlXI/9bV//HN+Pcqqz7HxjRnmQISeM8=;
        b=s8Jw6GnPEVKXnWWTwtrCsrELG8NymI5ujApy7787BdHtUwE+3kDyJviZjRq7wh6GT1
         rgLgy7BG6VZTWd2SKT5EyL9gDek3q7C7zkZ1ztCTVyRuZJ1SUmZIH25YVLcmgNdKCTOB
         IT7o5zkZTbgAbTIAIFyDI2MaOSZ6Ku6L1DMZ9KPTGC/Qaj3azQnKiBdID3GUxfGyTvTV
         xzpn5M+CyXVXmUVdjbfjABlKkelvP1NW1U6cReZAPg0uoPIF/rRMTiCMkLyJZMHonT3G
         YgcsNwWebPlbG9xM4vBsYyFGvIol4lFkA9MN8errCIQfaKOdUmNHEkrLHEmFiZq4PwZ0
         eapQ==
X-Gm-Message-State: APt69E3ZbLB4Kn9gkGKT7JY4ylOKpfxquYRJ70zFsRnWx7lu+6vcWVY6
        aEXJkmBfCER4gWR6iM76oA==
X-Google-Smtp-Source: ADUXVKKFj3bm7gd3WY7G+Wb5VegeU+qNpOqGav17Exhelslxvut1N70ZHbpmptnOU8zOePRFpsvuLw==
X-Received: by 2002:a25:7e05:: with SMTP id z5-v6mr1153186ybc.442.1528840419636;
        Tue, 12 Jun 2018 14:53:39 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id c73-v6sm536207ywa.41.2018.06.12.14.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:53:38 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:53:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: remove PMC bindings
Message-ID: <20180612215337.GA6569@rob-hp-laptop>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
 <20180607084107.4461-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607084107.4461-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:41:04AM +0200, Alexandre Belloni wrote:
> The PMC bindings are fully described in
> Documentation/devicetree/bindings/clock/at91-clock.txt. Remove the
> duplicate and incomplete documentation.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
>  1 file changed, 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt

Acked-by: Rob Herring <robh@kernel.org>
