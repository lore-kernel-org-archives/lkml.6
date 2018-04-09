Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeDIQlC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:41:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43559 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753328AbeDIQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:41:01 -0400
X-Google-Smtp-Source: AIpwx4/ScTZgIFFWAQ58FH7JAf+kqQ0GXDDE8FOJvVv7rdQdRleelLt+9xAER7dkUUcDBkrroXSmPr1SsDmxfMd+C3M=
MIME-Version: 1.0
In-Reply-To: <20180409182233.5a9150c5@mschwideX1>
References: <20180403111242.49f43ee7@mschwideX1> <20180409151821.2d92303f@mschwideX1>
 <CAADWXX-188FC4aBjYMaRwrhcUNvoazwZSirPX3Y2P8PuFiV0bQ@mail.gmail.com> <20180409182233.5a9150c5@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 09:40:59 -0700
X-Google-Sender-Auth: 8NgSpqRg2fgJ0c1CfhtzMS6sTEA
Message-ID: <CA+55aFy2qWimgBHPdf_RBMK4O3Cci94bhMz15Z2QxXBe=FhgSA@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 4.17 merge window #1
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 9:22 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>>
>> I'm not finding the original at all, and this 'ping' message I found
>> in my spam-box. Maybe the original was marked as spam too and I didn't
>> notice, and it got deleted with the other spam.
>
> Not good, any idea why the ping message has been marked as spam?
> Maybe there is something in the headers that gives a hint.

There's nothing that looks suspicious to me in the headers, and gmail
doesn't leave any lines around either (ie no spamassassin-like scoring
etc: I don't think they want people gaming the spam detector).

There's the IBM internal spam/AV detector markings (but they all say
"not spam") and spf looks fine too (no dkim).

Maybe it was me fat-fingering the original email, causing the ping to
then be marked spam too. No way to know (although mis-marking email as
spam  without even noticing is definitely not a pattern of mine).

So I suspect it was some random word choice that triggered it.
Hopefully the fact that I marked your ping message as non-spam means
that it won't happen again for me.

I actually check my spam box fairly religiously, because I do get a
ton of spam and kernel emails occasionally do end up being false
positives, and so I check it daily to not be overwhelmed. But I also
obviously just scan it quickly, so the first one being missed and just
deleted in my daily scan is not all that surprising if it triggered
the gmail spam detector randomly.

And even if the false-positive rate is pretty darn small, I get _so_
much spam (because my email address is public and has been so long)
that even a low false-positive rate still means "a couple of
mis-marked messages each week".

              Linus
