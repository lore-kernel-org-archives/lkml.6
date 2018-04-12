Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeDLRWS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:22:18 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37017 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeDLRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:22:17 -0400
X-Google-Smtp-Source: AIpwx48XgixJuR9AOCca7rQGJH2i3dXhuDWckxRu+XuUMDSOA6ue9RlTIQ43ZKZveyNGoo1Flso3DTkBJjGxd8cSfDI=
MIME-Version: 1.0
In-Reply-To: <20180412172051.GK16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org> <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk> <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk> <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk> <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 10:22:15 -0700
X-Google-Sender-Auth: g0ZnwwlkSh28tk2o7cW8-JIPXt8
Message-ID: <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:20 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> This file was created to contain FPE_FIXME, by the "signal/arm: Document
> conflicts with SI_USER and SIGFPE" commit so if we're removing it, it
> would be better to remove the whole file.

Fair enough. I'm not going to commit that anyway since I can't test
it, but yes, if it tests ok that sounds like the right thing to do.

                   Linus
