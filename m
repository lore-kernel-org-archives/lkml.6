Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3231568-1525183667-2-16333034746279430286
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
    1525183666; b=VAhvngYpU5H0R+wpZ+5VCOrZQzIMnsS3gEX8TjJdUMI8J7CcAF
    Lk38tHcR6nL0wuYHADT5TukNAGtdmXtBYWXboalejrJ6HZbjNfSlnlh0VV0q1QAw
    8qeNyOGGZAmnTH0+lCMyvWK5xP4DweJDzNm8tWZVS/MPoVT4TB/GHmqOPUNdD0+j
    KGaNNbWi4j/tHwpOcwQn4v05bUl3sNk9zazQswzEVIK6yZ+YO3aeA/P2t15wWMau
    ed9KXWkkrb7tjM/yBmvUn1aubkpAl2MFojmRVONlRszHa3/1/VE084JIejtYSnOu
    VQO11G0kxSfvLLhJD0T6n7nOQJnMRbGaCuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525183666; bh=bcJ3nPy2zUjo+dTXRK0ok84mLUJcvK
    vex41GOHL4O+Y=; b=Y0TNcxxQTsGjaO3Glybwg6T3SMGsSf0mLIFZCS8vQLqX0B
    B2t1BVtSwNUmDipas0LfTKSu+U8NsECMQN/q0d1nHkvAIxrE6mqdP5x2xRdUzOgv
    gj35s2Uymqoo4MbErP4EYRKvUjF8z/hWfYtHfTt+l2+qoj8xt5HT5gZSfYqkyJdH
    4aDDdsh9j3U3UynCZ0rz+i4TZQowcQq1x67VCEpwxiNhPTWoaKbEPCU8tg4XF4r1
    oJPj2bexwlaa8AW+gGuc1U7nnyGip669+uNtoBOaRhlZ51XU+WyNMz1p1H5NBn6g
    e40IYUP+KlL8d1W/MXEWQ9GHd7dLf5FiqyIYPtag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Re0ygFUz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Re0ygFUz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPcrwnPtyZhxfRob/TQ7SBY3grFrylyAF1EIeS65KtdmSI/y+Aqp9QpKBaRHKhHnOSP/i3xjeobUINAh6TOuAWHftaP+Z3gcJLmFNdL1n0ml9Db3d5/I
    yb9dbDXz0/zMEmF9weXOcfkk/OEKXhPDbd9O2OoofAPSBi0rMzu92y/G1GJnE2Ucs+5lOkCr05LO8Mri3lutGujzHIgt1L5Dp75J40E3oFnv1tS5a2UPvbFX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=HEhsBhvELOkTVMn1VSwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755186AbeEAOHe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 10:07:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41453 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbeEAOH2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 10:07:28 -0400
X-Google-Smtp-Source: AB8JxZr8A8Cy57weAlW8jXdgqKTpPDuQWVnRJBkt9M3eAHJf9l5BnDD6hXKJi8+8JyFr2gDs5C37qw==
Date: Tue, 1 May 2018 09:07:25 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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
Subject: Re: [RFC 01/10] ARM: dts: exynos: Remove Exynos5440
Message-ID: <20180501140725.GA25487@rob-hp-laptop>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:32:30PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
> 
> Remove all Device Tree sources for Exynos5440, as first step of removal
> of the platform to simplify the code and drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   2 -
>  arch/arm/boot/dts/Makefile                         |   2 -
>  arch/arm/boot/dts/exynos5440-sd5v1.dts             |  42 ---
>  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |  81 -----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 --
>  arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  21 --
>  arch/arm/boot/dts/exynos5440.dtsi                  | 355 ---------------------
>  7 files changed, 523 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
>  delete mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
