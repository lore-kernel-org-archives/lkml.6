Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeBRSRN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 13:17:13 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41995 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeBRSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 13:17:11 -0500
X-Google-Smtp-Source: AH8x227BTgQgpYG6SxN9MRNJUFyX2slZbt9HY68qAkDrWuFw8/azpEe1E+yI9cuoehlBw+pt/AdVtKYxMpw9qoC3kIg=
MIME-Version: 1.0
In-Reply-To: <201802181252.JLYjDsVL%fengguang.wu@intel.com>
References: <1518752264-47238-2-git-send-email-keescook@chromium.org> <201802181252.JLYjDsVL%fengguang.wu@intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 18 Feb 2018 10:17:09 -0800
X-Google-Sender-Auth: 5wxXF8eV2ZLrjPtsAI5n__Lz8lw
Message-ID: <CAGXu5jKCU4HBdQvgqOc4cQpQ7CktO5YFmDSoAeppBDbgimZDiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] taint: Convert to enum and indexed initialization
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 9:03 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Kees,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc1 next-20180216]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Kees-Cook/taint-Add-taint-for-randstruct/20180218-100113
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>    /tmp/ccUwVEny.s: Assembler messages:
>>> /tmp/ccUwVEny.s:897: Error: invalid operands (*UND* and *ABS* sections) for `<<'
>    /tmp/ccUwVEny.s:932: Error: invalid operands (*UND* and *ABS* sections) for `<<'
>    /tmp/ccUwVEny.s:1116: Error: invalid operands (*UND* and *ABS* sections) for `<<'

Ugh, it looks like an enum can't be used here because of assembly
files? I'll try to figure this out...

-Kees

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Kees Cook
Pixel Security
