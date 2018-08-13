Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84C3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA5A2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA5A2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeHNBsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:48:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38607 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:48:07 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so16933614itb.3;
        Mon, 13 Aug 2018 16:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1FZFPe9EB4fk0b8TTMlKNaTyFAxm78F+mtmK8QQSKY=;
        b=P4m6qnSZfas3+WPFNPOpkUtcNjubnDSJQJjb5tnOFbg75r2C74am609oOZvRW0B7Xy
         d2+bYIY7sbqZxKxXTJxxEMQssklekTyNtOtmghT23+EdZ9evB/MT9RO42WskKGA5GemJ
         c06pKV2ZbwNe49M5vjNXWaz2aGRgX0S5Qe3seEbdqwGQuHkYvdM3xNFNRIAvUiTeUqaP
         bGG9t7EHwsL+OirpmIJ+PA0dvfWzSRHJp7iL5O75oxs6LewHPVgNdoF7vQZcCaONDTaF
         hNbzu6evJFiz/1TiHI8GWBE6mZujxAP+TvbgJ2yfnB6PPB1JIZ4134pZfZy9nKGjbZvo
         uutA==
X-Gm-Message-State: AOUpUlFPEH3dQ1WsdyzfnZSXgrPTKk+Rw8cobWi7uC2RIsEXxh0UFYXM
        ZH/gJH9TukQHGG0Q1y0zhw==
X-Google-Smtp-Source: AA+uWPxjUioRX5aOqXtbd/CumbQmfTDxOrm7H3FKwBVrZdKpr59ep7NGQQKJgu3nQTwkxxqAf+CKVQ==
X-Received: by 2002:a24:f6cc:: with SMTP id u195-v6mr12462992ith.47.1534201426670;
        Mon, 13 Aug 2018 16:03:46 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 132-v6sm6012956itz.10.2018.08.13.16.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 16:03:46 -0700 (PDT)
Date:   Mon, 13 Aug 2018 17:03:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: Add CDTech S043WQ26H-CT7 panel bindings
Message-ID: <20180813230345.GA31714@rob-hp-laptop>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
 <20180730231117.5631-6-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730231117.5631-6-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:11:17AM +0200, Giulio Benetti wrote:
> Add documentation for S043WQ26H-CT7 panel
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../bindings/display/panel/cdtech,s043wq26h-ct7.txt  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt

Reviewed-by: Rob Herring <robh@kernel.org>

