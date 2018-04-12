Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeDLUQI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:16:08 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:39862 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDLUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:16:07 -0400
X-Google-Smtp-Source: AIpwx4+KzeTDOQX2fpMgcaMm8jfUriVJAlwTsyLFPilZSo3a/7IgURckL2dn/DMLEVLzCtY+qvUqZuUlTwPtM8OAin4=
MIME-Version: 1.0
In-Reply-To: <20180412195024.GA17810@avx2>
References: <CA+55aFxj+NjW3M0Sv_-DRAD6vJ=HsPCQMtHn88me9uEEnJmAPw@mail.gmail.com>
 <20180412195024.GA17810@avx2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 13:16:06 -0700
X-Google-Sender-Auth: svt_h1NJB99rlV3mJiXBslkFmUo
Message-ID: <CA+55aFwJSQehU1tuSKJAXnro4vc_hU5W1-qL6XUO8BBpkK06rg@mail.gmail.com>
Subject: Re: [PATCH] proc: fixup (c) sign
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 12:50 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> I've checked earlier mails, mutt has been "guessing" outgoing encoding
> by default. Let's try again.

I think it still does. This email came with

    Content-Type: text/plain; charset=us-ascii

which is what I'd expect if Mutt has a "use the least complex charset
that can fit the message".

If you look at my emails, you should see

    Content-Type: text/plain; charset="UTF-8"

even for an email like this, that only has 7-bit ascii.

I'm not a Mutt user, so I don't know what the magic is for "just force
utf-8 when sending".

For alpine, it's

    posting-character-set=UTF-8

in the .pinerc file.

For gmail there used to be an "outgoing message encoding" setting, but
it seems to have been removed (and now utf-8 is always on).

             Linus
