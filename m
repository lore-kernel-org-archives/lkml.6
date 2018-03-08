Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750912AbeCHWLO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:11:14 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45893 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHWLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:11:13 -0500
X-Google-Smtp-Source: AG47ELuD5tCtaN6UMF28fc8XUYYeiGJVTTVETz1m6OuZtj/8zmStE/257hbEvlg6IYR3qlrOS86GJA==
Date: Thu, 08 Mar 2018 14:11:12 -0800 (PST)
X-Google-Original-Date: Thu, 08 Mar 2018 14:08:33 PST (-0800)
Subject: Re: [RFC PATCH 1/2] riscv/spinlock: Strengthen implementations with fences
In-Reply-To: <20180308210303.GA2897@andrea>
CC: albert@sifive.com, Daniel Lustig <dlustig@nvidia.com>,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: parri.andrea@gmail.com
Message-ID: <mhng-994ef724-c752-4667-a119-8db6407464df@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018 13:03:03 PST (-0800), parri.andrea@gmail.com wrote:
> On Wed, Mar 07, 2018 at 10:33:49AM -0800, Palmer Dabbelt wrote:
>
> [...]
>
>> I'm going to go produce a new set of spinlocks, I think it'll be a bit more
>> coherent then.
>>
>> I'm keeping your other patch in my queue for now, it generally looks good
>> but I haven't looked closely yet.
>
> Patches 1 and 2 address a same issue ("release-to-acquire"); this is also
> expressed, more or less explicitly, in the corresponding commit messages:
> it might make sense to "queue" them together, and to build the new locks
> on top of these (even if this meant "rewrite all of/a large portion of
> spinlock.h"...).

I agree.  IIRC you had a fixup to the first pair of patches, can you submit a 
v2?
