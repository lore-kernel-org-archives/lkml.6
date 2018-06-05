Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeFEQKS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:10:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39461 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeFEQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:10:17 -0400
X-Google-Smtp-Source: ADUXVKIDi8dp+fOtQRO1QeXqxnPHFv5XLDGHgpM+bc2XqvRlsS0/YvRL+LAuo34klfH2fZ9lQ2Yo3qHgmIFSM6fC/SQ=
MIME-Version: 1.0
References: <cover.1528137452.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1528137452.git.jpoimboe@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 09:10:05 -0700
Message-ID: <CA+55aFyyB0+vUmByyEMD-rEVHg2qnw3D4XVisVSuuPDKz9Vs1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] faddr2line fix and MAINTAINERS update
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        changbin.du@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 11:44 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Linus, would you be willing to pick these up directly, or would you
> rather me route them through somebody else?

I took them directly.

That said, if you had a git tree, that would have fit my merge-window
workflow better. I've been very good at getting people to send me
patch-series as git trees, with mainly just Andrew as the stalwart
patch user.

Single patches I obviously take as patches, but whenever I see even a
small patch series like this I tend to go "Hmm, git is _so_
convenient".

Hint hint, for the future.

              Linus
