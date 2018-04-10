Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754263AbeDJOus (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:50:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53246 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753562AbeDJOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:50:45 -0400
Date: Tue, 10 Apr 2018 10:50:43 -0400 (EDT)
Message-Id: <20180410.105043.1798364865868187298.davem@davemloft.net>
To: jasowang@redhat.com
Cc: stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        syzkaller-bugs@googlegroups.com, mst@redhat.com,
        torvalds@linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vhost: fix vhost_vq_access_ok() log check
From: David Miller <davem@davemloft.net>
In-Reply-To: <8642c057-e49d-d95d-19e5-6d304f20064e@redhat.com>
References: <20180410052630.11270-1-stefanha@redhat.com>
        <8642c057-e49d-d95d-19e5-6d304f20064e@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Apr 2018 14:40:10 +0800

> On 2018年04月10日 13:26, Stefan Hajnoczi wrote:
>> v2:
>>   * Rewrote the conditional to make the vq access check clearer [Linus]
>>   * Added Patch 2 to make the return type consistent and harder to misuse
>>   * [Linus]
>>
>> The first patch fixes the vhost virtqueue access check which was
>> recently
>> broken.  The second patch replaces the int return type with bool to
>> prevent
>> future bugs.
>>
>> Stefan Hajnoczi (2):
>>    vhost: fix vhost_vq_access_ok() log check
>>    vhost: return bool from *_access_ok() functions
>>
>>   drivers/vhost/vhost.h |  4 +--
>>   drivers/vhost/vhost.c | 70
>>   ++++++++++++++++++++++++++-------------------------
>>   2 files changed, 38 insertions(+), 36 deletions(-)
>>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

This sereis doesn't apply cleanly to the net tree, please respin
and add the appropriate Acks and Fixes: tags that Michael and Jason
have provided.

Thank you.
