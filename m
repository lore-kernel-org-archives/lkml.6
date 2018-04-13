Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeDMWu4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 18:50:56 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:37317 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDMWuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 18:50:55 -0400
X-Google-Smtp-Source: AIpwx4+plAmIyvVlPv9t/b6csNl7wOfj79xd9yP31sKB1jyR0BsD2m3+FnqUcM47esmcBIv8nSb+OH1drDkbAlcab3w=
MIME-Version: 1.0
In-Reply-To: <20180412183754.lyql6ihg6tcegebi@gmail.com>
References: <20180412183754.lyql6ihg6tcegebi@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 15:50:53 -0700
X-Google-Sender-Auth: rwRTDEWor5sGKGP06rGpujkEwrw
Message-ID: <CA+55aFyoY+cOrU1BnZwu8ytWKuCOfPaxziynAMDSe0dwR-PaGQ@mail.gmail.com>
Subject: Re: [GIT PULL] auxdisplay for v4.17-rc1
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Thu, Apr 12, 2018 at 11:37 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Please pull these fixes and cleanups for auxdisplay.

As far as I can tell, none of this has been in linux-next.

By the end of the merge window, I styart getting a whole lot more anal
about what I pull. In particular, if people send me pull requests
late, I had better get the warm fuzzy feeling of "at least it's been
tested in linux-next".

These may be recently rebased, but there isn't even anything
*non-rebased* in linux-next as of the beginning of this week.

              Linus
