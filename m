Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666D7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8132087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfAGHft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:35:49 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33895 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:35:48 -0500
Received: by mail-ua1-f65.google.com with SMTP id c24so13892722uak.1;
        Sun, 06 Jan 2019 23:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLvS2IcyEP/oGi27Z6yGz1J1LxEi1blYrl5m+q6d8L0=;
        b=GFJeV/zli1vRIVGGtCm9AueG7lKYMWUz9hFu6TQY7pjH10cdQoKCCa8muiNJXyCGvL
         pptoJfKhrHzd0U/UZA86qIq/PNqK7CS4KH1ojnSZRtkWOuh6kMUhDc62PPEGMqZkisLa
         UpESVuHuU1rXgK9h8TSihYfpMXcX2HVu0drRfSybF/HcHn59WXI7ITF1EIrr9InVMiHA
         vxUGJdPXPcr52wSstS5ORSpyNmyJymg8W8DUt035n03KjKowDmvD0iflOBVZeQvIfyfr
         YV+m0Rq9eO6lDJjC+f/ceF8m2V5L+/eTO4LKWWYG8AVSwyOCiVlPfwEDYq/GrYEl4FBF
         xCmA==
X-Gm-Message-State: AJcUukeftSQkqmzWt36Sqm/S+4aIo4oZE2hGUkaEcKKYHf1wyk3emx+i
        EmJJQLzFZL6HrjFChP7m1FS3qs+V8RrCFln/c5Vu1SIecbE=
X-Google-Smtp-Source: ALg8bN6mk/+snvGt2lt4X2GdbdiT2jnuMCwJFLiqK8AN3gLWX3ppa1bMVfH5q7azKleg8Nu2LvrrkWxBdsu+mQhQ4uA=
X-Received: by 2002:ab0:216:: with SMTP id 22mr22713353uas.28.1546846547817;
 Sun, 06 Jan 2019 23:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20190107150609.0510def3@canb.auug.org.au>
In-Reply-To: <20190107150609.0510def3@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jan 2019 08:35:36 +0100
Message-ID: <CAMuHMdUCKaADLBrv0KLXSYHe8bR3ws7mhYr+1SkFYW15kDGo9Q@mail.gmail.com>
Subject: Re: linux-next: Tree for Jan 7
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Michael,

Happy NY! Looking forward to lots of linux-next releases and build
logs in 2019 ;-)

On Mon, Jan 7, 2019 at 5:08 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.

    Proxy Error
    The proxy server received an invalid response from an upstream server.
    The proxy server could not handle the request GET /kisskb/.

    Reason: Error reading from remote server

    Apache/2.4.37 (Debian) Server at kisskb.ellerman.id.au Port 80

Oops...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
