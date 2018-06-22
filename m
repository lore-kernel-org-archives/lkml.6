Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A5C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C589524877
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C589524877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbeFVUOy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:14:54 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41517 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeFVUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:14:52 -0400
Received: by mail-ua0-f195.google.com with SMTP id a5-v6so5046973uao.8;
        Fri, 22 Jun 2018 13:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnH51KZqoNTDjvy8pu7ivy0w7vw3RQxx9fBREhvBqvM=;
        b=qP6tDBJr9ZbvPeGIifb7Giqg14eNNSy9IwRqCq1ou4LK4n7inpKbiYVIsBWkQd739/
         MUSkIASNrvHaiJOr04p6AxBcpJ/7bq72UazZxqq72DWYr73mRbNQwMvJvGEUAujTI7/L
         Z+RGiYpXn6mXPTRIaIorvuVlTUafJqVkFC5k7GCwSyy8uNM3i9gr+JlQOpn737Z7sheq
         0GQ2mU07gopUTjZfPZ4b4Xl7+qggKLLtH45ReXDvVnTUMsLdgvkstHzgYBsGNlIORjEV
         FwwzoeMZ1xrEEtSbYumq5lxF4agnpCFIFnfwcAlJVoMXy0mSaCaIssyg6m4mWzSjNIfl
         mDng==
X-Gm-Message-State: APt69E32a5GlPQXVcxRomTKQstfqANxpAODU+Gvrf89cwd456Gt2kcxc
        RO0OEdFZnFJvuqntpVWfEVj5tZ4hTYRh9GvW7m/FYQ==
X-Google-Smtp-Source: ADUXVKIyBK2jVwDKuv9bFZ4C5jZcB3HYO8LH7jPt1QvnSutu+alF/jOHkUBtx6Q1qQRk57XLwIRiSUsNI28mPlPsYlQ=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr2169854uas.26.1529698492137;
 Fri, 22 Jun 2018 13:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180622100820.29616-1-geert@linux-m68k.org> <alpine.DEB.2.21.1806221753560.2402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806221753560.2402@nanos.tec.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 22:14:40 +0200
Message-ID: <CAMuHMdVkg3gOkykbZOzW2CpCd+WRdyKqehs9_WKQ8nbtSgwVgw@mail.gmail.com>
Subject: Re: [PATCH v4] MAINTAINERS: Add file patterns for x86 device tree bindings
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jun 22, 2018 at 5:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 22 Jun 2018, Geert Uytterhoeven wrote:
> > Submitters of device tree binding documentation may forget to CC
> > the subsystem maintainer if this is missing.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > v3:
> >   - Update for next-20180622,
> >
> > v2:
> >   - No changes.
> >
> > Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/x86/":
> >
> > -Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/1=100%)
> > +Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
>
> I assume there is no way to make sure that Rob and the device tree folks
> are on top of that list? While it's somehow x86 related most of the
> devicetree details are way over my head. :)

I think the order is from most-specific to least-specific.

> I'll pick it up nevertheless

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
