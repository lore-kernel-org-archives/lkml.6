Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3289032-1525185939-2-87361954657641369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525185939; b=K1moOyoNevhrtHuzhqHBjYEITjL4MYDg7+oYT2TFfAzPMSlh3G
    pG82LZPoFw9ic1eKYKMIJA9K4zfo9yQ510Ylgu6TgCBEKwRKcGbTwex7aQRg7I9a
    tqaWH3o+bdrxVGkwx+JDe+yrio3P6ZX1HeppbQp8ux18vn0JVPaPwezkRr2bFDoH
    SH66X/gygxHkAqyJNTYzR4PKZ53M4YQp3SC66nLQTgnS/y1KOlH3AA5VUlcXiArZ
    JYKAgU66JQWp+oVbPNbNCDmxVh3jBKlWZhrMtAve67V2+TIxsOtb6aSdC2Ftul/4
    2+zdzmaqdQSYZNxt1h3PjpJARwHPNe2TJhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525185939; bh=UOdsUe/kE1Fhy2xNI9a2tsxQTphxMh
    FrFoUBT83CI38=; b=BeR3pgMg/ztjpbSlI3Gm6uA3MrEAMlNufnOIchjJdfpMnk
    wpPtPfUcORJJKMw7koLJK+S5j4jekHAFeGpV0t7AcOmGtl//tzBIf5ghLobtR21f
    G+ubG3IHRlZY3Rgl40tK590yKKvqnKeczQRZex39XRy7rb00B5JNQsgMoIu0aZou
    GYYu1BtOzzGMakl2nUSqqQXWpst4AlLULLHrgF4v/NUWqkb07V1ILkwBWAZ/QnqT
    MSBPEzASMX5FcK/TBm+L2zMbGE/HDjLEFiUTUkHvU73NVlm3fPCEqV9+JiJtnKnQ
    hMfIN94al19kXpnDCD72M/P9lh3NqY1GcMPgcKkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=WUD5HkWa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=WUD5HkWa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfApTIEecunZSKRxoPNskDCXmAAebn6uW0K4vaTE2Ln7cfN7RRGXMBbT/aGFkgm3ZWyW5jk8b2w9YTZ//9rlHowp510uwAni8G8qZIbdeXtMs4j/ZfSC3
    lSXfVMbDiTK6scHbbY4LGw6+xqxXepd0+C8hLAt+Cy3LmUnAe9sAcTT6OKAd6PB/oaC8UY5RvcH/kuxl6mCN4/C49slyFsnAmigS9/MOUyeBNy2enJUsI9Ea
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=D19gQVrFAAAA:8 a=KXQFBCsgnY3szuWKRloA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755790AbeEAOpZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 10:45:25 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46149 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755171AbeEAOpS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 10:45:18 -0400
X-Google-Smtp-Source: AB8JxZogwQP8F8XYmuqoVYV4RCVqqA0P30YMzxX1xZJb+yL9EJzAG4G+mL40u7s6co+XN5bdxPS3PQ==
Date: Tue, 1 May 2018 09:45:16 -0500
From: Rob Herring <robh@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] thermal: samsung: Remove support for Exynos5440
Message-ID: <20180501144516.GA519@rob-hp-laptop>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-7-krzk@kernel.org>
 <1951102.VLysaozMLK@amdc3058>
 <CGME20180426112113eucas1p1b5bf6f093442154e29f5541b4aba6b00@eucas1p1.samsung.com>
 <2734003.UHSMxVLybj@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2734003.UHSMxVLybj@amdc3058>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 01:21:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Subject: [PATCH] thermal: samsung: Remove support for Exynos5440
> 
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> [b.zolnierkie: ported over driver changes]
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Eduardo, here is a version which applies on top of pending Exynos
> thermal changes (https://lkml.org/lkml/2018/4/16/256).
> 
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt |   14 
>  drivers/thermal/samsung/exynos_tmu.c                         |  161 -----------
>  2 files changed, 4 insertions(+), 171 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
