Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEQG3C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:29:02 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38633 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeEQG27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:28:59 -0400
X-Google-Smtp-Source: AB8JxZqf8N4Le2n5Zb+qGjZ0rj9a/Qu085EZwP6fwI1nKtWV6VTx0/R58cAMpa1Fdt3I+JhbqrqQaHN+C2flVKjsbcE=
MIME-Version: 1.0
In-Reply-To: <1526537830-22606-7-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <1526537830-22606-7-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 23:28:58 -0700
X-Google-Sender-Auth: 9l5bY2II-LtCB6n1OOhxP-YdkhQ
Message-ID: <CAGXu5j+iAHM06OnJ8ECt1ZHHRrX+J++dy=pSSJf-kb0Z2C+8Cw@mail.gmail.com>
Subject: Re: [PATCH v4 06/31] kconfig: remove sym_expand_string_value()
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

On Wed, May 16, 2018 at 11:16 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> There is no more caller of sym_expand_string_value().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Easy to review! :)

-Kees

-- 
Kees Cook
Pixel Security
