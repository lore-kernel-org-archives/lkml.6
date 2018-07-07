Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6817EC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBD5223C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBD5223C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeGGIuC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:50:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39569 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeGGIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:49:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id w14-v6so10275528eds.6;
        Sat, 07 Jul 2018 01:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9lKIQiQFR/nkyRqY1psb+OdkglL7P2wM7KLJlmVY9Co=;
        b=L7CyfGIDElCwrUGKpEvZy1eHd/AOH7JMGVWapRnqI05u6yKdDYpxWw3cB2sEBmSyNv
         jUHwC4Q1vItqKOqK/jp/CLKI+AJc/4j6ea3yN/Wwuq+DldGHt6x1HRH9HhnE+MMK7YUT
         wrVUr5z+KWZQoW+mEhJHiuOXEKK6DdR/rxVSNVyeJhY8NBt5AWimotIJNj9ecHb2HLPN
         jBVsHROWEG3bMg/xEM6y/PlVhnEt4yl7giFoj09HQbGZmkOHP+bZk7VBXs2SgGyxcky0
         UqTJlxVLUSLBI+A85PLF1++ZRE8gk7FxH5F9TXukUOFpZ8NvJD/1Bl0Ss9yqYbSK0o9f
         c8ig==
X-Gm-Message-State: APt69E2Ccl5CPdmBHMDnQzEjfmCiQUxFaK/5Wc7vRxdfXQ3zlrnNoGzA
        fg9zKMbInOlcqK59zXnliwo=
X-Google-Smtp-Source: AAOMgpdt82aV8InfSayBiqviW8TdrAVFfnz3yk4esvrly8Zqr8pn9xUg5PpfrUKVtWY+ADhYMJbc1g==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr14758134edd.30.1530953397612;
        Sat, 07 Jul 2018 01:49:57 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id y99-v6sm3404606ede.18.2018.07.07.01.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 01:49:56 -0700 (PDT)
Date:   Sat, 7 Jul 2018 10:49:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v3 9/9] ARM: s5pv210_defconfig: Enable options needed to
 boot typical Linux distro
Message-ID: <20180707084955.qsurxetcqafebazn@kozik-lap>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-10-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530901970-14972-10-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:32:50PM +0200, Paweł Chmiel wrote:
> This commit enables few options which are required to boot
> typical Linux distro. It was tested by booting ArchLinux ARM
> from sdcard.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

