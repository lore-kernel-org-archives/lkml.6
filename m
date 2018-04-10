Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDJGkT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:40:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752002AbeDJGkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:40:18 -0400
Subject: Re: [PATCH v2 0/2] vhost: fix vhost_vq_access_ok() log check
To: Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc: syzkaller-bugs@googlegroups.com, mst@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20180410052630.11270-1-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8642c057-e49d-d95d-19e5-6d304f20064e@redhat.com>
Date: Tue, 10 Apr 2018 14:40:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410052630.11270-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月10日 13:26, Stefan Hajnoczi wrote:
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

Thanks!
