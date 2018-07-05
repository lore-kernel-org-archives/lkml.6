Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C61240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C61240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeGEVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:19:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45387 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbeGEVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:19:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id m2-v6so19571186oim.12;
        Thu, 05 Jul 2018 14:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EsQebr3udysgXlZiMxuMbELXnocp/SadyD4JSVxCpH4=;
        b=PNUhNzcT4GI2iA2VL99ZBp2arpln5bXYeeuUWKeBFCAb0r46IVomCztM01exAt+vAs
         fwF1yxrPlbszELHfHQUGZIGSzzQcNlsKZIlIQXEK1xrW9W2t+k022H9IMeIkcBjQ/8mm
         yQlqmBYC/HBfux8gn1vESPPiA+3X/UrVRweA+s8fKS/cYcCaXo/L8YTBDygX7QNzGoN6
         IsFyPfTiCzPGkEyaJNtG83yRXj2/X4WCMrlYsRZCs/hRewngI1NAq+oaJMEeiJ7/gBXn
         bm4R6lhNb5t7IjyCepQZ4OehV4yzG0+LSqMG5RsUrKVkg/GPHjGtZzROeRCjVaeJcaVC
         3n0Q==
X-Gm-Message-State: APt69E0pdhwkRTfKP+naEqrQ0zVonVOAIIu7WKoUBQrB+W8njyGPhyvk
        Q2YFQhu6kzL4j2ecxOO+zQ==
X-Google-Smtp-Source: AAOMgpdpSYPOgpZfVLEtjm5isYX4EHAMrppcC1P3U3ldZX4fda5gIfqg7lNJZGDBLjvVwaWVbpypmw==
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr7870775oia.154.1530825540404;
        Thu, 05 Jul 2018 14:19:00 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id f16-v6sm8085800oic.50.2018.07.05.14.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:18:59 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:18:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180705211858.GA7441@rob-hp-laptop>
References: <1530714773-18956-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530714773-18956-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 05:32:53PM +0300, Stefan Popa wrote:
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v5:
> 	- used a dac@0 as a more generic node name instead of ad5758@0.
> Changes in v4:
> 	- Nothing changed, just to follow the patch set version.
> Changes in v3:
> 	- AD5758 can be both a current and voltage output DAC. The
> 	  decision is made based on the DT and the channel type is set
> 	  during probe.
> 	- range was replaced by range-microvolt and range-microamp
> 	- dc-dc-mode, range-microvolt and range-microamp are required
> 	  properties.
> 	- Introduced a slew-time-us property from which slew rate clock
> 	  and slew rate step are calculated using a best match algorithm.
> 	- Added units in the name of the properties.
> 	- Offered more explanation for the various modes of operation.
> 
> Changes in v2:
> 	- Nothing changed, just to follow the patch set version.
> 
>  .../devicetree/bindings/iio/dac/ad5758.txt         | 73 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt

Reviewed-by: Rob Herring <robh@kernel.org> 
