Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeCZPye (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:54:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751249AbeCZPyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:54:32 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAK7LNASa=QrQRQ03KQNKdFb-EW-maWbhSi8=iYz5fJ7kEfPEFg@mail.gmail.com>
References: <CAK7LNASa=QrQRQ03KQNKdFb-EW-maWbhSi8=iYz5fJ7kEfPEFg@mail.gmail.com> <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com> <1521810279-6282-8-git-send-email-yamada.masahiro@socionext.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: dhowells@redhat.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 08/10] kbuild: rename *-asn1.[ch] to *.asn.[ch]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3227.1522079152.1@warthog.procyon.org.uk>
Date: Mon, 26 Mar 2018 16:45:52 +0100
Message-ID: <3228.1522079152@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject isn't consistent with the patch.  I presume you mean:

	kbuild: rename *-asn1.[ch] to *.asn1.[ch]

David
