Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62747C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA93206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA93206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeLCLx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:53:56 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37374 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:53:56 -0500
Received: by mail-vk1-f196.google.com with SMTP id 197so2813977vkf.4;
        Mon, 03 Dec 2018 03:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkS5VxnVunhaJwM5ZQ2pXwz9+pzKRWg1voHxB29hCqI=;
        b=E5am7160z01Yx6zywVNsOSf02XBKHcqExPOVnRfC9v7AcJg7qCIzvwF2Bf5nYmToaR
         tmzSaKhsYYN5kskdzeuCBydwLVwuxsdhoGwuSsE+fyJWPDjXwfWixLCEwgugSsqBNawh
         Sui8UICiCwNxObZccTXI5hvfwnllSCkuJaBR5ZlSCV3NMNRQU51SMKSzN6SpOqKD7rti
         HDhkfFH+qQtrhpRJTOGNwLiab62wr6KACrc3w7yY7/Vq7mnMTk0WAj2eUyZOPE2yyx6z
         ZzYUJ56vXfrvZ4lnjI7c0KtJzq0dPdFSZqGWyF8HlMZeK744CZ27xrWUs8v3blDhA3gh
         zXMQ==
X-Gm-Message-State: AA+aEWbXcsiqJR1TKuSyk7CpTO96/kK5B8WcdgQCzET9mVRUGLNva8Gk
        u1G1ydhDSj+A2PuXDM07Lkbd1khlChS+oWnSwhc=
X-Google-Smtp-Source: AFSGD/UwPBkhpSY6rw7kZNVO0xO1dKNM7J1ZHEuNWK3fX8xjUnpLmj25QtePqwyMcgAGn/I2vA/0b804fTv8M2V4utA=
X-Received: by 2002:a1f:1881:: with SMTP id 123mr6688602vky.40.1543837991857;
 Mon, 03 Dec 2018 03:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20181202093257.3918-1-geert@linux-m68k.org> <20181203110506.GA7485@kroah.com>
In-Reply-To: <20181203110506.GA7485@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Dec 2018 12:53:00 +0100
Message-ID: <CAMuHMdUXwkA+Kv2MOOmT3mZK75ex=A=TBwwR=JXSxFp7Y3O0Hg@mail.gmail.com>
Subject: Re: [PATCH v3] code-of-conduct: Remove explicit list of
 discrimination factors
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>, acme@kernel.org,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        Bart Van Assche <bvanassche@acm.org>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Dec 3, 2018 at 12:05 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Dec 02, 2018 at 10:32:57AM +0100, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.
> >
> > Furthermore, this list is already overly long, polarizing,
> > politically-laden, and reinstating the concept of human races.
> > None of these is related to the goals of the Linux kernel project.
> >
> > Avoid any ambiguity or political undertone by removing the list, to
> > ensure "a harassment-free experience for everyone", period.
>
> I understand the reason you and others are proposing this change,
> however for now, let us stick with the text that we have.  As Linus and
> I said just over a month ago, let's sit with the text we have until
> something comes up that requires a change to happen.
>
> Also, I recommend you work with the upstream developers of this text to
> see if they agree with your changes here.  If they do, and update their
> version, I will be glad to revisit this text at that time.

I did, cfr. https://github.com/ContributorCovenant/contributor_covenant/issues/610

The official response was:

   "I'm not going to make this change to the Contributor Covenant itself,
    since I believe that explicitly listing examples of protected classes is
    important. However, any adopting project is free to modify the document
    according to the license."

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
