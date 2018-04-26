Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756118AbeDZUhi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:37:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38402 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755465AbeDZUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:37:36 -0400
X-Google-Smtp-Source: AB8JxZpZB76iv0K+uD8ET6s/RElExM2qmY4OJ0dZ5VgLlz2BnhVpUXJaninepQUlkd07wpVegGOu6w==
Date: Thu, 26 Apr 2018 22:37:34 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, igor.russkikh@aquantia.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: aquantia: fix aq_ndev_start_xmit()'s return type
Message-ID: <20180426203732.5r2ko33zazbtalje@ltop.local>
References: <20180424131623.3505-1-luc.vanoostenryck@gmail.com>
 <20180424.104250.1411072442966778574.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424.104250.1411072442966778574.davem@davemloft.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:42:50AM -0400, David Miller wrote:
> 
> Luc please don't submit such a huge number of patches all at one time.
> 
> ...
> 
> Finally, make this a true patch series.  It is so much easier for
> maintainers to work with a set of changes all doing the same thing if
> you make them a proper patch series with an appropriate "[PATCH 0/N] ..."
> header posting.
> 
> Thank you.

I suppose these sort of patches are as much a PITA for the sender
than for the receivers.

I hesitated between a single patch, a series or separated patches.
In a sense, the single patch would have been the easier for both sides
but I guessed it would not have been very well welcomed. Since for a
series, you're supposed to CC the whole series to everyone involved,
it would have been, or at least at thought so, maximaly noisy for no
good reasons. Finally, as all of these patches are totally independent,
I thought it would be the best to send them as separated patches, 
each drivers maintainers being then free to accept, reject or ignore
the patch(es) concerning him/her. It seems it was a bad guess, and
yes, I see the point of having a series for this.

I'll remember all this for the next time (if next time there is,
of course, I was already quite hesitant to spend time to prepare
and send patches for these issues with enum/integer mix-up).

Sorry for the annoyance,
-- Luc
