Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeFAKqD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:46:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751432AbeFAKqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:46:02 -0400
Date: Fri, 1 Jun 2018 12:45:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] [PATCH] virtio: update the comments for transport
 features
Message-ID: <20180601124552.6a188454.cohuck@redhat.com>
In-Reply-To: <20180601102217.21628-1-tiwei.bie@intel.com>
References: <20180601102217.21628-1-tiwei.bie@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 18:22:17 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> This patch is generated on top of below patch:
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html
> 
>  include/uapi/linux/virtio_config.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b7c1f4e7d59e..479affd903e9 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -45,9 +45,12 @@
>  /* We've given up on this device. */
>  #define VIRTIO_CONFIG_S_FAILED		0x80
>  
> -/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
> - * transport being used (eg. virtio_ring), the rest are per-device feature
> - * bits. */
> +/*
> + * Some virtio feature bits (currently bits VIRTIO_TRANSPORT_F_START
> + * through VIRTIO_TRANSPORT_F_END) are reserved for the transport being

It will always be bits up to VIRTIO_TRANSPORT_F_END, no? So you can drop
the "currently"?

Or reword as "Virtio feature bits VIRTIO_TRANSPORT_F_START through
VIRTIO_TRANSPORT_F_END are reserved..."?

> + * used (e.g. virtio_ring, virtio_pci etc.), the rest are per-device
> + * feature bits.
> + */
>  #define VIRTIO_TRANSPORT_F_START	28
>  #define VIRTIO_TRANSPORT_F_END		38
>  
