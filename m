Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeDLTua (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:50:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54683 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeDLTu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:50:28 -0400
X-Google-Smtp-Source: AIpwx49F0D4a24fgmMztaGHxhPnlIgdIZfxrTkIHJ2klhstnK3CMNFdjxeIq0aLCZqywv46pCnLSkg==
Date: Thu, 12 Apr 2018 22:50:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] proc: fixup (c) sign
Message-ID: <20180412195024.GA17810@avx2>
References: <CA+55aFxj+NjW3M0Sv_-DRAD6vJ=HsPCQMtHn88me9uEEnJmAPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxj+NjW3M0Sv_-DRAD6vJ=HsPCQMtHn88me9uEEnJmAPw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:14:35AM -0700, Linus Torvalds wrote:
> On Wed, Apr 11, 2018 at 1:19 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > Andrew's scripts butchered it :-(
> 
> Oh, it's not just Andrew.
> 
> Git will fix up commit messages etc, but the actual *patch* will be
> considered just "data". So if you send me Latin1 (like you did), I get
> a patch with Latin1.
> 
> Please just fix your broken mail environment, and move to the current
> century. Use a real utf-8 locale.
> 
> You seem to be using Mutt. Afaik, that should automatically honor your
> locale, and use utf-8,
> 
> But maybe you have it trying to send in Latin1 by default if that
> works. Just do something like
> 
>     set file_charset="utf-8:iso-8859-1"
> 
> to make utf-8 the preferred format.

I've checked earlier mails, mutt has been "guessing" outgoing encoding
by default. Let's try again.
