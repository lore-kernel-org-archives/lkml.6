Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeCFRQw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:16:52 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:39043 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753864AbeCFRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:16:48 -0500
X-Google-Smtp-Source: AG47ELvV4/JVfaSGosA3qhKDfL1h8Um9wUHkBu0WxH2l1oWaCZG946szhUIFSnJyQjdR1ygFvlxQe6cfzH0fAKgvJI8=
MIME-Version: 1.0
In-Reply-To: <1519965121-12017-2-git-send-email-yamada.masahiro@socionext.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com> <1519965121-12017-2-git-send-email-yamada.masahiro@socionext.com>
From: Tony Luck <tony.luck@intel.com>
Date: Tue, 6 Mar 2018 09:16:46 -0800
X-Google-Sender-Auth: Yo7vvrwpV0eAFqhoyR6wzV1AIuI
Message-ID: <CA+8MBbLjdViZgUYuLT1qDAnxtBP62pCXnvNMbUCjZ=RP8Ok=Dw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] kbuild: define PYTHON2 and PYTHON3 variables
 instead of PYTHON
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Thu, Mar 1, 2018 at 8:31 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> arch/ia64/scripts/unwcheck.py is apparently written in Python 2, so
> it should be invoked by 'python2'.

I pushed the patch from Corentin Labbe to update this script to run with either
python2 or python3. Linus took it yesterday:

bd5edbe67794 ("ia64: convert unwcheck.py to python3")

-Tony
