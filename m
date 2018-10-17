Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0AB204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0AB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeJRD5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:57:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44686 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJRD5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:57:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id p23so27453491otf.11;
        Wed, 17 Oct 2018 13:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vRBNtr0Oel9vQ3H2vZYKPypBbmzkBI2MpMBMrykdGq4=;
        b=KN4ZukaMwdGME4TvNUGDokT2HR21DH+YVd4ftdK5XWlG/lomlx6xVb+zWbYy4XzrAN
         T0EUw06QqF0rzJIcrUj+KThVE+H4HQ9yJyQjoBgSnLCpu8ViyJPy/S1Et8bfF0u3LqDL
         Ez7Ti0UOuA2aUxR8nHD5hKzjCQI+h4rLLkkYXg0Yf441rCYFe3izsm84RnagTfkMnuR7
         pz2biqCODdzeTdKwc/a321hnjflR9dPNYQX7Z4/nwsYrfMEYA7YOqMhoxBUVXyslkpgL
         W6WbWsIg5PxzbgfhlKrYNkNz+UnK1MxCA84MuoiZ6mwNSXougt0EWgGSE31ZV74qx9T2
         heSA==
X-Gm-Message-State: ABuFfohOB1vsJDU7+W+9fCRLYVz7ch7UYkB+X5uFIl1W/dlDgSCQmOPG
        Uiw1pK1pWG2MyPMiCiovsA==
X-Google-Smtp-Source: ACcGV63K2T7kz9Fujl9vFL1BCBNdxyGIaLQysmWMyD+Za43ilN8tSJFMDPLCS/0cR3lKgiEJHuM8Fw==
X-Received: by 2002:a9d:2087:: with SMTP id x7mr16908725ota.154.1539806424320;
        Wed, 17 Oct 2018 13:00:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r7sm6266138ote.9.2018.10.17.13.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 13:00:23 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:00:22 -0500
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
Message-ID: <20181017200022.GA14782@bogus>
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
