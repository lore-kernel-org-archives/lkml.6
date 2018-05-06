Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbeEFIQ0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 04:16:26 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:37006 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeEFIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 04:16:24 -0400
X-Google-Smtp-Source: AB8JxZrY5yMPchqsYlYQc+aBzus1AF3JgotOkIbNF31QvpuMrl64JssaQwSK+55WRErNXdR9lSWzShZnSwXcfi8oPVs=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sun, 6 May 2018 10:16:21 +0200
Message-ID: <CA+icZUWtYwGRvqtfvex6-0WjStZBhw8ieVFRsGjPfF8ySSoV6Q@mail.gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: Matthias Kaehlcke <mka@chromium.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Manoj Gupta <manojgupta@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> Moreover, a test-case can be helpful, e.g. "Is clang clobbering RCX?"
> when it's a clang-bug.
>
> I tried to find some suitable test-case myself.
>
> The clang-source has a test-dir, but this is new to me.
>
> I tried to run a single test like test/Sema/asm.c in [1] with
> llvm-tools Debian-package which ships "lit.py" script.
>
[...]

> [1] https://raw.githubusercontent.com/llvm-mirror/clang/master/test/Sema/asm.c
> [2] https://llvm.org/docs/CommandGuide/lit.html
> [3] https://llvm.org/docs/TestingGuide.html
> [4] https://llvm.org/docs/TestSuiteMakefileGuide.html

In [5] are some hints on running a single test...

- Sedat -

[5] http://clang.llvm.org/hacking.html
