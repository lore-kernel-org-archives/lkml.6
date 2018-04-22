Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeDVNge (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 09:36:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751513AbeDVNgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 09:36:32 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFyez2t_JUBhb3R0VFN7s_Gn+LwOS16gTSmSFb_M90v98A@mail.gmail.com>
References: <CA+55aFyez2t_JUBhb3R0VFN7s_Gn+LwOS16gTSmSFb_M90v98A@mail.gmail.com> <152422770230.23067.14348897715991489250.stgit@warthog.procyon.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31366.1524404190.1@warthog.procyon.org.uk>
Date: Sun, 22 Apr 2018 14:36:30 +0100
Message-ID: <31367.1524404190@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I guess they have the same value (1). How did you notice? Do you have
> some patches that turn the kernel flags into a bitwise type? Or did
> you just happen on it manually?

I happened to be looking at that bit of code.

They have the saame value for the moment, but this may not always remain so.

David
