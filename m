Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeECHTZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:19:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751019AbeECHTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:19:24 -0400
Subject: Re: [RFC V3 PATCH 1/8] vhost: move get_rx_bufs to vhost.c
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfreimann@redhat.com, wexu@redhat.com
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
 <1524461700-5469-2-git-send-email-jasowang@redhat.com>
 <20180502080518.h52wme46fnqpyfpf@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <19846c31-45b2-6809-6e7b-6b738cd7d2ca@redhat.com>
Date: Thu, 3 May 2018 15:19:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502080518.h52wme46fnqpyfpf@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月02日 16:05, Tiwei Bie wrote:
> On Mon, Apr 23, 2018 at 01:34:53PM +0800, Jason Wang wrote:
>> Move get_rx_bufs() to vhost.c and rename it to
>> vhost_get_rx_bufs(). This helps to hide vring internal layout from
> A small typo. Based on the code change in this patch, it
> seems that this function is renamed to vhost_get_bufs().
>
> Thanks
>

Right, let me fix it in the next version.

Thanks
