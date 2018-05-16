Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbeEPKVY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:21:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34318 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeEPKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:51 -0400
X-Google-Smtp-Source: AB8JxZqAss0yTBJOuDHREYmbke2UNSkWfO89aF60WIR93EnhUq920bUhKo2E2FoKLMVrcZWgoK2Qew==
Subject: Re: [RFC v4 5/5] virtio_ring: enable packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-6-tiwei.bie@intel.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
Date: Wed, 16 May 2018 13:15:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516083737.26504-6-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2018 11:37 AM, Tiwei Bie wrote:

> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   drivers/virtio/virtio_ring.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index de3839f3621a..b158692263b0 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1940,6 +1940,8 @@ void vring_transport_features(struct virtio_device *vdev)
>   			break;
>   		case VIRTIO_F_IOMMU_PLATFORM:
>   			break;
> +		case VIRTIO_F_RING_PACKED:
> +			break;

    Why not just add this *case* under the previous *case*?

>    		default:
>   			/* We don't understand this bit. */
>   			__virtio_clear_bit(vdev, i);

MBR, Sergei
