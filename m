Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A12C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244472087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244472087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeH2CdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:33:01 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42360 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2CdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:33:01 -0400
Received: by mail-oi0-f68.google.com with SMTP id q204-v6so5779222oig.9;
        Tue, 28 Aug 2018 15:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E81wVRhpYZEHiV82Ih0yDVONX/uuy3L7JAdDO73DnsA=;
        b=sT2obsFl1pQeWCA3WwqQe8Ox2XuyaiA8XTMcLLwgQF5OEXokEzStnmq76sw8DbPaQ+
         0uuMyTLVAh3H0ehQG85ZCiQ3cI6LhMHWY5E+zc5CyV1xpxdDl6v/Ga2Jq1gyGjTvsOii
         nsdxsIMrVTaLYMDELs4WIewO89TRzB9Xdn9AFFp2bcHgxKtwL3EjpFsVBDobfM9aF46r
         4BASsNwkxODRK+EBzbXCoAf2dM5o4JOMG271OzaCE4TMaQNjh3o8P7RfuRGVqGLzneUL
         jV7ghusEDvsdXrshbrkdbMsMCIpGOyfSXWIezFu68P+gNQPQ4JAV2l548q7+1cya1hzD
         zopg==
X-Gm-Message-State: APzg51AXQ6wHz0cNCiFW+JLtJaCTjf4WD/HMcrWtie6AJDkSS0j63Y91
        ssvYFdqvkY/pO9sUq1CdcA==
X-Google-Smtp-Source: ANB0Vda30Am1BMyfCLrBp2sTNHBOYIA568Y0dGUPh5Rxau+eWv/UHrrWu2sLG2GimYJbwcVxLcXXaA==
X-Received: by 2002:aca:c141:: with SMTP id r62-v6mr124900oif.179.1535495954765;
        Tue, 28 Aug 2018 15:39:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x126-v6sm1863685oig.15.2018.08.28.15.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:39:14 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:39:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: soc: amlogic: add meson-canvas
 documentation
Message-ID: <20180828223913.GA24233@bogus>
References: <20180823114954.30704-1-mjourdan@baylibre.com>
 <20180823114954.30704-2-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823114954.30704-2-mjourdan@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 13:49:52 +0200, Maxime Jourdan wrote:
> DT bindings doc for amlogic,meson-canvas
> 
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../bindings/soc/amlogic/amlogic,canvas.txt   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
