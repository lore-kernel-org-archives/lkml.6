Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeEPLm6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:42:58 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32965 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeEPLm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:42:56 -0400
X-Google-Smtp-Source: AB8JxZq2BIwkAMzwanTYomOMqbnFLbVmQvlY7u3mcUHaozELhYc9H2TKhlx55tZ4kpUu7BFSVQHWEA==
Subject: Re: [RFC v4 5/5] virtio_ring: enable packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-6-tiwei.bie@intel.com>
 <27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
 <20180516102159.GA11467@debian>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <dc6f6d01-7ca5-5264-6a58-1d5327da08cb@cogentembedded.com>
Date: Wed, 16 May 2018 14:42:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180516102159.GA11467@debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 01:21 PM, Tiwei Bie wrote:

>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>> ---
>>>   drivers/virtio/virtio_ring.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index de3839f3621a..b158692263b0 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -1940,6 +1940,8 @@ void vring_transport_features(struct virtio_device *vdev)
>>>   			break;
>>>   		case VIRTIO_F_IOMMU_PLATFORM:
>>>   			break;
>>> +		case VIRTIO_F_RING_PACKED:
>>> +			break;
>>
>>    Why not just add this *case* under the previous *case*?
> 
> Do you mean fallthrough? Something like:
> 
> 		case VIRTIO_F_IOMMU_PLATFORM:
> 		case VIRTIO_F_RING_PACKED:
> 			break;

   Yes, exactly. :-)

> Best regards,
> Tiwei Bie

[...]

MBR, Sergei
