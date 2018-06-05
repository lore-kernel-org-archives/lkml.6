Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeFEWdl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:33:41 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33934 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeFEWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:33:39 -0400
X-Google-Smtp-Source: ADUXVKLa9XNE+zsn9U49Wc8bVrf5xKXIhNav4ofImrHrw0aVcuJh8IA1A1cre20H0Rn1YWqj8gZzhHRcoZqePXRahfM=
MIME-Version: 1.0
In-Reply-To: <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
References: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
 <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com> <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Jun 2018 00:33:38 +0200
X-Google-Sender-Auth: G3WNeTAZ4kcZA9nmIOFAZ4LhDRk
Message-ID: <CAJZ5v0gV6DronpzDyDFbh6uJ7AHmFg4T0J-kb=V4jL_8As2zTQ@mail.gmail.com>
Subject: Re: [GIT PULL] Device properties framework update for v4.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:39 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 5, 2018 at 10:30 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Honestly, this looks questionable to me.
>>
>> I'm not talking about the changes themselves - I can live with them.
>> But the _rationale_ is pure and utter garbage, and dangerously so.
>
> Side note: I've merged it, and it's going through my build tests, so
> it's really not that I hate the code.
>
> But I really find that kind of one-sided rationale that ignores
> reality unacceptable.
>
> And I find it dangerous, because it *sounds* so "obviously correct" to
> people who don't know any better. If you don't know that gcc
> explicitly says that you should use unions to do type punning to avoid
> aliasing issues, you might believe that union type punning is a bad
> thing from that commit message.
>
> So it's dangerously misleading, because lots of people have a
> dangerous reverence for paper over reality.
>
> In programming, "Appeal to Standards" should be considered a potential
> logical fallacy. Standards have their place, but they definitely have
> their caveats too.

Well, AFAICS the point was that the union aliasing was not
particularly useful in this case and it clearly was avoidable.  The
changelog could do a better job at explaining that, though, sorry
about that.

And thanks for merging it in spite of your concerns!

Rafael
