Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeDONkM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 09:40:12 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:40552 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeDONkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 09:40:10 -0400
X-Google-Smtp-Source: AIpwx49je84JUuj1jdBhyGrfy05vrLwaZu1IOGhc7IzsA3Dfh5KI7mxwz39fkjFk+7GV66k/aqGGVzG8DD1Nh5GE7rM=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyoY+cOrU1BnZwu8ytWKuCOfPaxziynAMDSe0dwR-PaGQ@mail.gmail.com>
References: <20180412183754.lyql6ihg6tcegebi@gmail.com> <CA+55aFyoY+cOrU1BnZwu8ytWKuCOfPaxziynAMDSe0dwR-PaGQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Apr 2018 15:39:49 +0200
Message-ID: <CANiq72=R22wMbF=tbEPKtCbe=psSgrMT4CqqZLOLL9TfJm_OsQ@mail.gmail.com>
Subject: Re: [GIT PULL] auxdisplay for v4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Abel <rabel@robertabel.eu>, Sean Young <sean@mess.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 12:50 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 12, 2018 at 11:37 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Please pull these fixes and cleanups for auxdisplay.
>
> As far as I can tell, none of this has been in linux-next.
>
> By the end of the merge window, I styart getting a whole lot more anal
> about what I pull. In particular, if people send me pull requests
> late, I had better get the warm fuzzy feeling of "at least it's been
> tested in linux-next".

Yeah, no worries -- I was late, so I suspected as much :-)

Do you prefer I re-send it for -rc2, send it to linux-next, wait for
4.18 or just wait until you pull at some point?

Thanks,
Miguel
