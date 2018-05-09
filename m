Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965806AbeEIWEB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:04:01 -0400
Received: from mail.manjaro.org ([176.9.38.148]:51234 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965450AbeEIWD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:03:59 -0400
Subject: Re: [ANNOUNCE] v4.16.7-rt1
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
From: Bernhard Landauer <oberon@manjaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=oberon@manjaro.org; prefer-encrypt=mutual; keydata=
 xsBNBFWiTO0BCADp2m6vJC6HqqA5fbl5c9TfoYZ+7Gc3c+yAsw6eCanyWOE34HXDAGkHDiPO
 zMLbUy0bNsS7jJvjxremNmFuDgXxDZZ5Xslgwj32X6PhcfexVPI0IlceZCQlthXRrsxwMFol
 oYYxVlsrpp/z++dJQ+8pb3yQ90c/TE+hiQdZZRLhXz8w+NIgLpKXb5fRkQQ9VfSpv5jCeUNL
 E/gG7ECkTVQrBUMEAFqSkOXq0PdVptJrC3hjWZGmjdCA4I515Tm6T5QqPKWRyaoG/w57dFc9
 Aq3ExZ19Txtxf6H/0wKDZa53fRGjYaQUuJzZYhhzC6JETPZARbzDe86FEjpQlwa23gW1ABEB
 AAHNJkJlcm5oYXJkIExhbmRhdWVyIDxvYmVyb25AbWFuamFyby5vcmc+wsB3BBMBCAAhBQJV
 okztAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJENrTshFmPKJoDyUH/iMOmPfFdE22
 4mw3WYvtEXBryv42ATeLTxdGMzAaDZCZreGtc0NGsaYcIe4csT8/ON1Y8I60vIfp4lk0VvK5
 N0G85922sHT969v7bEUmN8xSG2dhAgsuqZReQD80JVpFez9KU599dPPX7DaVFXz5JvzlKYMQ
 RJOiLP6N+pdMiBbG9DXetxBBmr4IqM964NDJwLH3SNEzjQUr+8DxRi5pTWu1UKDnW2y5z2qP
 EEtYr8SJT3qy1gctsq1JYG2H/fLMEIXcZm/lBMfq8H2IQLyHm/WumkJKfTOmgMlbGVkzFT9W
 XxjPtQ+p50Aa79ti2wbZKYXLcy3NuFxbBGhNnOSYjlnOwE0EVaJM7QEIAMFIlWIATFKmAIz+
 kXJDdCV6Yfy2ptEphN0iaU6mj4jcBdaBcUzpDFSE1z5R6LqGyZ59DVsxW4Dk85CLrpY5+qGU
 FmtWwLD8LniXRUG385r/QD9aMP2b86WKfkK2cTCt81I3907N5shS2Ypq1dRrQhr7P6Wj0Cla
 r1nZWcnqV9dvwRnhMtKM3sZ2+120qRPiIVRnShAJ9OqUYStGUpk1h+W60Nt+cnFLPLc6wGD2
 QvLIv6Lk+Gonzq/yKDNbLArIlkECUBcu9NbDnsp7SGNGTuP1zP7ofvxEabfCLOrH9H8c0hlF
 QfiB1v6lqvGsb+al0H7szpN9e9H+5QtteAhPKisAEQEAAcLAXwQYAQgACQUCVaJM7QIbDAAK
 CRDa07IRZjyiaB/bCADaMnHznD5HY0FqMJciZzFtbZxLHsbGFEJx+RRGmo8AKx5hODNA+D4o
 blwkzafgbPnqACiLP9lt3y7eUZyKG61ZHOjREjRQvyBjc4O4YcGq1AcLzWbEzaq9ZJkALCC+
 84mHvsKzUzK+w8X4iJAmp4pwUBf4mKLrf7qMr1v3erYzdi71/qaTCesMKZ++GTQTjPEgiA0K
 LOmOiQMO2YkO8tqO6FJ2RU2zS/LGSaImfDUIU6Dvw19De2em793bSogTWdhS8P2jk60wj7h0
 xX7uevNZ1IIdD51gMQzgHF1bMj7QT4oSmFLLZJdYGItkODdblxSS8Dy6DumXbZLDoA+/XJ7W
Message-ID: <2d6d2b49-07ce-7125-6086-91a4b6826f4f@manjaro.org>
Date: Wed, 9 May 2018 23:45:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/18 18:29, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v4.16.7-rt1 patch set. 
>
> Changes since v4.14.39-rt28:
>
>   - Rebase to v4.16
>
>   - The queue went through a big cleanup and reordering, so the patches
>     which belong together are not scattered all over the place.
>
>     The sections at the front of the series are patches which are either
>     upstream already (4.17), queued in a maintainer tree for 4.18, posted
>     and under discussion or just ready to be posted.
>
>   - A large section covers the recent rework of the *_nort/*_rt()
>     wrappers. Instead of trying to argue them upstream they have been made
>     obsolete by refactoring the code in which they have been used. There
>     are a few hard to solve leftovers, but non of them should survive.
>
>   - The cpu_chill() related try-lock-loop in dcache has been replaced
>     with a rework avoiding the loop. The rework was joint work by Al
>     Viro and John Ogness.
>
>     There are still a few cpu_chill() instances which are going to be
>     tackled in the next weeks.
>
>   - The AT91 timer patches have been mostly replaced with the "TCB timer
>     driver" patches by Alexandre Belloni.
>
>   - The latest version of the latency tracer patches which is aimed for 4.18
>     has been incorporated.
>
> You can get this release via the git tree at:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.7-rt1
>
> The RT patch against v4.16.7 can be found here:
>
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.7-rt1.patch.xz
>
> The split quilt queue is available at:
>
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.7-rt1.tar.xz
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

When compiling 4.16.7-rt1 with gcc 8.1.0 I see tons of these warnings:

warning: objtool: mISDN_FsmEvent()+0x27: sibling call from callable
instruction with modified stack frame

Any ideas what to make of these?

regards
Bernhard
