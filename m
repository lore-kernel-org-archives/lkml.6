Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeBBTfL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:35:11 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36181 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeBBTe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:34:59 -0500
X-Google-Smtp-Source: AH8x2278s0YCMLmqyrTr5D0r3VmuyQSTzF7fHO36CIhZtmQ1BOK/5kSseKl+ky8FIAw7u+l1tMvEOQ==
Message-ID: <1517600096.3715.138.camel@gmail.com>
Subject: Re: [PATCH net] Revert "defer call to mem_cgroup_sk_alloc()"
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Roman Gushchin <guro@fb.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Date: Fri, 02 Feb 2018 11:34:56 -0800
In-Reply-To: <20180202190426.GA15313@castle.DHCP.thefacebook.com>
References: <20180202165754.8551-1-guro@fb.com>
         <1517594367.3715.130.camel@gmail.com>
         <20180202180624.GA11596@castle.DHCP.thefacebook.com>
         <1517596744.3715.137.camel@gmail.com>
         <20180202190426.GA15313@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 19:04 +0000, Roman Gushchin wrote:
> On Fri, Feb 02, 2018 at 10:39:04AM -0800, Eric Dumazet wrote:
> > On Fri, 2018-02-02 at 18:06 +0000, Roman Gushchin wrote:
> > > 
> > > Idk, how even we can hit it? And if so, what scary will happen?
> > > 
> > > If you prefer to have it there, I definitely can return it,
> > > but I see no profit so far.
> > 
> > I was simply curious this was not mentioned in the changelog.
> > 
> > A revert is normally a true revert, modulo the changes needed by
> > conflicts and possible changes.
> > 
> > I personally do not care of this BUG_ON(), I had not put it in the
> > first place.
> 
> Technically it's not a true revert, but you're totally right.
> Let me add a note to the commit description.
> 
> Are you ok with the rest?

Sure !

Thanks.
