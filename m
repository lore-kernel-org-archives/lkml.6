Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeDLROi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:14:38 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:52697 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbeDLROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:14:37 -0400
X-Google-Smtp-Source: AIpwx4/aC0fxgOY56+DlYNwwYxifBtRZZ+44DKAHIng+gAVXQcQCM3sCMiF6UxCnHyvx/rTjAi30fvw7SFtr0LjpW+E=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 10:14:35 -0700
X-Google-Sender-Auth: _Vd5XsIpN3EEKsZzyZN2J0hiTq4
Message-ID: <CA+55aFxj+NjW3M0Sv_-DRAD6vJ=HsPCQMtHn88me9uEEnJmAPw@mail.gmail.com>
Subject: Re: [PATCH] proc: fixup (c) sign
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 1:19 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Andrew's scripts butchered it :-(

Oh, it's not just Andrew.

Git will fix up commit messages etc, but the actual *patch* will be
considered just "data". So if you send me Latin1 (like you did), I get
a patch with Latin1.

Please just fix your broken mail environment, and move to the current
century. Use a real utf-8 locale.

You seem to be using Mutt. Afaik, that should automatically honor your
locale, and use utf-8,

But maybe you have it trying to send in Latin1 by default if that
works. Just do something like

    set file_charset="utf-8:iso-8859-1"

to make utf-8 the preferred format.

              Linus
