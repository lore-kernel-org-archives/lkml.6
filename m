Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965023AbeBUOyp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:54:45 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:55893 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936777AbeBUOyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:54:43 -0500
X-Google-Smtp-Source: AH8x227bTiJEcM0nIPUvvtSCDRYwaPH0WtAgyjQPgbgOL8c4kkzvDBOnciZEPW6ivtLONQBMWAmyBKnvoanHDUI3nns=
MIME-Version: 1.0
In-Reply-To: <1519192048.55655.35.camel@gmail.com>
References: <20180221034159.14685-1-Jason@zx2c4.com> <1519192048.55655.35.camel@gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 21 Feb 2018 15:54:39 +0100
X-Gmail-Original-Message-ID: <CAHmME9px8Bwjz-D0dbSgm3vRPiEaBavEaG=2bGWC0_L3api5rw@mail.gmail.com>
Message-ID: <CAHmME9px8Bwjz-D0dbSgm3vRPiEaBavEaG=2bGWC0_L3api5rw@mail.gmail.com>
Subject: Re: [PATCH] netlink: put module reference if dump start fails
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 6:47 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>> This probably should be queued up for stable.
>
> When was the bug added ? This would help a lot stable teams ...

This needs to be backported to 4.16-rc0+, 4.15+, 4.14+, 4.13.14+, and 4.9.63+.
