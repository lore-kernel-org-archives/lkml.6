Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeDKOzd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:55:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41614 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeDKOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:55:31 -0400
Date: Wed, 11 Apr 2018 10:55:28 -0400 (EDT)
Message-Id: <20180411.105528.2200336972660597076.davem@davemloft.net>
To: mst@redhat.com
Cc: stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        torvalds@linux-foundation.org, jasowang@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] vhost: fix vhost_vq_access_ok() log check
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180411162345-mutt-send-email-mst@kernel.org>
References: <20180411023541.15776-1-stefanha@redhat.com>
        <20180411162345-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 11 Apr 2018 16:24:02 +0300

> On Wed, Apr 11, 2018 at 10:35:39AM +0800, Stefan Hajnoczi wrote:
>> v3:
>>  * Rebased onto net/master and resolved conflict [DaveM]
>> 
>> v2:
>>  * Rewrote the conditional to make the vq access check clearer [Linus]
>>  * Added Patch 2 to make the return type consistent and harder to misuse [Linus]
>> 
>> The first patch fixes the vhost virtqueue access check which was recently
>> broken.  The second patch replaces the int return type with bool to prevent
>> future bugs.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> We need the 1st one on stable I think.

Series applied and patch #1 queued up for -stable.
