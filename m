Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C8C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC7B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC7B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeJ2VFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:05:37 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34077 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbeJ2VFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:05:37 -0400
Received: by mail-vs1-f68.google.com with SMTP id q15so5075735vso.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSVkAw/Y1q+GnTaKXbQTtIS0SXOXQO9BQN0hPdqlisQ=;
        b=KatIYukCuY0/AQI2khc7UYQXLl2PyG9P57eLQZY3g+uYPuTPw2KStDBrXCH6R48dBX
         JZWIgGlCFUTGKSL5LNIYQmzqZVA2rBd4LymSh9nF/q9ek3zI0dB+CbZSGhCszX9qTq19
         JVW7rUZDA5x78JdBZiaHa+YPWF+3EbzmNP2O6V8NMOl1tzPs7TntKrFrmGAcL4LFILW3
         utSXUumwqJnRniJe1C9qA0HB0WZ3cxDgLZcaYs04Yy1vwupCNknp+i7MYPRUE4oVxVZA
         GwpWWqy73SGyDhXk0ls0GTQuEtJe3zff6oKdQ8iRkTKljaUtviR8XM5fGq3F5kEJOMFG
         /Ixw==
X-Gm-Message-State: AGRZ1gLW5i/ml9rTRZf3mw3TIMCxHZYBACFUAsAKxO6qy3aC5siLkzvx
        gGj1f2il48l1GqiG5WIvU+zUVvEX5Ri4vG1SpV5mOw==
X-Google-Smtp-Source: AJdET5d2gj+o+vp4VKEBLRJWW9uk2npT6zAhPeDQqBOoIGUUKAn1y62g819TQk6oDKQGUW6R+WOuHpkMFyMWlbz/Y3k=
X-Received: by 2002:a67:d107:: with SMTP id u7mr2588063vsi.63.1540815430807;
 Mon, 29 Oct 2018 05:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181029170212.4a34959f@canb.auug.org.au> <20181029063319.GC8104@Ubuntu-DTI>
 <20181029204142.7dbce8d8@canb.auug.org.au> <20181029114225.GA2395@zrhn9910b> <20181029230841.1d9625ce@canb.auug.org.au>
In-Reply-To: <20181029230841.1d9625ce@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Oct 2018 13:16:59 +0100
Message-ID: <CAMuHMdXM+Zcx_CnwPZyvz7JUD+r1eQ-MFv43kKAg1_cNMhLzvQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 29
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux_dti@icloud.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        webmaster@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 1:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Mon, 29 Oct 2018 12:42:26 +0100 damian <linux_dti@icloud.com> wrote:
> > On Mon, 29. Oct 20:41, Stephen Rothwell wrote:
> > > On Mon, 29 Oct 2018 07:33:19 +0100 Damian Tometzki <linux_dti@icloud.com> wrote:
> > > >
> > > > on the site isnt available the new linux-next ?
> > > > Only the old one.
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >
> > > It seems to be there now (at least for me).  Maybe just mirroring delays?
> >
> > i tried it from diffrent localtion and different systems the same sitation. My last tag what i
> > see is: linux-next-next-20181019.tar.gz
>
> so, I see:
>
> $ dig -tcname +short git.kernel.org
> syd.git.kernel.org.
> $ git ls-remote git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git | grep 20181029
> 0e2adec0725178efbb0b7019ee0198d93ba54843        refs/tags/next-20181029
> b179f0826c6a13563c5ce0554c6da6748a1fa699        refs/tags/next-20181029^{}
> $ git ls-remote https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git | grep 20181029
> 0e2adec0725178efbb0b7019ee0198d93ba54843        refs/tags/next-20181029
> b179f0826c6a13563c5ce0554c6da6748a1fa699        refs/tags/next-20181029^{}
>
> cc'ing the kernel.org admins ...

I can confirm syd.git.kernel.org and ord.git.kernel.org have it, but
fra.git.kernel.org (my default) hasn't.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
