Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeAaJxU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:53:20 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:42172 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeAaJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:53:17 -0500
X-Google-Smtp-Source: AH8x226gHztb78Luke+sdMYXhSo7VayRtkxsCHrBU2dqZq94FlHlkhNABnMxdxtyZZCul9NrTIC+nLEfrySsPbuDGEk=
MIME-Version: 1.0
In-Reply-To: <1517344262.2230.27.camel@tiscali.nl>
References: <20180130181853.32512-1-ulfalizer@gmail.com> <1517337292.2230.15.camel@tiscali.nl>
 <CAFkk2KSUpEvCCt0fUzCN+r7Lz9CuyN3jKV6atpPR92zPRK4f-w@mail.gmail.com> <1517344262.2230.27.camel@tiscali.nl>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Wed, 31 Jan 2018 10:53:15 +0100
Message-ID: <CAFkk2KTCcDH8c5BVzAZHykH3jRmPxt36wqr0PHSw1Hhr3DUoBw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Warn if help text is blank
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 9:31 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Tue, 2018-01-30 at 20:33 +0100, Ulf Magnusson wrote:
>> I agree that this shouldn't go in until/unless a significant portion
>> of those empty help texts get removed first.
>
> Not a significant portion, but all, I'd say.
>
>> The patchset that removes the empty help texts is at
>> https://lkml.org/lkml/2018/1/30/574. I could make another one if you'd
>> prefer that.
>
> I'm fine with anything that doesn't add warnings just to appease pet peeves.
>
>> I haven't even checked how they are rendered to be honest. I was more
>> concerned with the Kconfig mess.
>
> Well, if you could make empty help texts disappear somehow (either during the
> Kconfig parse phase - which requires a jump into the yacc horror - or during
> the rendering phase) that would be much better than adding a warning for
> something that you yourself described as a pet peeve.
>
> And after that's done you're free to send cleanup patches for this whenever
> you feel like doing so.
>
> Thanks,
>
>
> Paul Bolle

I rolled a new patchset which adds the warning at the end and makes
the commits that remove the blank help texts more freestanding:
https://lkml.org/lkml/2018/1/31/137

Cheers,
Ulf
