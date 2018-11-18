Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E781C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FC920817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeKSGov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:44:51 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40117 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeKSGov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:44:51 -0500
Received: by mail-ua1-f65.google.com with SMTP id n7so10016801uao.7;
        Sun, 18 Nov 2018 12:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l9eZ/e9RzLUOIi/t/XOyE5aoYvNqElvkQY/X1nbd9U=;
        b=rXzocli57vStvDNhoBVtOqekLOIXUDbyo+TCa35jIBGaEgUQ6THnXHtsohDjhfHN8m
         qGP1SuVRvX8p6XwW4QwP1lZfIQjbL7ghyyWOhJLydCLfagRXoTeSWD52zKOz88BmQECi
         yZ+tn3kOlNkc1P5TeqoFXWdn4N6CaCt99fWUis2z8r/C93VYO5MUisQRMavJiAiWVg0z
         9VYSlswclce/2P5p1ejZTjL3diWUSfNmE1GBDuYS4+bFOhSvq6OCKy3iXCrPkbsTE6QO
         e12iXGREMdn/DKke6xNJhncTX4Ybl7WDQswH46RexHPhhjJvfXTVhyBdSc9rEA3wZTEh
         Da4Q==
X-Gm-Message-State: AGRZ1gIElDMzB9nC9wl7BnMNpE42X/YaeujmEdk/dMGKTbMxWA/qcnvw
        LHmTrp3oB0BXL30Vuy/LTHutYn4HlI1m6i7iiTzc8A==
X-Google-Smtp-Source: AJdET5cuewit9gSD8vLx5MRLZffOXqhe3v2HVv8CIsmW3ZLIXAn3CUNUR5nuJXJEqlw8dYC3o739FaKfSKh0/1BXa3M=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr7949344uad.78.1542572615555;
 Sun, 18 Nov 2018 12:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20181106222750.12939-1-aaro.koskinen@iki.fi> <CAMuHMdVCWLmyS+rFEQBHFGTpkw2=xk+Ub9VCnaobA+L9vGLOHw@mail.gmail.com>
In-Reply-To: <CAMuHMdVCWLmyS+rFEQBHFGTpkw2=xk+Ub9VCnaobA+L9vGLOHw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Nov 2018 21:23:23 +0100
Message-ID: <CAMuHMdUxTycDXo=i22JLxwv5oMXLQBB5iG2eszH1ewvJ1UVXrQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: update OMAP MMC entry
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        ext Tony Lindgren <tony@atomide.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:21 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CC Jarkko (from his last patch)

Dropped. Apparently that address bounces, too.

> On Tue, Nov 6, 2018 at 11:29 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Jarkko's e-mail address hasn't worked for a long time. We still want
> > to keep this driver working as it is critical for some of the OMAP boards.
> > I use and test this driver frequently, so change myself as a maintainer
> > with "Odd Fixes" status.
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  CREDITS     | 4 ++++
> >  MAINTAINERS | 4 ++--
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> >         v2: Add Jarkko to CREDITS.
> >
> >         v1: https://patchwork.kernel.org/patch/10369861/
> >
> > diff --git a/CREDITS b/CREDITS
> > index 5befd2d714d0..84cbec4c6211 100644
> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -2138,6 +2138,10 @@ E: paul@laufernet.com
> >  D: Soundblaster driver fixes, ISAPnP quirk
> >  S: California, USA
> >
> > +N: Jarkko Lavinen
> > +E: jarkko.lavinen@nokia.com
>
> If this address hasn't worked for a long time, what's the point of adding
> it to CREDITS?

That point is still valid, as the address does bounce ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
