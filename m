Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeCGCXr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:23:47 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:49615 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeCGCXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:23:45 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w272NRtY014002
X-Nifty-SrcIP: [209.85.217.178]
X-Google-Smtp-Source: AG47ELsQtzNTfqH+q3dyl9JZ5RcDUmC3ALAuow7NXLoJzmQR/GLJuuiD8y0GmRgMp57v5aGdDPMpixozTe2EDvV264M=
MIME-Version: 1.0
In-Reply-To: <CA+8MBbLjdViZgUYuLT1qDAnxtBP62pCXnvNMbUCjZ=RP8Ok=Dw@mail.gmail.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
 <1519965121-12017-2-git-send-email-yamada.masahiro@socionext.com> <CA+8MBbLjdViZgUYuLT1qDAnxtBP62pCXnvNMbUCjZ=RP8Ok=Dw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 7 Mar 2018 11:22:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARc+4n6B1c0LXigAfffnpUqY3GSVw+rw5PQP9VrOxbOuw@mail.gmail.com>
Message-ID: <CAK7LNARc+4n6B1c0LXigAfffnpUqY3GSVw+rw5PQP9VrOxbOuw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] kbuild: define PYTHON2 and PYTHON3 variables
 instead of PYTHON
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-07 2:16 GMT+09:00 Tony Luck <tony.luck@intel.com>:
> On Thu, Mar 1, 2018 at 8:31 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> arch/ia64/scripts/unwcheck.py is apparently written in Python 2, so
>> it should be invoked by 'python2'.
>
> I pushed the patch from Corentin Labbe to update this script to run with either
> python2 or python3. Linus took it yesterday:
>
> bd5edbe67794 ("ia64: convert unwcheck.py to python3")
>
> -Tony

Thanks for the reminder!

Yeah, I noticed this commit yesterday.
Now, unwcheck.py seems to be compatible
with both Python 2.x and 3.x
(I have not tested it, but I understood so from the
commit log.)

I will keep 'PYTHON' and arch/ia64/Makefile as they are.

I will just add 'PYTHON2' and 'PYTHON3'.




-- 
Best Regards
Masahiro Yamada
