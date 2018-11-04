Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E19FC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BBA2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BBA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeKDTuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 14:50:39 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38125 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeKDTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 14:50:39 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so3483343vsa.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 02:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkLZhBfyOgu4Lw1UigwOiVIkZrAMpKbIExko8IRzONg=;
        b=mSfOhHIbxFECWWvXlaTVlBKDg8On6vMWeUPxYTAOdZ1Hsw2zAP9S0hUpd6sqwlQ7WQ
         v+YnsS44Cb1VxofwcH3YDI56qHoMKQeobEeWvZcA1bkIz2qUfKJasVVXH4dl5c7YKp+F
         3qJsAoqpHNBqmAqRDO1811pDU2WNREJkt8P7DJ0plpLZo8GTXiLb8d9Sj7BtqwIJiAVC
         gnCniOSgJwvFrHk1KJIau1JjPlBLnPf9AwQPubzECi7oTg1md6msGTfKnmm/NhjfauoR
         lxsp+kYFuKAsjZNrhf3MuceKmajVfy+zqnfbcQUWxJucVEl1qWICxXTrDx6Eg8tlq/7a
         cyJA==
X-Gm-Message-State: AGRZ1gJRc7ZM30ouxJlLy8Bvl0d4iQigYymucDlilgQCWwbtF2+Js5N4
        0bG/D+lSNZYQbKtFLIv12KN7pL06IiATrXEjdv0=
X-Google-Smtp-Source: AJdET5fvp8dqfwPbwpKj2j/KZrV0/zINPuraqDE9fzEe3MJ0/gLRgOZmXbYjW42Iqgyp5h63ERCJ8vcR5D4Npw+CUUE=
X-Received: by 2002:a67:846:: with SMTP id 67mr146971vsi.166.1541327769023;
 Sun, 04 Nov 2018 02:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost> <875zxt919d.fsf@notabene.neil.brown.name> <20181024121622.GA10942@localhost>
In-Reply-To: <20181024121622.GA10942@localhost>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 4 Nov 2018 11:35:56 +0100
Message-ID: <CAMuHMdUyVMNd9qUFEqG=ULWVo6WaiPm3fAkAGh11ucWtptY4zA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct:
 Fix some wording, and add an interpretation document
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     neil@brown.name, mishi@linux.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Wed, Oct 24, 2018 at 2:16 PM Josh Triplett <josh@joshtriplett.org> wrote:
> On Tue, Oct 23, 2018 at 07:26:06AM +1100, NeilBrown wrote:
> > On Sun, Oct 21 2018, Josh Triplett wrote:
> > > On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
> > >> I call on you, Greg:
> > >>  - to abandon this divisive attempt to impose a "Code of Conduct"
> > >>  - to revert 8a104f8b5867c68
> > >>  - to return to your core competence of building a great team around
> > >>    a great kernel
> > >>
> > >>  #Isupportreversion
> > >>
> > >> I call on the community to consider what *does* need to be said, about
> > >> conduct, to people outside the community and who have recently joined.
> > >> What is the document that you would have liked to have read as you were
> > >> starting out?  It is all too long ago for me to remember clearly, and so
> > >> much has changed.
> > >
> > > The document I would have liked to have read when starting out is
> > > currently checked into the source tree in
> > > Documentation/process/code-of-conduct.rst .
> >
> > I'm curious - what would you have gained by reading that document?
>
> I would have then had rather less of a pervasive feeling of "if I make
> even a single mistake I get made an example of in ways that will feed
> people's quotes files for years to come".
>
> See
> https://hbr.org/2017/08/high-performing-teams-need-psychological-safety-heres-how-to-create-it
> for more on the benefits of that.

Funny how you post a link to that article ;-)
Because the psychological safety of the Linux kernel developers and
maintainers is exactly what is being affected, due to the atmosphere
surrounding this particular CoC.

While the addition of the CoC Clarification did improve the general
understanding, the addition of the CoC itself has already caused a
chilling effect. From chatting at the conferences in Edinburgh, people
do have concerns and comments, but many just do not want to express
their thoughts and feelings in public...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
