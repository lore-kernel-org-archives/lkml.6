Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeFDSlH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:41:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45554 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeFDSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:41:05 -0400
X-Google-Smtp-Source: ADUXVKJunrDYJviZ9oOuK2IUObl9Qydffx3GCWSANnxK6rdeTNNDI2v2cwpKnF1GXZVjJNK7vd1GgWeZxZtEwUVy+Ws=
MIME-Version: 1.0
References: <20180604181813.GK30522@ZenIV.linux.org.uk> <CA+55aFw4ikYgcN-sYvQFmu--D60pSvbUjAPJrg5g3fCEdYykdg@mail.gmail.com>
 <20180604183744.GM30522@ZenIV.linux.org.uk>
In-Reply-To: <20180604183744.GM30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Jun 2018 11:40:53 -0700
Message-ID: <CA+55aFxjHQCtEjC_0Zz0S5NN5u+pimRwmMK=z507uAgfVTsnVA@mail.gmail.com>
Subject: Re: [git pull] vfs, pile 4
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 11:37 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So consider today's pile 4 as #5 and 5 - as #6 (or, better yet,
> "->lookup() cleanups" and "most of aio stuff").  Sorry...

Heh. I do something like that anyway, ie the four first ones are marked as

    Pull dcache updates from Al Viro:
    Pull rmdir update from Al Viro:
    Pull procfs updates from Al Viro:
    Pull misc vfs updates from Al Viro:

rather than enumerated. Maybe you should just do that yourself, since
counting is clearly a problem ;)

              Linus
