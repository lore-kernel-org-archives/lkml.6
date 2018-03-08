Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755930AbeCHNgp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:36:45 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:43503 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755755AbeCHNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:36:43 -0500
X-Google-Smtp-Source: AG47ELsFfLV90iXc/kII8haZQVPcQ5sw6jSBjNDKlTa7jkn369IcUWwt4tBj7B7ack/1R5AOYfuM8YJkKhfP6vH4rdk=
MIME-Version: 1.0
In-Reply-To: <152050252646.30856.16654455402435277982.stgit@warthog.procyon.org.uk>
References: <152050252646.30856.16654455402435277982.stgit@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Mar 2018 14:36:41 +0100
X-Google-Sender-Auth: LDXiTLm1HrtQibIr12iqUC_ZzEs
Message-ID: <CAK8P3a2R+ROQbH-9gioP1mg-dck27qaFpxBufJo2S12odseeZg@mail.gmail.com>
Subject: Re: [PATCH] mn10300: Remove the architecture
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-am33-list@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 10:48 AM, David Howells <dhowells@redhat.com> wrote:
> Remove the MN10300 arch as the hardware is defunct.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> cc: linux-am33-list@redhat.com

Thanks! I've added it to my asm-generic tree now, along with the other
removed architectures. I'll post the remaining patches later when I
have covered the arch specific drivers.

      Arnd
