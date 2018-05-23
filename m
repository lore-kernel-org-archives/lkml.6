Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeEWAdX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbeEWAdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:33:22 -0400
X-Google-Smtp-Source: AB8JxZoeXiJ7fvFuKVL/TSg/cwr3nGwurYwxIYzFyNj0Tp5iRC7lbczQFjnrb8PPKlXdxTM/V+C0MjWAVYhWjC3aYv8=
MIME-Version: 1.0
References: <20180523001939.9431-1-labbott@redhat.com> <20180523001939.9431-3-labbott@redhat.com>
In-Reply-To: <20180523001939.9431-3-labbott@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 22 May 2018 17:33:09 -0700
X-Gmail-Original-Message-ID: <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com>
Message-ID: <CALCETrX9P2Lwrx7wGc22poVWX2AHAqXbUdhcijyoJ3tGhaxijg@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
To: Laura Abbott <labbott@redhat.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 5:19 PM Laura Abbott <labbott@redhat.com> wrote:


> The vDSO is linked separately from the kernel and modules. Ensure it picks
> up the comment section, if available.

Did you end up preferring this to just sticking the kernel version in a
.comment in the vDSO for some reason?
