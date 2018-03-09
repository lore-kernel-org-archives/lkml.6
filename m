Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbeCISHX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:07:23 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44224 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeCISHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:07:21 -0500
X-Google-Smtp-Source: AG47ELvQBzpXuXWgF0UdpmuyxxduPi/NzqIhpyjliOsEbMGfsrOLt3VkOywB+fW3alyBS5okIIK+xA==
Date: Fri, 09 Mar 2018 10:07:19 -0800 (PST)
X-Google-Original-Date: Fri, 09 Mar 2018 09:56:36 PST (-0800)
Subject: Re: [RFC PATCH 1/2] riscv/spinlock: Strengthen implementations with fences
In-Reply-To: <20180309121643.GA16716@andrea>
CC: albert@sifive.com, Daniel Lustig <dlustig@nvidia.com>,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: parri.andrea@gmail.com
Message-ID: <mhng-e33a5770-5cf5-407d-b2f6-45af7c0b9ef8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Mar 2018 04:16:43 PST (-0800), parri.andrea@gmail.com wrote:
> On Thu, Mar 08, 2018 at 02:11:12PM -0800, Palmer Dabbelt wrote:
>> On Thu, 08 Mar 2018 13:03:03 PST (-0800), parri.andrea@gmail.com wrote:
>> >On Wed, Mar 07, 2018 at 10:33:49AM -0800, Palmer Dabbelt wrote:
>> >
>> >[...]
>> >
>> >>I'm going to go produce a new set of spinlocks, I think it'll be a bit more
>> >>coherent then.
>> >>
>> >>I'm keeping your other patch in my queue for now, it generally looks good
>> >>but I haven't looked closely yet.
>> >
>> >Patches 1 and 2 address a same issue ("release-to-acquire"); this is also
>> >expressed, more or less explicitly, in the corresponding commit messages:
>> >it might make sense to "queue" them together, and to build the new locks
>> >on top of these (even if this meant "rewrite all of/a large portion of
>> >spinlock.h"...).
>>
>> I agree.  IIRC you had a fixup to the first pair of patches, can you submit
>> a v2?
>
> I've just sent it (with updated changelog).

Thanks!
