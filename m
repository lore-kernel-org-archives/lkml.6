Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeEQGc2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:32:28 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45569 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQGc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:32:27 -0400
X-Google-Smtp-Source: AB8JxZpHDZBSY0KCchXAjHRFX1LOoyAeXF9IB1JlAvM5+f13QO9lMm09Y/BAhqBHtKwe3CLqvryC/jhG1FjSKI6DsU8=
MIME-Version: 1.0
In-Reply-To: <1526537830-22606-30-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <1526537830-22606-30-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 23:32:25 -0700
X-Google-Sender-Auth: 8WPDj44_GHY616sHjtcySk0t61s
Message-ID: <CAGXu5jLMRfLurNe04WoK3kLHvTYFEHyUz1vMyGf4dLBkOmTnAQ@mail.gmail.com>
Subject: Re: [PATCH v4 29/31] gcc-plugins: test plugin support in Kconfig and
 clean up Makefile
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
> Run scripts/gcc-plugin.sh from Kconfig so that users can enable
> GCC_PLUGINS only when the compiler supports building plugins.
>
> Kconfig defines a new symbol, PLUGIN_HOSTCC.  This will contain
> the compiler (g++ or gcc) used for building plugins, or empty
> if the plugin can not be supported at all.
>
> This allows us to remove all ugly testing in Makefile.gcc-plugins.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
