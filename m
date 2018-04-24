Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3668840-1524603415-2-2378456579602691425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524603415; b=S+oD+FzRCJrinLXjdYc5ti3aldJB01NpGrQZWtNqHJm8OfPOvx
    /onXq0rA8yZ/vwdBqUs0oXstislBbaU2GBLYTrhL48p416bAxi1nIorkpUgqkZF5
    pct1ZUPDodHDOvKhfKDD6geUrMtxSDyNqmOwqjaPHV2v2uq2PzRxhX87oTsXy0Fu
    8veGf0ZKMJ3kNtvOhDeAS6c5faFOpOor/Fy4A+HCl8pc1mOGW1wmUcn0eQmOp2re
    wD+lrPZ213dVvLeOdbvxBGCkUguBWCL8oNP+YSVGw6v62VoiXAR4QVk8WeTUnvOa
    sdrHJeMDdp1Bg4qGWaW23/gfuZqSrM0gGDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524603415; bh=hk6tFAAYj+1mdKGJsriOxl3Svzr8dE
    lmwYix1f2vxxQ=; b=LsQouJpJ/j4L133xy2Gbzz/Cz3E8UBwEQ5JVLnIxruABsg
    Xq2/+zjhUf3O5Jxgno5GJRyh+y9vCJAtAY/v45PQFvhtyDlWnKCrev+lPImY09py
    nXXR6Kk+zNOMl2qCRgbYCuyR2VRNTTqLmFDutVeb5silV5CnzwFTv4iKVESUfb8H
    o8rSzd6sVruXVQafNCu6nJk9BocaUAKtUizID+zoJpfw2z2wgR6U6wmIAxRAnnCf
    9SCb/BA8g+Tpir4mSrB8tXT5UBdSDHvLj+GQSi/IyBdB34hFe4jVzXdmgcg2VAu5
    XjLiwUgVc9X1/YP5149ZiqtbmXcWX48yklszga/w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BAdYFiPC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BAdYFiPC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDWDhw5h5TiWYPczNuioVyWL36Kl5gW2/68NUXgbR7/X4Fa8vKFS/4/p//RMie6KuA/METzLPILQejD2MM0uiLSuH7paWfVwNAmFAnpI9PbpSZbuFxg9
    PYSc8WeXDUvZsIf9sv8xcV9ynh8R8ztJbtU7wR3gfoKQlmh/HEgEy5LHhOG1jpJbXdUVDCVDpcgWvyjqG7rA9VatQ9ywCk5BbEr9lIjnFnb+QvJ+QtibSR6Q
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=KwgaByte5vuy8mZOQR4A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDXU4t (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 16:56:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36221 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDXU4l (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 16:56:41 -0400
X-Google-Smtp-Source: AIpwx4/AR3uuD2lZAMXafigzGWpMCxutRJPKQn3aoTTajaZrLdbamTa//lJ8ZaTPhiUGS0era/BUQQ==
Date: Tue, 24 Apr 2018 22:56:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
        <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 00/10] ARM: Remove support for Exynos5440
Message-ID: <20180424205636.cdp4czq6hhs5gu5a@kozik-lap>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CAK8P3a2CZU1CYFt0fdVSFFnj2Wg=mUcC=yuWAW7zDO0u2Q2dUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2CZU1CYFt0fdVSFFnj2Wg=mUcC=yuWAW7zDO0u2Q2dUQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:50:58PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 24, 2018 at 10:32 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> >
> > Overview
> > ========
> > Let's continue the removal of old platforms. We already get rid of Exynos4212.
> > Now it's time for Exynos5440.
> >
> > The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> > server platforms but it did not make it to the market really.  There are
> > no development boards with it and probably there are no real products
> > neither.  The development for Exynos5440 ended in 2013 and since then
> > the platform is in maintenance mode.
> >
> > The only development happening around it is the PCIe driver for Exynos5433
> > (ARMv8). [1]
> >
> > Removing Exynos5440, makes our life slightly easier:
> > 1. Less maintenance,
> > 2. Smaller code, less quirks,
> > 3. No need to preserve (imaginary) backward-compatibility for Exynos PCIe
> >    driver (so it is easier to add support for Exynos5433).
> >
> >
> > Because of point (3) above - I left the PCIe and PCIe PHY drivers intact.
> >
> >
> > Dependencies
> > ============
> > I think about starting with removal of DTS in some kernel release (patch 1/10).
> > Then all drivers can be removed/updated - subsystem maintainers can pick their
> > patches freely.
> >
> > Finally, after getting rid of all Exynos5440 symbols, the last patch (10/10) will
> > end in arm-soc tree.
> >
> >
> > Any comments?
> 
> I don't see any hard dependency here, if this is all unused, I think we
> can apply both patches 1 and 10 into arm-soc at the same time as merging
> the other patches through the respective subsystem trees.

The only dependency is through Kconfig symbol (SOC_EXYNOS5440).  After
applying 10/10, which removes SOC_EXYNOS5440, some automatic code
testers can complain about non-existing Kconfig option.  That's not big
issue because all this will go away so indeed we could take everything
in one release.


Best regards,
rzysztof
