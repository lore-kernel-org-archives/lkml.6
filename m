Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeBVVXK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:23:10 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:46540 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBVVXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:23:08 -0500
X-Google-Smtp-Source: AG47ELuaZ58X4kVhRPHiQh+kaQV/ljEtv3+7pM/WzwCh+qXB+Yf1g6omkOwuC1mdxc1P87floBUnITPCBrjUtNO8zFE=
MIME-Version: 1.0
In-Reply-To: <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk>
References: <20180222174140.GA3154@beast> <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
 <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 13:23:07 -0800
X-Google-Sender-Auth: O2KvGge2Mham9lHL1qqbLcv3hgk
Message-ID: <CA+55aFywUNouK-Y1qbnkwxM3G_WLdDVFdC0po-Xj01G4UsfSAw@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
        Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 1:07 PM, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> It does, both per the documentation and testing it. But fixdep
> explicitly removes include/linux/kconfig.h along with
> include/generated/autoconf.h and a few others. So when you rebuilt after
> adding the #include to kconfig.h, I think nothing actually got built,
> and no new .o.cmd files got generated.

Hah. So it was the lack of kconfig.h dependency that bit my testing ;)

           Linus
