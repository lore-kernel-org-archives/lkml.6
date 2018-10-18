Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC95CC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EF22145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EF22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeJSEbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:31:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34661 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:31:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id v2so23966088otk.1;
        Thu, 18 Oct 2018 13:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYIVpBfVqex1BPS8gWoFmmYU53Q717NEp1I9M9V6zLk=;
        b=Uvs6wDJUh2X5ZpjZ8ZbNL4T8ul0h6q3SE+Coyl31rond+qZ69QT/qcM+UKKVh53gPl
         WNeCAKLwYx+FljuSnyxu5wOiYzcWfOIFF4yTJ6tiFflqZD48P+UikCHSbW6ZPDJd68vI
         0iT4ys60WX1FvrlM9ImnkJSMgkN65+CII3FQCoSxZqaeb7tDifFAwFvMRvRm4cFnT9mx
         PH2QiTSeHepxuUtaSqga03LjwtJfvJHNIUFlCGBQTlhs6N6Pss2M0lYwAVZj3Os2LPBn
         KzUF9/tg9S2+OU2UMMw7EfxL5TC9pa/aRYlq72TO6m2BHzlfys3m/RcE6FDI1Fs2UCK0
         T+mQ==
X-Gm-Message-State: ABuFfoiyU+7m0JzNwYdIsyp8NQ1Ke5aEd9BSgkJm4xczgrz04ePzq0Cy
        4JVipBmllBa9IelZXTQOgA==
X-Google-Smtp-Source: ACcGV61BmTMjUL2OXSY5vsLWeE4Z3dS6JEa3sWt2egEnnn1jAiHu/JSVgkVQf2Cg9IsYskIuiCTBIw==
X-Received: by 2002:a9d:5a1a:: with SMTP id v26mr9740486oth.267.1539894537950;
        Thu, 18 Oct 2018 13:28:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k68-v6sm7463413oib.35.2018.10.18.13.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:28:57 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:28:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yuiko Oshino <yuiko.oshino@microchip.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        m.felsch@pengutronix.de, Markus.Niebel@tqs.de,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v3 net-next 2/2] dt-bindings: net: add support for
 Microchip KSZ9131
Message-ID: <20181018202856.GA12458@bogus>
References: <1539889562-21458-1-git-send-email-yuiko.oshino@microchip.com>
 <1539889562-21458-3-git-send-email-yuiko.oshino@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539889562-21458-3-git-send-email-yuiko.oshino@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 15:06:02 -0400, Yuiko Oshino wrote:
> Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet PHY
> 
> Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>
> ---
>  .../devicetree/bindings/net/micrel-ksz90x1.txt     | 28 +++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
