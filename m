Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CB7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8652154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8652154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeI0FPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:15:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45889 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0FPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:15:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id c13-v6so637799otf.12;
        Wed, 26 Sep 2018 16:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhFKhqwwYWIR+bNIbKqE3fMUNzt43/EaYVBPb3MQ854=;
        b=fTm3UOYYmzKSWLt7iqF76gEcvC2cptfUn06jSbIYEDQZW4pnINY1vDr7lpZXVC8Uc3
         f4tXHfoUtvWwd1U2+LFc3eKz4sfGil4k2DwxkHjq9CXfwtGu76ssIEbeHpqd5U2FwX0Z
         W3qf83v/3CRS58CUcZJT+e3SPVLGNSfbzz/TXhqswIdgEKhnGRgG508T5/zm6ZB8L2qN
         /aNmwXA0thE6wjKyG1rcVfpPgQPA4bKv6KUOgTXvATsf2kHpn0/owJIuqcWh3b3gcmM4
         n0NNbD7UqUKzLFUe4auu4GF21DulQiMEwHtqBEwyWbN/caYXSIBKyZSHX19edpluhdps
         AR4g==
X-Gm-Message-State: ABuFfog6ev7hn2u4w5kfYjOrUBfxj0n10kBUIKL+4EEs1qMQkEb3cWQ0
        7VM3H5FHYAYPwefUAaWFag==
X-Google-Smtp-Source: ACcGV638FDOT7uvBkFUe2EdWhu4GChMvtFYwEJFqwdh3o4jYjmBPcAsyA3+dLZ5Fcs3cCUwyJkFniw==
X-Received: by 2002:a9d:2b0c:: with SMTP id o12-v6mr5311025otb.92.1538002827708;
        Wed, 26 Sep 2018 16:00:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t82-v6sm24051oie.11.2018.09.26.16.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 16:00:27 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:00:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vijaykhemka@fb.com,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/2] ARM: dt-bindings: Add vendor prefix for Facebook
Message-ID: <20180926230026.GA26508@bogus>
References: <20180919164712.4030353-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919164712.4030353-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 09:47:10 -0700, Vijay Khemka wrote:
> Initial introduction of Facebook TiogaPass family equipped with
> Aspeed 2500 BMC SoC. TiogaPass is a x86 server development kit
> with a ASPEED ast2500 BMC manufactured by Facebook.
> 
> This adds an entry of Facebook in Documentation for vendor prefix
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
