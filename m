Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21384C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFA32171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFA32171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeHNX35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:29:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42394 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeHNX35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:29:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id g6-v6so8777055plq.9;
        Tue, 14 Aug 2018 13:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=583jMnOn57u8jHQSMoLhUSSz2JAv+ll3DR9JsetUh68=;
        b=qtjBBvHCkp2ATHWn7KX3XkbHZrfONlnZl6JPyD2/VYDshqJE9P25TEewUZ0VKBFLt3
         UAFdYfqPg3PshyfZ63YULAE0AotwWR/vyxLN4mVecziufUxMjefHtDCqODL8sEsftSRz
         CqQMxtQprSiR5OgYi52KE0nNRyQCtAfzQhoFU9Qz9I1JV9LeQlW7QhAexTY1SlzRzCO4
         ejN0+xloLgBsOAyfrhOLnHPDT0Rdq2vpaFfIxCBTxMi1oyxjaeCVr1pk+55CG8mi/v16
         iCGIsZN+EjntpzQjwZaKRLepiODu3VP37eZmOSwdfdwGdmhMxoBajvGUAXopGve1VxdX
         X4oQ==
X-Gm-Message-State: AOUpUlH4DgdyRMuP+yyCj+lTQhOiC67RoBWwy/zzdI+LTdNuUv8NoXFt
        xGDkOmxJh+56B7oFM4LMcg==
X-Google-Smtp-Source: AA+uWPyNJDR7C2DiWDVlK1EVYNivSjK1ImRyUVFbHh4EbZTztUFYSfND6iQGIHr/EQFHClBdIRefKA==
X-Received: by 2002:a17:902:704c:: with SMTP id h12-v6mr21581008plt.237.1534279262001;
        Tue, 14 Aug 2018 13:41:02 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id v89-v6sm60434571pfj.22.2018.08.14.13.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:41:01 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:41:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: dsa: Add compatibility strings for
 Broadcom Omega
Message-ID: <20180814204100.GA750@rob-hp-laptop>
References: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533661364-15381-2-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533661364-15381-2-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 10:02:42 -0700, Arun Parameswaran wrote:
> Add compatibility strings for the internal switch in the Broadcom
> Omega SoC family (BCM5831X/BCM1140X) to B53.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/b53.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
