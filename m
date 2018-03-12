Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeCLJqO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:46:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52013 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeCLJqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:46:10 -0400
X-Google-Smtp-Source: AG47ELvudfWsdDAmtNcXdVWrYBUnsyog/4K5AMuYqmE1kUEtgsFvS24k4j953qeB6XRgtNS8NBnRXAEIv1kTi+Ny1nU=
MIME-Version: 1.0
In-Reply-To: <CANEr7oV8GTU8X1ijUYJKZjF6Pdr1i7+mvUqoDCaaKBCPkvrFgg@mail.gmail.com>
References: <20180312124007.61288892@canb.auug.org.au> <CANEr7oV8GTU8X1ijUYJKZjF6Pdr1i7+mvUqoDCaaKBCPkvrFgg@mail.gmail.com>
From: "Pierre Bourdon (delroth)" <delroth@google.com>
Date: Mon, 12 Mar 2018 10:46:08 +0100
Message-ID: <CANEr7oWy2ATCnExdoFkCt9Sz3OUEgEQpQQiqmKnOh7iVDekiKg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the battery tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andre Heider <a.heider@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:35 AM, Pierre Bourdon (delroth)
<delroth@google.com> wrote:
> On Mon, 12 Mar 2018 at 02:40, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi Sebastian,
>>
>> Commit
>>
>>   5e0dfcbb1194 ("max17042: propagate of_node to power supply device")
>>
>> is missing a Signed-off-by from its author.
>
> I failed hard :) will resend.

So, since I'm very clearly not familiar with the process... is sending
a v2 with proper s-o-b the Right Way to do it, or are you just fine
with a correction by email?

If the latter:

Signed-off-by: Pierre Bourdon <delroth@google.com>

Sorry for the screwup, slowly learning (I hope).
Best,

-- 
Pierre Bourdon (delroth@)
