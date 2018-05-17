Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeEQGln (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:41:43 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38255 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeEQGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:41:41 -0400
X-Google-Smtp-Source: AB8JxZrJ3v0LFjSudQ+6vfR/HBmgMVvs7DogoEqE+Jp2vLSSk6ydm+MFRBa3eh5SIXv3YKL6AU+G2rhcZpjxS97tHiY=
MIME-Version: 1.0
In-Reply-To: <1526537830-22606-21-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <1526537830-22606-21-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 23:41:39 -0700
X-Google-Sender-Auth: 0WwDdR2TLjke6k-Yaegse2I5KEQ
Message-ID: <CAGXu5jJV0uwxhU_KtLU29rdLwC5M4OmaPqD86Uwv+-jsbW3Maw@mail.gmail.com>
Subject: Re: [PATCH v4 20/31] kconfig: test: add Kconfig macro language tests
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
> Here are the test cases I used for developing the text expansion
> feature.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Should these be tied to the global Makefile or selftests in any way?

-Kees

-- 
Kees Cook
Pixel Security
