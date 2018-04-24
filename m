Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeDXBEL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:04:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932697AbeDXBEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:04:08 -0400
Subject: Re: [RFC V3 PATCH 0/8] Packed ring for vhost
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwei.bie@intel.com, jfreimann@redhat.com, wexu@redhat.com
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
 <20180423193120.GD30033@char.us.oracle.com>
 <20180423224715-mutt-send-email-mst@kernel.org>
 <20180423201151.GD5215@char.us.oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <803cf7fa-6c74-0506-d609-8f0b79b2c254@redhat.com>
Date: Tue, 24 Apr 2018 09:04:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423201151.GD5215@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月24日 04:11, Konrad Rzeszutek Wilk wrote:
> On Mon, Apr 23, 2018 at 10:59:43PM +0300, Michael S. Tsirkin wrote:
>> On Mon, Apr 23, 2018 at 03:31:20PM -0400, Konrad Rzeszutek Wilk wrote:
>>> On Mon, Apr 23, 2018 at 01:34:52PM +0800, Jason Wang wrote:
>>>> Hi all:
>>>>
>>>> This RFC implement packed ring layout. The code were tested with
>>>> Tiwei's RFC V2 a thttps://lkml.org/lkml/2018/4/1/48. Some fixups and
>>>> tweaks were needed on top of Tiwei's code to make it run. TCP stream
>>>> and pktgen does not show obvious difference compared with split ring.
>>> I have to ask then - what is the benefit of this?
>> You can use this with dpdk within guest.
>> The DPDK version did see a performance improvement so hopefully with
> Is there a link to this performance improvement document?
>

You probably want to this:

https://www.mail-archive.com/dev@dpdk.org/msg97735.html

Thanks
