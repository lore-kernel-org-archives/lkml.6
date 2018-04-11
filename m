Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeDKWl3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 18:41:29 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:38411 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeDKWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 18:41:28 -0400
X-Google-Smtp-Source: AIpwx48jELxvjWXjbPUG7NIFmDiDvo0pvs6URSvRJquFm9ERIdtpt2f5h7gRUfYVHi7fP6Gj/au6z/bgadAulGrT1d4=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 15:41:26 -0700
X-Google-Sender-Auth: nrXwqu-iTyPgorFS8ZE0fmhMysY
Message-ID: <CA+55aFxrpn=GdgqgrczUdj-wndFdQvmfytwMiYL5=TQWhfpAjA@mail.gmail.com>
Subject: Re: [PATCH] proc: fixup (c) sign
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 1:24 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> It got sent from here as iso8859-1.

It's probably a good idea to just move away from Latin1 entirely, and
encourage people to just use utf-8.

But yes, Andrew's scripts clearly do a horrible job at looking at
email encoding, and that really should be fixed.

I worry less about silly copyright signs than about peoples actual
_names_, but we've certainly seen problems there too.

                 Linus
