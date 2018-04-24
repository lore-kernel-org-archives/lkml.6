Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDXWDm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:03:42 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38278 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeDXWDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:03:40 -0400
X-Google-Smtp-Source: AIpwx49knyC7Gm5u6QpH9+EhUnVNdqN1TNqWgMzki1osEEHlQ4gaMfFJEiVitSf+rtmznJJ9gIDGEZuOY+CbthYBVN8=
MIME-Version: 1.0
In-Reply-To: <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk> <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
 <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk> <87zi1sd28d.fsf@xmission.com>
 <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
From: =?UTF-8?Q?Martin_P=C3=A4rtel?= <martin.partel@gmail.com>
Date: Wed, 25 Apr 2018 01:03:39 +0300
Message-ID: <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault
 in relay_signal.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        "user-mode-linux-devel@lists.sourceforge.net"
        <user-mode-linux-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OM3kxm006475

And once more in plain text..

On 25 April 2018 at 01:00, Martin Pärtel <martin.partel@gmail.com> wrote:
>
> Hi all,
>
> This was ages ago, but from what I remember...
>
>>
>> Having a second look I really don't understand what relay_signal is
>> trying to do.
>>
>> The function relay_signal does not pass siginfo through unchanged.
>
>
> Just copying the entire struct would do the wrong thing. It was discussed here:
> https://marc.info/?l=user-mode-linux-devel&m=133910707911999&w=2
>
>>
>> Am I missing something subtle or have the subtle details of siginfo just
>> always been ignored?
>
>
> My guess is they have. I was almost certainly oblivious to such subtleties when writing my commit.
>
