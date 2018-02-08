Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeBHURb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:17:31 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:36636 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:17:29 -0500
X-Google-Smtp-Source: AH8x225SrrUvYebsAsPlb7p+ZeyzGIO95gfzuakfvNQXgm9d7yuEgZBPgJKAEeBvSE/lxlv7gsHKRfGwd1oS559y018=
MIME-Version: 1.0
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 12:17:28 -0800
X-Google-Sender-Auth: 971Llko5xLTsH_aoZrOW9HTo8vQ
Message-ID: <CA+55aFwFZZg=otsDvTKrV3fgYdF0=w-Qa1P5o_UeDkfwdd+=uA@mail.gmail.com>
Subject: Re: [PATCH 0/7] afs: Fixes and dynamic root
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 8:16 AM, David Howells <dhowells@redhat.com> wrote:
>
>
> The patches can be found here also:
>
>         http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next
>
> tagged thusly:
>
>         afs-next-20180208

Please just write this as

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
afs-next-20180208

so that I don't have to first munge the repository address, and then
undo the merge and do it all over again when I notice that I didn't
get the tag, and instead had used just the branch you had indicated in
the first line..

           Linus
