Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeBFBmh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:42:37 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46482 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeBFBma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:42:30 -0500
Date: Tue, 6 Feb 2018 02:42:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Witten <mfwitten@gmail.com>
Cc: David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, stephen@networkplumber.org,
        eric.dumazet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Please apply these tiny, 4-month-old patches.
Message-ID: <20180206014217.GA17702@lunn.ch>
References: <45aab5effc0c424a992646a97cf2ec14-mfwitten@gmail.com>
 <14527e6c082e4ea282a3f833118c68df-mfwitten@gmail.com>
 <5603fa86b280465ca559a6b316ac2637-mfwitten@gmail.com>
 <20180205.201211.2134769499352656499.davem@davemloft.net>
 <dda70cc5d68b42d092c0173a11b87425-mfwitten@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda70cc5d68b42d092c0173a11b87425-mfwitten@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Please learn how the community works, and how to interact with
> > developers and maintainers in that community appropriately.
> 
> I already tried that.
> 
> If you're unwilling to be an effective maintainer, then please hand
> off the responsibiilty to someone else.

Could i suggest you read:

https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

And in particular, the bit about netdev being closed.

I suggest you wait a week for netdev to open, and then submit the
patches again. Actual patches, which cleanly apply to net-next.

  Andrew
