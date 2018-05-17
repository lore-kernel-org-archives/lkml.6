Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeEQG1j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:27:39 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40829 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeEQG1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:27:34 -0400
X-Google-Smtp-Source: AB8JxZpQ6Juc50C433dn/JBhc6Vzm1vSSC26/qJe44NLt3oo5k77b8KtemBjxs9a3ixJm4wEI9KaFaeifpwFyF4AIvk=
MIME-Version: 1.0
In-Reply-To: <1526537830-22606-31-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <1526537830-22606-31-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 23:27:33 -0700
X-Google-Sender-Auth: sY8gGXq6-t-qHEjTqXaXRvsU8Ww
Message-ID: <CAGXu5jKjHAnT8666MVWzfK3ZYqwqf3hhDKmJ4gJZ8NUeqM==Aw@mail.gmail.com>
Subject: Re: [PATCH v4 30/31] gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:17 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Now that the compiler's plugin support is checked in Kconfig,
> all{yes,mod}config will not be bothered.
>
> Remove 'depends on !COMPILE_TEST' for GCC_PLUGINS.
>
> 'depends on !COMPILE_TEST' for the following three are still kept:
>   GCC_PLUGIN_CYC_COMPLEXITY
>   GCC_PLUGIN_STRUCTLEAK_VERBOSE
>   GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
>
> Kees said to do so because the first two are too noisy, and the last
> one would reduce the compile test coverage.  I commented the reasons
> in arch/Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I'm really looking forward to these being enabled for COMPILE_TEST. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
