Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841C0C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E25218C0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E25218C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeGGIq2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:46:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38322 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeGGIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:46:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so10266370edt.5;
        Sat, 07 Jul 2018 01:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0mTqHB6SnnsD+8LWDXoUG8RLoSoCsid5o7gZpSAV7Pk=;
        b=D4zsEMhChLaEvX4kCO9grPdr+qvxFJYU9n/+k1Rz8xanW20Ivw4axUt9Z0IfjhaQVn
         RNKMY0GmqcXCBVCGkEgz3Hp7F4TDXyhQaQqPh+7red4md46Al9o/pZR+RzDGg9WY6OLf
         Rpw5NuSRewNa2uJKEYNpF2b6lVQ1W+PFZDzCSUdDGzcmOegLAol2qTbsye3yyyoi/cYb
         g2CdNhAYCpg3ytusbVDwCo+mfTxCWrz5PDomsz/NzqLjzCF8heknaoMjE3Y1RHLPVm3e
         kS/mvX7aN0s/xPpJQKsPDvlS3QmNm9Ig2EMzCagr8RSPA7TRQ5QkNnSU30xdZcnE5tkw
         SMzg==
X-Gm-Message-State: APt69E2l7d+UBsOfLBDjRgCaOwFMKZ9tEM7Oynsh0JhaygGg1Pf9N30d
        PXUxgkUGVdkVOMzMLK8V7HvPt83v
X-Google-Smtp-Source: AAOMgpecwyISrozDx/SdleLxJRN+JqTMnA6TdazTPTH9daby2LzZXneNnrIhRiq1i4mKsMk3j0qtgQ==
X-Received: by 2002:a50:b134:: with SMTP id k49-v6mr8903929edd.55.1530953185331;
        Sat, 07 Jul 2018 01:46:25 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id j9-v6sm4050033edp.72.2018.07.07.01.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 01:46:24 -0700 (PDT)
Date:   Sat, 7 Jul 2018 10:46:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v3 7/9] ARM: s5pv210_defconfig: Run make savedefconfig
Message-ID: <20180707084622.b57vu5x73i7axvlr@kozik-lap>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530901970-14972-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:32:48PM +0200, Paweł Chmiel wrote:
> This is result of running savedefconfig.
> It's preparation for adding support for Samsung Aries devices.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof

