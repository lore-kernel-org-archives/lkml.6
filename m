Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeDCEJB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 00:09:01 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35141 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeDCEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 00:08:59 -0400
X-Google-Smtp-Source: AIpwx4+vhnlFAE9VwHYIzEhWou1BvQXpXe3IIRayEwWuRe5Fg6dfofBpgvAca/ob0J4JZWXjIviLu63RthKkQ9GCVMc=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
References: <CAK8P3a0q70FYtBaCcsBPejVULgsbJPwUG7QmrkU9NJpr7oTzpQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 21:08:57 -0700
X-Google-Sender-Auth: pq0X4z2hh3B49YJmrYCmBsRnb0Q
Message-ID: <CA+55aFzo_Hdsy31JD+CqUVFJvu2uQpaPOFdTL7J7XoR6WirkxA@mail.gmail.com>
Subject: Re: [GIT PULL] arch: remove obsolete architecture ports
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, David Howells <dhowells@redhat.com>,
        linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>,
        Lennox Wu <lennox.wu@gmail.com>, Aaron Wu <Aaron.Wu@analog.com>,
        Bryan Wu <cooloney@gmail.com>,
        Chris Metcalf <chris.d.metcalf@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 12:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The series is rather long and conflicts in trivial ways with lots
> of subsystem trees. You probably want to pull it either really
> early in the merge window or really late.

Ok, I've been pulling arch updates, so it went in now.

Side note: the most concise yet useful form of diff I found for your
pull request was this:

    git diff -M --stat=5000 --summary merge^..merge | grep '\+'

which shows the diffstat, but skips anything that doesn't have a plus
sign in it. So all the pure removal lines are entirely gone.

So it shows stuff that had actual modifications, and perhaps more
importantly, it still shows the final summary, which matches yours:

 2498 files changed, 95 insertions(+), 467668 deletions(-)

which is pretty nice to see. Closer to hal a million lines gone. (Or,
as the drm people would say "one header file").

You should probably check the end result (I haven't pushed out yet,
doing a few more things and build tests, but it should be out soon).

            Linus
