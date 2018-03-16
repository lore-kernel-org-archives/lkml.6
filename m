Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeCPSip (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:38:45 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:38932 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbeCPSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:38:41 -0400
X-Google-Smtp-Source: AG47ELstwxTo+vzocUhOgsna1ejGEnQlzT2KtCUEFvvuBL75ywl6fyCY6JdTZAcjM8xJbhr0DxxYf+C7pBdEjl36yrM=
MIME-Version: 1.0
In-Reply-To: <20180316110907.GK3523@nataraja>
References: <CAPqSeKv0Q+ocBYeonxi5w8XB0vaM27O1hcDm9ZDdXxCt7Py=Pw@mail.gmail.com>
 <20180316110907.GK3523@nataraja>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Mar 2018 20:38:40 +0200
Message-ID: <CAHp75VeU=WxCHW6wL2sgS5Ne3hNpQ5pEUa-u-dOiJ-0+yV5iFg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: add support to mute and
 hardware optical switch
To: Harald Welte <laforge@gnumonks.org>
Cc: Kenneth Chan <kenneth.t.chan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 1:09 PM, Harald Welte <laforge@gnumonks.org> wrote:
> Hi Kenneth,
>
> thanks for your fix.  I'm not currently using any Panasonic Laptop devices
> anymore (After the CF-R series was discontinued), so I'm not able to properly
> maintain this driver anymore.
>
> However, your changes look sound to me (aside from that we don't use C++ style
> comments in kernel source code), hence:
>
> Acked-by: Harald Welte <laforge@gnumonks.org>

I'm not sure I ever seen the original patch. Patchwork also misses it.


-- 
With Best Regards,
Andy Shevchenko
