Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeE1JI1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:08:27 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36396 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbeE1JIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:08:23 -0400
X-Google-Smtp-Source: ADUXVKJ/JxEgSsH+89+jslP/lc1i85+ty5Q8DnCelJL5GMYeBchAiYFsi8LIcFV97NHTW15PkV0iIaod62WEOeZbSHk=
MIME-Version: 1.0
In-Reply-To: <20180527184639.GD1564@sirena.org.uk>
References: <20180525173025.GO4828@sirena.org.uk> <20180527184639.GD1564@sirena.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 May 2018 11:08:22 +0200
X-Google-Sender-Auth: O5nKf3d1PiP5wDubuc7vHLREAlk
Message-ID: <CAK8P3a2vmbxYmMqTYb0kHoB3uTcWi_=hL=Wunfw6nqE0NGr+QA@mail.gmail.com>
Subject: Re: linux-next: Tree for May 24
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 8:46 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 25, 2018 at 06:30:25PM +0100, Mark Brown wrote:
>
>> quickly as hoped, sorry.  There should be another linux-next done by me
>> for today (25th) as well, that will appear tomorrow all being well.
>
> There won't be.  For some reason I need to get to the bottom of the
> builds are taking a lot longer than they have previously which has
> caused a whole bunch of problems.
>
>> Stephen should be back on Monday.

One possible reason for slowdown on ARM allmodconfig might be the addition of
KCOV, though that is only enabled in mmotm at the end of your builds.

       Arnd
