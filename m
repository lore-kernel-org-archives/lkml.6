Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeB0Wcw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:32:52 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:45947 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeB0Wcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:32:48 -0500
X-Google-Smtp-Source: AG47ELt6T0CM5H2BIS06oDTFacfQ4DYC9sG//InNqTHEjFlz++R/DeomRs8FCaxw3usosTjNC64rpsUETtChe4hAwjY=
MIME-Version: 1.0
In-Reply-To: <a9b65d60-a3c0-f46a-c10e-5d649e75d9ce@infradead.org>
References: <20180227194828.GA29918@bombadil.infradead.org>
 <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org> <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
 <a9b65d60-a3c0-f46a-c10e-5d649e75d9ce@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2018 14:32:47 -0800
X-Google-Sender-Auth: uLgbmzdQeOlOgZj3vgkQQnwVw0Y
Message-ID: <CA+55aFyoeF+99b=9X9Pb8R2Yw4UauFV4x9y2fo-RFBjShWVX3g@mail.gmail.com>
Subject: Re: [PATCH] sparse doesn't support indirect_branch attribute
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 2:30 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> There is also a kernel kbuild patch from Luc that Masahiro has also merged that
> does -Wno-unknown-attributes (or however that is spelled).

That's probably a better interim workaround.

            Linus
