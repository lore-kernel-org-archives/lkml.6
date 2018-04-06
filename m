Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeDFEe5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:34:57 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:40342 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeDFEej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:34:39 -0400
X-Google-Smtp-Source: AIpwx495RY0Lv/2dqXu3o5uRG2/sz5f/3bdv7CPJ0X2DU0zgVVZnKhR2/LZSrknvrVVzte5x6zu93IkW6YL7SvEg5Ug=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1rJc+3MMMwcYSZ0n14=5e_1v_UdnHexysuqy4RfQPxmA@mail.gmail.com>
References: <CAK8P3a1rJc+3MMMwcYSZ0n14=5e_1v_UdnHexysuqy4RfQPxmA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 21:34:38 -0700
X-Google-Sender-Auth: ldjgrOTrGO3vzO8MgTLHF6aFx-c
Message-ID: <CA+55aFzTKu8um8wu5EtZS83+vepPnGM9KG+fPZ91ZjTESOatYg@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: SoC driver updates for 4.17
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 2:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> - the ARM CCN driver is moved out of drivers/bus into drivers/perf,
>   which makes more sense. Similarly, the performance monitoring
>   portion of the CCI driver are moved the same way and cleaned up
>   a little more.

This caused a trivial merge with the perf tree.

But since I don't *build* the trivial merge resolution due to it being
an arm-only file, I wanted to point it out.

Because "not tested" very possibly means "I screwed something silly up
and didn't notice".

So as trivial as it seemed, it should still be checked.

                Linus
