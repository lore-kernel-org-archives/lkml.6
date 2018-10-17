Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25ABECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981112087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981112087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJRD42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:56:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42962 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJRD41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:56:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id w81-v6so22118101oiw.9;
        Wed, 17 Oct 2018 12:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vRBNtr0Oel9vQ3H2vZYKPypBbmzkBI2MpMBMrykdGq4=;
        b=C1uGbNKFHLrbtYGTBslvghpKfPToIxmjdBMUQXr/I0O+PaYG75odAAOKIju+fp1Bea
         xMFKyogCyByUrFl8Jo+e5dNi6NU606fBWKCGHUQ1tpn3W93kl4poagWCqvj9n++U6fAy
         +vCX07VNDl/TKkoPDGqcGq24XAe78CxK1LXLFYWjctJHKoqy1TPMLb+eyIeBB1eVW+z0
         FUBbQEZcq57DJbmy5S7jXYkzD6iOxcyrKmeKShjKmyuMY7KwpXOUgG2jNWjG3b9bUdlA
         EAMm3cSuK1icysmqwGs+6L9y4/dOtv9qIxecbRCVUpEmaxYxbFuaxCRCWoNKL0KXHpmG
         vFKw==
X-Gm-Message-State: ABuFfojR+sBDa/x8XMay5i6BxDTr/V29pS6KZAqlEuWTGLfAm/BTN97/
        fnYnwZDtAA0HLW+3+dZLOw==
X-Google-Smtp-Source: ACcGV6293WnLc/mugvuOLKBQvXdnNLKEm0GRFSOaT7+vdpvn79I+Iyz7DmhiNUlNFEfFS3LWYoB65w==
X-Received: by 2002:aca:6257:: with SMTP id w84-v6mr13956131oib.326.1539806351251;
        Wed, 17 Oct 2018 12:59:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b8sm6250424otd.50.2018.10.17.12.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:59:10 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:59:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: uniphier: move cache-uniphier.txt to
 vendor directory
Message-ID: <20181017195909.GA13070@bogus>
References: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
 <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 13:25:24 +0900, Masahiro Yamada wrote:
> Now, the Socionext vendor directory is available at
> Documentation/devicetree/bindings/arm/socionext/
> 
> Move cache-uniphier.txt over to it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - New patch
> 
>  .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
