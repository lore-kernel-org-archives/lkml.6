Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76916C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3840520877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3840520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeIYW5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:57:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45955 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeIYW5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:57:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id d63-v6so2076195oic.12;
        Tue, 25 Sep 2018 09:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jOI+jxwxkhYwmQ5mVYYt2xPasjFgaPLtILUC4RHyioc=;
        b=jDvhKNgFJtSvS/hzZ0FTZNjhD1Ze4NdE7yJxU2pJbDyYwG9SC3ca4hZXPv8xgjiYO/
         9i2XWqqiDFkiibIoS7bKV6msD4BngAxW9gVyf4imVUZmT2XJ2S0SFIIQrDrMYF/124cP
         RiaOodD5a0XyZU03hpYahG/PAlMKALQslrgsbiWJjX4X+mfd0G7qZLpOWsBqsIugl2oB
         95xMGFqULgXfzfypPQACGgCCdlJo8xld4m02V+MBy1e7OesOY6/hSvcr07XnMwmO5huK
         a88CfOu9nZXp5drtG6jzOiPkZ+rFMEKtmj9Rk2jHIEa1X3WOXUXIJULs9IoAfr4J4E9i
         AWbA==
X-Gm-Message-State: ABuFfojZK3BmoDV8tmhY6vRwfLdd5+6UvzKQ23BrCWxr2KyT4OGbjvWo
        pmZHaXx9iw35PI/+HR66hQ==
X-Google-Smtp-Source: ACcGV63+O6owMOWXD4mvLcE3OBfFrWlYuXl+8AuBiCA0zbp5PdWFhWhorybchDysXwRfftKjXAevDA==
X-Received: by 2002:aca:bbc3:: with SMTP id l186-v6mr1173497oif.315.1537894121299;
        Tue, 25 Sep 2018 09:48:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a29-v6sm1157379otj.57.2018.09.25.09.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 09:48:40 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:48:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaobo.xie@nxp.com,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com
Subject: Re: [PATCH v1] arm64: dts: dwc3: Add description of
 'configure-gfladj'
Message-ID: <20180925164838.GA25852@bogus>
References: <20180829073324.36866-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829073324.36866-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:33:24PM +0800, Yinbo Zhu wrote:
> This patch is to add description of 'configure-gfladj' to binding
> so that configuring devicetree

Not a complete sentence.

The subject should be: "dt-bindings: usb: ..."
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 3e4c38b..40c6568 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -101,6 +101,7 @@ Optional properties:
>  			When just one value, which means INCRX burst mode enabled. When
>  			more than one value, which means undefined length INCR burst type
>  			enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
> + - configure-gfladj: determine whether frame length adjustment is required or not.

Needs a vendor prefix.

What's the type? bool?

What determines if this is needed. If fixed for an SoC or IP version, 
then the compatible string should imply this.

Rob
