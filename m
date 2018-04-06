Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeDFSVf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:21:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33479 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeDFSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:21:33 -0400
X-Google-Smtp-Source: AIpwx4+Wt7U2fjKNkLCZd5v0SJdwNafggxv84eNexmy8RvcFva37uuOD4B5B6djYn4bAOMoR/tKoFfNBD/l7gOcVkBU=
MIME-Version: 1.0
In-Reply-To: <4034.1523025880@warthog.procyon.org.uk>
References: <152287959470.14760.10350886166577848180.stgit@warthog.procyon.org.uk>
 <4034.1523025880@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Apr 2018 11:21:31 -0700
X-Google-Sender-Auth: swYru_ryjCqw2dR9m2_EGew-5Do
Message-ID: <CA+55aFwKc1JzU6k=3R9n23HGXb5-BACT8pQ93rGTvgNjfa4ZHA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/12] fscache: Fixes, traces and development
To: David Howells <dhowells@redhat.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 7:44 AM, David Howells <dhowells@redhat.com> wrote:
> Hi Linus,
>
> I've fixed a bug in the final patch that was found by the kbuild test robot
> and disabled a debugging statement in an earlier one.  This is now tagged as:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
>         tags/fscache-next-20180406
>
> Do you want me to repost the patchset?

No, but if you can redo the pull request part so that the diffstat I
get will match the diffstat I see in the pull request, that would be
good.

Thanks,

                  Linus
