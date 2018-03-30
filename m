Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeC3PfN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:35:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47461 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752216AbeC3PfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:35:10 -0400
Date: Fri, 30 Mar 2018 17:11:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180330151129.GG28244@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330103907.GC3313@nanopsycho>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please see:
> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
> 
> I bevieve that the solution in the patchset could be used for
> your usecase too.

Hi Jiri

https://lkml.org/lkml/2018/3/20/436

How well does this API work for a 2Gbyte snapshot?

    Andrew
