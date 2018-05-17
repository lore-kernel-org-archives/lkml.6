Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeEQGtM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:49:12 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:42522 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeEQGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:49:11 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4H6n14A023680
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AB8JxZq5p9EuSHXrowLbOnxkEK7CzzJDXpvcICeyVMNp1Uzny9UTtOE2uqXG48OwQsIDPNNR9w3mtuzlaHpdXZePM/I=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJV0uwxhU_KtLU29rdLwC5M4OmaPqD86Uwv+-jsbW3Maw@mail.gmail.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-21-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jJV0uwxhU_KtLU29rdLwC5M4OmaPqD86Uwv+-jsbW3Maw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 17 May 2018 15:48:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5F-cN7mnZnAFLMc9NwpKYByiipoQCi1iyEJfnLJ1qGg@mail.gmail.com>
Message-ID: <CAK7LNAT5F-cN7mnZnAFLMc9NwpKYByiipoQCi1iyEJfnLJ1qGg@mail.gmail.com>
Subject: Re: [PATCH v4 20/31] kconfig: test: add Kconfig macro language tests
To: Kees Cook <keescook@chromium.org>
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

2018-05-17 15:41 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Wed, May 16, 2018 at 11:16 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Here are the test cases I used for developing the text expansion
>> feature.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Should these be tied to the global Makefile or selftests in any way?
>
> -Kees
>

It is already.

"make testconfig" will run Kconfig unit tests.

You need python3 and pytest for that.


-- 
Best Regards
Masahiro Yamada
