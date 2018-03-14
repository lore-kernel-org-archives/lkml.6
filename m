Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCNU7B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:59:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46113 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCNU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:58:59 -0400
X-Google-Smtp-Source: AG47ELvUrMr+9Bz7T614RwYdC0tsx5gYa9GX9KEeLqzgBWZN4RNowhmhY9m+JJHno3FWfC0IekSU/ofOKPtlDRAoLdw=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyiM9apbksAvYn7ECaed2F9q7YJk7Vv_iA=ogLKxD4R0w@mail.gmail.com>
References: <20180313184652.dzjmoxs7zl4ocrfw@gmail.com> <CA+55aFyiM9apbksAvYn7ECaed2F9q7YJk7Vv_iA=ogLKxD4R0w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Mar 2018 21:58:36 +0100
Message-ID: <CANiq72n+RFccG7LUf6UUJmRAmoR3j8jgi0YSJWVMLRcxYPPfsg@mail.gmail.com>
Subject: Re: [GIT PULL] auxdisplay for v4.16-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>, Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 5:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 13, 2018 at 11:46 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> This is my first pull request, so if there is anything wrong, please let
>> me know!
>
> The commits in there looks fine, but I have to admit to not being
> super-happy about it.  They are recently rebased, and looking around
> in the logs you've been gone for the last eight years.

Yeah, I came back a couple of months ago. The story is long and
boring, but basically drivers/auxdisplay/ came to be due to my
submission of a driver more than 10 years ago. Due to that I was made
maintainer of that folder with that driver alone (so maintainer of
myself! :-).

Later I started university and after all those wild years, it seems
the folder grew without me noticing. I attribute this due to my change
of gmail account, plus my own stupidity when setting up the email
filters in the new account. I don't recall anymore, but the filters
were wrong when I checked two months ago anyway, so I have to blame
myself.

So when two months ago I searched for "auxdisplay" by chance, and
noticed there were dozens of matches, I opened my eyes wide in
disbelief, panicked a couple of seconds, then I sighed a lot, and then
started going one email by one... :-)

I have a few things from different people that I have to send in the
next merge window. But since I had never sent stuff before, and didn't
want to screw things in the next merge window, I thought that the best
approach was to do my first PR now with some trivial changes and see
if everything is alright (also, one of them fixes the warnings from
the build service, so we get that cleaned up as well).

The author dates are real, though: I started them when I was
reorganizing myself a few weeks ago. I hope that explains it the
disparity... And indeed, I rebased them before sending them to have
them on top of -rc5.

>
>> Also, note that for the moment my PGP/GPG key is only signed by 2 other
>> kernel maintainers and that we did it over email/Skype. I used GitHub
>> as well for the same reason.
>
> Ok, I see Linus Walleij's signature there, and the individual commits
> look trivially correct, so I'm pulling it, but with a bit of grumbling
> about the timing.

Yep, Willy Tarreau & Linus Walleij should be there. I contacted a few
others and they agreed to sign it, but they preferred to do so in
person. I could have other contacts to sign the key (e.g. people from
CERN), but I think it has to be kernel maintainers according to
kernel.org.

Thanks for the permissiveness (this time at least :-)!

Cheers,
Miguel

>
>                  Linus
