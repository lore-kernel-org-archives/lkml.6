Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbeDBJMi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:12:38 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:43001 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeDBJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:12:36 -0400
X-Google-Smtp-Source: AIpwx48OoYosJRyDLfHLBqyKjDzEoKFuYK7mV/n/V5lKClHwFdDl7ycuXV7FqfFxpgRwoFpAlOOWWA==
Date: Mon, 2 Apr 2018 11:12:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com, valex@mellanox.com
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180402091232.GE3313@nanopsycho>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
 <20180330151129.GG28244@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330151129.GG28244@lunn.ch>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Mar 30, 2018 at 05:11:29PM CEST, andrew@lunn.ch wrote:
>> Please see:
>> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
>> 
>> I bevieve that the solution in the patchset could be used for
>> your usecase too.
>
>Hi Jiri
>
>https://lkml.org/lkml/2018/3/20/436
>
>How well does this API work for a 2Gbyte snapshot?

Ccing Alex who did the tests.

>
>    Andrew
