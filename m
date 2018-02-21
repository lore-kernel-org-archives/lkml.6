Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965985AbeBUPME (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:12:04 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:39392 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbeBUPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:12:00 -0500
X-Google-Smtp-Source: AH8x227lbMPtCkaLVwnfkSgdG2zphrDy8nqGGBX6ynZ0oPBEvpvO7kVIGNKFGTa5mo2YCAYpJ3K65Q==
Message-ID: <1519225917.55655.42.camel@gmail.com>
Subject: Re: [PATCH] netlink: put module reference if dump start fails
From: Eric Dumazet <eric.dumazet@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: David Miller <davem@davemloft.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date: Wed, 21 Feb 2018 07:11:57 -0800
In-Reply-To: <CAHmME9px8Bwjz-D0dbSgm3vRPiEaBavEaG=2bGWC0_L3api5rw@mail.gmail.com>
References: <20180221034159.14685-1-Jason@zx2c4.com>
         <1519192048.55655.35.camel@gmail.com>
         <CAHmME9px8Bwjz-D0dbSgm3vRPiEaBavEaG=2bGWC0_L3api5rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-21 at 15:54 +0100, Jason A. Donenfeld wrote:
> On Wed, Feb 21, 2018 at 6:47 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > > This probably should be queued up for stable.
> > 
> > When was the bug added ? This would help a lot stable teams ...
> 
> This needs to be backported to 4.16-rc0+, 4.15+, 4.14+, 4.13.14+, and 4.9.63+.

I guess I should have asked you to provide an appropriate Fixes: tag,
clearly identifying the commit that added the bug.

Fixes: 12-digit-sha1 ("patch title")

Thanks.
