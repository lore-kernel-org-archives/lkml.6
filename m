Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDTRDZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:03:25 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:44066 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeDTRDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:03:22 -0400
X-Google-Smtp-Source: AB8JxZpB79HrhaaYnns7kIuO5M7hV5vk8FgOkxIhdiB0NP24vpfqK8L47heDp3v5/NBsp9lsP7t563z7GAlMWtvGhCM=
MIME-Version: 1.0
In-Reply-To: <152422770230.23067.14348897715991489250.stgit@warthog.procyon.org.uk>
References: <152422770230.23067.14348897715991489250.stgit@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Apr 2018 10:03:21 -0700
X-Google-Sender-Auth: _4CJy_QMloIvAoZJ8dEMJg7qfkE
Message-ID: <CA+55aFyez2t_JUBhb3R0VFN7s_Gn+LwOS16gTSmSFb_M90v98A@mail.gmail.com>
Subject: Re: [PATCH] vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY conversion
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 5:35 AM, David Howells <dhowells@redhat.com> wrote:
> In do_mount() when the MS_* flags are being converted to MNT_* flags,
> MS_RDONLY got accidentally convered to SB_RDONLY.

Applied.

I guess they have the same value (1). How did you notice? Do you have
some patches that turn the kernel flags into a bitwise type? Or did
you just happen on it manually?

           Linus
