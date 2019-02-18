Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4062173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfBRKfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:35:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34145 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfBRKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:35:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so9696831qkc.1;
        Mon, 18 Feb 2019 02:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31I98wBtG46flOMCHX35G/QXOYiz0ypU0MPiC/Bt+QM=;
        b=luM5JNWCJhkgCAXO5qRMt8q47Cf7I145hC7ZcbmOXJCf824MjLrGjrKEBIR0lkM9WE
         Rla8iNLHCO0OBBuCOqwhB2KI5EkApAaCU8LoXWiOE+z3cN22tPfOwoJD66+WzVH5vOUu
         TaMfPwisU993h1Lp3RdiCTzr8l85kOPtAMQXem9EmICw+B5IeoJjP8/PrvIRKyqiqRIQ
         u5qhaCmf/8F327x+Jf9P8Hmiqc9DYDRdg9dJSp8/biWVv6SWPzx9JN1vEmcRVUIaaa1F
         RyXYK7LU6cVQCh/sLWf6A7QUkrQ/0pMom4NRy09+mHuvbLhqhjjKizG8BKA81dU/Tmfe
         Va5w==
X-Gm-Message-State: AHQUAuaoZ7LeBYzFVtsIgx3ayqasTOEZP3Wiw2eFyIQomlu/lL/EuBvs
        4+Xq28YEF3EvjBQOew2u6MaOgJzJWpr+sDM4vnU=
X-Google-Smtp-Source: AHgI3IauOpRdgVsOn6T1pujqDnnxhfgsw/2bJs3AIN21nasL0nQnv3TMZV7J4+MgCn/uiVFTZlo8nuhlO765esRY/ng=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr15376077qkf.107.1550486106166;
 Mon, 18 Feb 2019 02:35:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550060543.git.baolin.wang@linaro.org> <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
 <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com> <CAMz4kuJ3-tjXUKk0Hcr3gJLRNmg1REe4NPm3AaXc=Nq21AKzZg@mail.gmail.com>
In-Reply-To: <CAMz4kuJ3-tjXUKk0Hcr3gJLRNmg1REe4NPm3AaXc=Nq21AKzZg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 11:34:49 +0100
Message-ID: <CAK8P3a3mpr1CpdwPEjGyigTFgqP4gVxQbpW+qypv1kaYskLBUg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:56 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> On Wed, 13 Feb 2019 at 22:32, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Feb 13, 2019 at 1:34 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > Remove wildcard compatible string.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >
> >
> > Looks good to me. It does break using the new dtb file on older kernels,
> > but I suppose this is not a case we care much about yet on your
> > platform, given that both the dts file sand the drivers in the
> > kernel are still  work in progress.
>
> Right. Thanks for your reviewing.

I have applied patches 1 through 5 now. Thanks,

     Arnd
