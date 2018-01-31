Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbeAaVhp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:37:45 -0500
Received: from namei.org ([65.99.196.166]:39886 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753245AbeAaVho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:37:44 -0500
Date: Thu, 1 Feb 2018 08:37:37 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] Security subsystem updates for v4.16
In-Reply-To: <CA+55aFw1vWWmv5Ebq9yWVDFm4SQUG_fNd3f5yoYkWRTfUNaL_Q@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1802010836080.13723@namei.org>
References: <alpine.LRH.2.21.1801291040280.29680@namei.org> <CA+55aFw1vWWmv5Ebq9yWVDFm4SQUG_fNd3f5yoYkWRTfUNaL_Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018, Linus Torvalds wrote:

> On Sun, Jan 28, 2018 at 3:41 PM, James Morris <jmorris@namei.org> wrote:
> >
> > Note that individual trees may also be pulled via:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> >         next-integrity
> >         next-smack
> >         next-tpm
> 
> So I did that, because it makes it easier and more controlled for me.
> But then when double-checking that the end result is identical to your
> full pull request, I end up missing the seccomp tree.

Ok, I'll send you separate pull requests for each branch from now on.

> 
> I can pull that separately too, but it was missing explanations and a
> real pull request, so I left it alone.
> 

Please pull:

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp

for you to fetch changes up to 26025bf58b9fe3806ce4f92600e96a2c214c0d9c:

  Merge tag 'seccomp-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-seccomp (2017-11-29 12:48:48 +1100)

----------------------------------------------------------------
James Morris (2):
      Merge tag 'v4.15-rc1' into next-seccomp
      Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-seccomp

Tycho Andersen (2):
      seccomp: hoist out filter resolving logic
      ptrace, seccomp: add support for retrieving seccomp metadata

 include/linux/seccomp.h     |   8 ++++
 include/uapi/linux/ptrace.h |   6 +++
 kernel/ptrace.c             |   4 ++
 kernel/seccomp.c            | 106 +++++++++++++++++++++++++++++++-------------
 4 files changed, 94 insertions(+), 30 deletions(-)
