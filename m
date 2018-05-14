Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeENRuD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:50:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbeENRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:50:02 -0400
Date: Mon, 14 May 2018 13:49:57 -0400 (EDT)
Message-Id: <20180514.134957.2004410983527740923.davem@davemloft.net>
To: ebiederm@xmission.com
Cc: rahul.lakkireddy@chelsio.com, netdev@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v8 0/3] kernel: add support to collect
 hardware logs in crash recovery kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <87a7t2mlfn.fsf@xmission.com>
References: <cover.1525253481.git.rahul.lakkireddy@chelsio.com>
        <20180513.201131.1649805811466916646.davem@davemloft.net>
        <87a7t2mlfn.fsf@xmission.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 14 May 2018 08:11:24 -0500

> David Miller <davem@davemloft.net> writes:
> 
>> I'm deferring this patch series.
>>
>> If we can't get a reasonable review from an interested party in 10+
>> days, that is not reasonable.
>>
>> Resubmit this once someone reviews it properly.
> 
> David I am out on vacation this week and last (the reason for the delay).
> 
> The last version of this that I looked at I gave my ack.  All of my ABI
> concerns had been addressed. The only outstanding change I believe was
> the Eric Dumazet's asking about something being reviewed.
> 
> I just glanced over it again and I don't see any new issues introduced
> by the last round of changes.
> 
> From 10,000 feet flyover design perspectie and from an ABI perspective
> this patchset seems fine.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Ok, thanks for reviewing Eric.

Series applied.
