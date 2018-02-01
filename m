Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeBARI7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:08:59 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53779 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeBARIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:08:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w11H8b45007290
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AH8x224mahsvLyH4E4vCYYJ6p5K2UbZ1EwxXkTcIECnaUKgdmsZANDK5hSn3hFO2SOPfGiR2UjLH4R6T2qqsSxe8YZw=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KQxPnwMKmvhCoKQ0BBciTc5JKqjJqHGHAMR5uHF0w13sg@mail.gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com> <CGME20180131093527epcas2p3978f33b8407c31bd95e01bca682346da@epcas2p3.samsung.com>
 <20180131093434.20050-3-ulfalizer@gmail.com> <3132455.r9uCTL3ZTk@amdc3058> <CAFkk2KQxPnwMKmvhCoKQ0BBciTc5JKqjJqHGHAMR5uHF0w13sg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Feb 2018 02:07:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7kD1nqP6fG+TPKN4m4xV6mwHaEEM73E1UoBJohN6s6Q@mail.gmail.com>
Message-ID: <CAK7LNAQ7kD1nqP6fG+TPKN4m4xV6mwHaEEM73E1UoBJohN6s6Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] video: fbdev: kconfig: Remove blank help text
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-02 1:56 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Thu, Feb 1, 2018 at 4:52 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> Hi,
>>
>> On Wednesday, January 31, 2018 10:34:21 AM Ulf Magnusson wrote:
>>> Blank help texts are probably either a typo, a Kconfig misunderstanding,
>>> or some kind of half-committing to adding a help text (in which case a
>>> TODO comment would be clearer, if the help text really can't be added
>>> right away).
>>>
>>> Best to remove them, IMO.

FYI.

I picked up this patch to kbuild
because I need this to suppress warning messages
introduced by 11/11.

I am planning to send a PR for this series.


-- 
Best Regards
Masahiro Yamada
