Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeBLVoM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:44:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39868 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:44:11 -0500
X-Google-Smtp-Source: AH8x224EoGAsrZb2VmYeWwL9Xvhr1YW8rsDXw1vkHv1qSH+S5Yq2Tmct6GqBXcWCNKNgk7VvXK+AyA==
From: Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
Date: Mon, 12 Feb 2018 13:44:07 -0800
In-Reply-To: <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 12 Feb 2018 13:37:04 -0800")
Message-ID: <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Maybe we could just tell people to have something like
>
>        git config --global alias.update pull --ff-only
>
> and use that for "try to update to upstream".

I guess our mails crossed.  I admit that I indeed wondered why you
were not giving your usual "downstream shouldn't do pointless pull
from upstream" briefly but focused too much on how to tweak the
default without thinking through.

But I wonder why "update to upstream" is merging a signed tag in the
first place.  Wouldn't downstream's "try to keep up with" pull be
grabbing from branch tips, not tags?
