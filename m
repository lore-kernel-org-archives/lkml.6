Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759090AbeD1ReJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 13:34:09 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35306 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757832AbeD1ReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 13:34:08 -0400
X-Google-Smtp-Source: AB8JxZrbMcjQS8xYdJpu/b5yNHGrIP1NtzJUTFqJrXxOPBtfxb2hfgqFC8kfnlv8Ti15weFnKxqhYxG1KrYMDK2SRp8=
MIME-Version: 1.0
References: <20180428170504.16031-1-dsterba@suse.com>
In-Reply-To: <20180428170504.16031-1-dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Apr 2018 17:33:57 +0000
Message-ID: <CA+55aFzH=CjVD4kUXfPBjimsKhfphjOceDtcskWtj5Vk3ByB4Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as maintainer of AFFS
To: David Sterba <dsterba@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Steigerwald <martin@lichtvoll.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 10:07 AM David Sterba <dsterba@suse.com> wrote:

> I volunteer to act as a maintainer of AFFS to collect any fixes that
> might show up and to guard fs/affs/ against another spring cleaning.

Hmm. Please be more careful.

> @@ -564,8 +564,10 @@ S: Maintained

The above says it adds two lines (8 -> 10), but the actual patch itself
only adds one, and modifies another:

> +M:     David Sterba <dsterba@suse.com>
> -S:     Orphan
> +S:     Odd Fixes

I'm used to editing patches for things like this, because I have years and
years of just hand-editing patches I didn't like for some reason, but it
looks like you tried to edit a patch without knowing all the rules for how
unified patches work.

So please don't edit patches by hand.  It's a skill nobody should have.

Anyway, I fixed the patch and applied it, but let's not make a habit of it.

               Linus
