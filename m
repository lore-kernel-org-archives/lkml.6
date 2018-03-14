Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCNUkd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:40:33 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36141 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeCNUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:40:30 -0400
X-Google-Smtp-Source: AG47ELtV7aQhhDZoUq3t/e1gQxQrfYZ8+AXWe79p4KdWNHRsqJr835uE7CoNfmPPnJiEFSbypEYvQljA9PbL0tuW/lg=
MIME-Version: 1.0
In-Reply-To: <20180314203108.GA18775@isilmar-4.linta.de>
References: <20180314143529.1456168-1-arnd@arndb.de> <20180314144614.1632190-1-arnd@arndb.de>
 <20180314144614.1632190-2-arnd@arndb.de> <20180314203108.GA18775@isilmar-4.linta.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:40:28 +0100
X-Google-Sender-Auth: KCA6HjaFVEAWF6eaqEzeFtVxkzg
Message-ID: <CAK8P3a0cwSJCE3oqT5h1xc46mTsH6a6OHB1i5u8m1eshAfOnqQ@mail.gmail.com>
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:31 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Wed, Mar 14, 2018 at 03:43:47PM +0100, Arnd Bergmann wrote:
>> The frv, tile and blackfin architectures are being removed, so
>> we can clean up this header by removing all the special cases
>> except those for ia64.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> AFAICS, score is the only architecture which still defines
>
>         __ARCH_WANT_SYSCALL_NO_FLAGS
>         __ARCH_WANT_SYSCALL_OFF_T
>         __ARCH_WANT_SYSCALL_DEPRECATED .
>
> So maybe you want to clean up include/uapi/asm-generic/unistd.h as well?

Definitely. In fact, this was patch 14/16, but for some reason the mail never
made it out. I tried again and it should be there now.

        Arnd
