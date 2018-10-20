Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E1BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E822157C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E822157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJUDNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:13:33 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40470 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeJUDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:13:32 -0400
Received: by mail-vs1-f65.google.com with SMTP id y195so11508717vsc.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 12:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLSZUhNWirZLLpU4cR5N+Iph7vNvX9GowAKsi8+qEbI=;
        b=twUrNlDFF7/kACTceBcxA14eUX7J7XlfcvyxJqx6OtUq6epsK5w/DIo90gEwQKBenJ
         CsSKsgTdGOIDd0NsbyzavpsFmxaOzGaoIvxWUKheMf9c3UINalyOcQSHKXlWOjWGhVQd
         z4MQb149ot+4TTBr2DVbrfGADQdpIg8SfTYzUbUYQ7EsV7MbgK4eedfJJLPqsrXW/ZcI
         c+M0xFFpSmdom5fGTxeCBXYooxvlt3X09w6Bq0HZwygUnkSVJwBz+0ER18CoGWJjxoFU
         IPu9xk8rGzbhWzXIwmjZtk8rVE7C9/345Gb4mHT60tY37B/VPVlJWxTE1MY3BOLRDE7Y
         3tZg==
X-Gm-Message-State: ABuFfohefJQKnvSOJz1M2GegLpxK/6yl+mf8mNLgFTVEw5ucIo3ez98N
        T5dD7gUB1Hj+fSZ5PoYHHSOHJYD/M9qoLezv/6I=
X-Google-Smtp-Source: ACcGV60jif4M/kJ9B45I8UuI3Wy0vozay2RLRk4JchsIW8CF5epXuTFga+VQAhcZ+Aw3dWZ55w69CdZkUmSFMlqEgp8=
X-Received: by 2002:a67:f3cc:: with SMTP id j12mr14354774vsn.96.1540062129024;
 Sat, 20 Oct 2018 12:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181020134908.GA32218@kroah.com> <20181020135058.GF32218@kroah.com>
In-Reply-To: <20181020135058.GF32218@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 20 Oct 2018 21:01:57 +0200
Message-ID: <CAMuHMdUR_7GgFL0wqh9AdEq=HWmxPB=HzarEgY5TeLo67+S1LA@mail.gmail.com>
Subject: Re: [PATCH 5/7] Code of Conduct Interpretation: Put in the proper URL
 for the committee
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        mishi@linux.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Oct 20, 2018 at 3:53 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> There was a blank <URL> reference for how to find the Code of Conduct
> Committee.  Fix that up by pointing it to the correct kernel.org website
> page location.
>
> Acked-by: Chris Mason <clm@fb.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for your patch!

> --- a/Documentation/process/code-of-conduct-interpretation.rst
> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> @@ -123,8 +123,9 @@ Enforcement
>
>  The address listed in the Code of Conduct goes to the Code of Conduct
>  Committee.  The exact members receiving these emails at any given time
> -are listed at <URL>.  Members can not access reports made before they
> -joined or after they have left the committee.
> +are listed at https://kernel.org/code-of-conduct.html.  Members can not
> +access reports made before they joined or after they have left the
> +committee.

This seems to be the wrong URL? It just points to the CoC, not to the TAB
members.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
