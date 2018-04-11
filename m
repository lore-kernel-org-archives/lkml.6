Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeDKDd3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:33:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeDKDd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:33:27 -0400
Subject: Re: [PATCH v3 0/2] vhost: fix vhost_vq_access_ok() log check
To: Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180411023541.15776-1-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <252aa961-3bc0-ab5b-28c6-7de5d579bbd2@redhat.com>
Date: Wed, 11 Apr 2018 11:33:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180411023541.15776-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月11日 10:35, Stefan Hajnoczi wrote:
> v3:
>   * Rebased onto net/master and resolved conflict [DaveM]
>
> v2:
>   * Rewrote the conditional to make the vq access check clearer [Linus]
>   * Added Patch 2 to make the return type consistent and harder to misuse [Linus]
>
> The first patch fixes the vhost virtqueue access check which was recently
> broken.  The second patch replaces the int return type with bool to prevent
> future bugs.
>
> Stefan Hajnoczi (2):
>    vhost: fix vhost_vq_access_ok() log check
>    vhost: return bool from *_access_ok() functions
>
>   drivers/vhost/vhost.h |  4 +--
>   drivers/vhost/vhost.c | 70 ++++++++++++++++++++++++++-------------------------
>   2 files changed, 38 insertions(+), 36 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks
