Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeDMMWT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:22:19 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:27830 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeDMMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:22:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w3DCM2LJ016238
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AIpwx4/+zUdwud1lCWGe/qXNfbGJERaJ6cZqPUWYhtWUFiquXjXHd11AcvGZqSXVH8AYUSa/O3/LO7RmA2ogabBpV78=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJJ+kUZ7ETEDB4hmUUMjFa2A6+vbPkm+0f-S1zZ=ZYT3g@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jJJ+kUZ7ETEDB4hmUUMjFa2A6+vbPkm+0f-S1zZ=ZYT3g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 13 Apr 2018 21:21:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrWiJZ0qOvjut5BxRXahgQZ7gjpF1WRvCGxvF2Qq74PA@mail.gmail.com>
Message-ID: <CAK7LNASrWiJZ0qOvjut5BxRXahgQZ7gjpF1WRvCGxvF2Qq74PA@mail.gmail.com>
Subject: Re: [PATCH 00/30] kconfig: move compiler capability tests to Kconfig
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-13 14:52 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Thu, Apr 12, 2018 at 10:06 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> [Major Changes in V3]
>
> Awesome work! I don't see this pushed to your git tree? I'd like to
> test it, but I'd rather "git fetch" instead of "git am" :)
>
> -Kees
>

I pushed this series to the following branch.

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kconfig-shell-v3



-- 
Best Regards
Masahiro Yamada
