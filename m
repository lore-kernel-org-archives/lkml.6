Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A81C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D620218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220842;
	bh=yRpEFpm/9aNq3kXZ+jM4+zKRZIkkBLN4eV4b15UvqBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gG0a7W1p0m1nTpg5L2Zsl7z+s7i0rAUlp4hgTuSB8xCJ4QYB22YioonEjeXz7JUTS
	 f9PZJQLOe/BX4u+v9E81U2gDzfcz+ui5Z0kc0KNMIf7f65GpZZkp/SyiqvdzTPQDgo
	 fVTQZrfZ9F33Ll87DO/fi/qXCTMU1r0RVnO+1Amc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfBZWkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:40:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35506 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:40:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so12653657otm.2;
        Tue, 26 Feb 2019 14:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DI+Ou/t++PHBfLwzYxmj2C74wQoyYIoI3rDGvSPlpZQ=;
        b=EIl6bCgoxrHMpvJqMMqRI0xRH0FBHPKlp93oX20FXA4sJtqOafpVYWX/U+aTy9mMAr
         UAWrMfVky0GajdjRinsbS26ZuYQraur+mglaLAPYUY3AmduJdj76XQLL6CqQIQ+QrNjX
         XN0/LksaiVfaZ0vSY99A3rCBRH7HA+hKHNKKoAgAsrH3ShBSgafd8Ew8vWj0TTtqf1yJ
         w/AXyRd/KwzVn48DXHyo1X/uluInN1/OkTx5UHN23bxAuf01n4To3hlhY2KYAuu3JhEJ
         aCOsURECyR6ReDsgjbyjSw7Xqc8upygSKjhErH54X4OKBZdjP6h+NJO2WOumWn4Y49Qr
         LpbQ==
X-Gm-Message-State: AHQUAuaLl18yyPxGWScEzrSTIUeOYnG8tQeZ9yB4Ax7/JPil+ZDZyLpw
        YX55ZMMdz0pd3roscSx/rg==
X-Google-Smtp-Source: AHgI3IYtFSqGzFH+NtuD5GuR/2X5Kukh6jarIMJvDoZo/+KLUOXGU+C/uS495q4SUi6KLY+2mP6tmw==
X-Received: by 2002:a05:6830:15c3:: with SMTP id j3mr178337otr.347.1551220839231;
        Tue, 26 Feb 2019 14:40:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a15sm5790443otq.35.2019.02.26.14.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 14:40:38 -0800 (PST)
Date:   Tue, 26 Feb 2019 16:40:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     bobbyeshleman@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: vendor-prefix: add prefix for
 Lite-On Corp.
Message-ID: <20190226224037.GA13824@bogus>
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
 <f52fc8ffcacc8d80796bc98959b49fe9b0237da8.1551037168.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52fc8ffcacc8d80796bc98959b49fe9b0237da8.1551037168.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019 12:33:29 -0800, Robert Eshleman wrote:
> This patch adds a vendor-prefix for the Lite-On Semiconductor
> Corporation.
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
