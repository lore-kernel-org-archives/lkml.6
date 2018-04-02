Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeDBQEl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:04:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39832 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeDBQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:04:40 -0400
X-Google-Smtp-Source: AIpwx4+8mLOJJbJdnwWiOVmVK4or1elaUkDKjOSbq7WhGGL/XIFYIOVw5fFAlT3Kh6ANDiZ9WJLHWSgqLHNZoFGu818=
MIME-Version: 1.0
In-Reply-To: <20180402060123.GB12733@app09>
References: <20180402060123.GB12733@app09>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 09:04:38 -0700
X-Google-Sender-Auth: EmAzo2m3OfKkbEGSNhuCx__SAvs
Message-ID: <CA+55aFzwCiRrT5Ltfg0Uci7jXVRX2hw_fHp_srK_f7yacNKwwg@mail.gmail.com>
Subject: Re: [GIT PULL] Andes(nds32) Port for Linux 4.17
To: Greentime Hu <green.hu@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 1, 2018 at 11:01 PM, Greentime Hu <green.hu@gmail.com> wrote:
>
> This tag contains the core nds32 Linux port(including interrupt controller
> driver and timer driver), which has been through 7 rounds of review on mailing
> list.

Can I get an overview of the nds32 architecture (uses, quirks, reasons
for existing?) to add to the initial merge message? Just an overview,
not some kind of architecture manual thing.

Yeah, yeah, I can google it myself and write something up, but it's
the kind of information I'd like to see when merging an architecture I
hadn't really ever heard about, and I suspect most others haven't
either.

                 Linus
