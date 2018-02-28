Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeB1OKg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:10:36 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33351 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeB1OKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:10:34 -0500
X-Google-Smtp-Source: AG47ELttcc5LHNw+/B4r8d0avB3JnynmwSJtQVyXmTbhtsR6o8tJ5B2BbymK46MDmLtLCTnRpYZKeBNwCT9eUR3ar4w=
MIME-Version: 1.0
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Wed, 28 Feb 2018 19:40:33 +0530
Message-ID: <CAMet4B7UraUZNO9rHyr3xxpJGcijffAK9YpYmOxA2Ax4eGfFgw@mail.gmail.com>
Subject: Re: NETDEV WATCHDOG: eth0 (tg3): transmit queue 0 timed out
To: Borislav Petkov <bp@alien8.de>
Cc: Linux Netdev List <netdev@vger.kernel.org>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 3:48 PM, Borislav Petkov <bp@alien8.de> wrote:
> Hi,
>
> this didn't happen before but after 4.16-rc1 my tg3 nic stops for
> whatever reason and the connection to the machine is dead. It didn't show
> anything in dmesg until today.
>
> The IO pagefaults look like it is trying to access something it
> shouldn't and maybe that's why it times out.
>
> It triggers pretty quickly so I'd call it a reliable reproducer and thus
> I can test patches... :-)
>
> Thx.
Thanks for reporting this. Somehow, this mail moved to my spam folder.
Hence, delay in response.
Looks like this is similar to below issue and it was reported some time back.
https://www.spinics.net/lists/netdev/msg482757.html
We are actively working on this. We will soon provide you an update on this.
