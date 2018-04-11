Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeDKXQm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:16:42 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:53763 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDKXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:16:40 -0400
X-Google-Smtp-Source: AIpwx49Ltu72YrHP2XIUohmicC1JXflJXIHtw3ocM+DTO12JOa8+J+lrJWZlK1F7Z1SWFMPPoeO1K2V9HZbzQoZhxwc=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a081_hkr5d0FRWpTaT-AsJoqznsS1=_WF4JVLTUOupUgg@mail.gmail.com>
References: <CAK8P3a081_hkr5d0FRWpTaT-AsJoqznsS1=_WF4JVLTUOupUgg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 16:16:38 -0700
X-Google-Sender-Auth: dcj30s3AibDnaD8XWGROvDEhbbs
Message-ID: <CA+55aFx4_gaBeffy9roFRnkB30fnRa=nhh5qR=o=CgrWmgphiw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic fixes for v4.17-rc1
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ley Foon Tan <lftan@altera.com>,
        "moderated list:NIOS2 ARCHITECTURE"
        <nios2-dev@lists.rocketboards.org>,
        Michal Simek <monstr@monstr.eu>,
        "moderated list:H8/300 ARCHITECTURE"
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 8:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> are available in the git repository at:
>
>   git+ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> tags/asm-generic

Yeah, no they aren't available there at all.

That tag is some old tag from two years ago that just contains your
ancient "asm-generic: use compat version for preadv2 and pwritev2".

Forgot to push out? Or forgot to use "-f" to overwrite the old tag?

                 Linus
