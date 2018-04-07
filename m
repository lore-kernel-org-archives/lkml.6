Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeDGQuJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 12:50:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36683 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeDGQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 12:50:07 -0400
X-Google-Smtp-Source: AIpwx49Vq05S9O9ZyFvbUz7FgNwUCF4sKyEDo73YpeADgVHJhKXW+ppdkWUFRXwI7N0rnDe/3WWSavKP4+UAHRRLfeE=
MIME-Version: 1.0
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 09:50:05 -0700
X-Google-Sender-Auth: 71uBF3Wb3ABbAYtkojs1CDxilsM
Message-ID: <CA+55aFxtS1jyefWXG+H6UjfC5KaqPOgTf3imHxL1iS1avJP5Lw@mail.gmail.com>
Subject: Re: [PATCH 00/20] afs: Fixes and development
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 1:29 PM, David Howells <dhowells@redhat.com> wrote:
>>
> Here are a set of AFS patches, a few fixes, but mostly development.  The fixes
> are:

So I pulled this after your updated fscache pull request, and I notice
that these three commits are duplicate (not shared):

      fscache: Attach the index key and aux data to the cookie
      fscache: Pass object size in rather than calling back for it
      fscache: Maintain a catalogue of allocated cookies

and partly as a result I get some trivial conflicts.

Now, the conflicts really do look entirely trivial, and that's not the
problem, but the fact that you *didn't* re-send the AFS pull request
makes me wonder if you perhaps didn't want me to pull it after all?

So I decided to not do the resolution, and instead just verify with
you that you still want this pulled?

No need to rebase, no need to do anything at all, really, except reply
with "yes I want you to pull this" or "no, the fscache pull updates
meant that I want you to do something else, hold off".

Pls advice.

(I may decide later to pull anyway, because I *think* you want me to
pull, but thought to ask in case you're online and answer quickly).

                      Linus
