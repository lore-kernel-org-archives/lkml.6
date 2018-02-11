Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbeBKWpd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 17:45:33 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:40510 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbeBKWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 17:45:30 -0500
X-Google-Smtp-Source: AH8x224LUjqUUAbTZQe/Ym1zlCltyKJy7/QT1tLFR89nfSM8nyQt/1tQOKBL48x1hXGbYsv22iOfn4yDijDjS+SPEg0=
MIME-Version: 1.0
In-Reply-To: <20180210192356.GP30522@ZenIV.linux.org.uk>
References: <20180210192356.GP30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 14:45:28 -0800
X-Google-Sender-Auth: -ecm4p69Uz_DoenKm4N_h-sb9GQ
Message-ID: <CA+55aFyaoLAh0Ar4a+xHzVZtvP=0423jCWtc3kV5Ncm-UqCHiA@mail.gmail.com>
Subject: Re: [git pull] poll annotations - second round
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 11:23 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> (ideally - just before -rc1)

Ok, merged and scripted and final patch applied. It's going through
the allmodconfig test after that final patch, but I'll make -rc1 once
that's done, and hopefully we are done with the whole EPOLL/POLL
confusion.

.. and yes, I'm sure we'll be picking up straggling new uses of the
POLL* macros for months or years.

            Linus
