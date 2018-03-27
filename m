Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbeC0EJo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:09:44 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23272 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeC0EJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:09:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2R49cEY027910
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AG47ELttMFXf01yqH9aVPTzSAu6eKg+EsrLn30hCulCvaB1dGbutov2qJEV9foK5rALo6aAt7XrwzfrgiY9kkHt58tM=
MIME-Version: 1.0
In-Reply-To: <3228.1522079152@warthog.procyon.org.uk>
References: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
 <1521810279-6282-8-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASa=QrQRQ03KQNKdFb-EW-maWbhSi8=iYz5fJ7kEfPEFg@mail.gmail.com> <3228.1522079152@warthog.procyon.org.uk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Mar 2018 13:08:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5fjtLVL3SQCW=FuYs-MbFeGS9Xpn_hGhZD9x86SMkYg@mail.gmail.com>
Message-ID: <CAK7LNAQ5fjtLVL3SQCW=FuYs-MbFeGS9Xpn_hGhZD9x86SMkYg@mail.gmail.com>
Subject: Re: [PATCH 08/10] kbuild: rename *-asn1.[ch] to *.asn.[ch]
To: David Howells <dhowells@redhat.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-27 0:45 GMT+09:00 David Howells <dhowells@redhat.com>:
> The subject isn't consistent with the patch.  I presume you mean:
>
>         kbuild: rename *-asn1.[ch] to *.asn1.[ch]
>
> David
> --


I noticed this after submitting it.
I fixed it up locally, and testing with 0-day bot.
Thanks!




-- 
Best Regards
Masahiro Yamada
