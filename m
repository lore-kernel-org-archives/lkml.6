Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeFALQ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:16:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751823AbeFALQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:16:53 -0400
Date: Fri, 1 Jun 2018 13:16:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v2] virtio: update the comments for transport features
Message-ID: <20180601131647.5d02da18.cohuck@redhat.com>
In-Reply-To: <20180601105950.10632-1-tiwei.bie@intel.com>
References: <20180601105950.10632-1-tiwei.bie@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 18:59:50 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> The existing comments for transport features are out dated.

s/out dated/outdated/

> So update them to address the latest changes in the spec.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> This patch is generated on top of below patch:
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html
> 
> v2:
> - Improve the comments (Cornelia);
> - Improve the commit message;
> 
>  include/uapi/linux/virtio_config.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b7c1f4e7d59e..449132c76b1c 100644
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
> + * Virtio feature bits VIRTIO_TRANSPORT_F_START through
> + * VIRTIO_TRANSPORT_F_END are reserved for the transport
> + * being used (e.g. virtio_ring, virtio_pci etc.), the
> + * rest are per-device feature bits.
> + */
>  #define VIRTIO_TRANSPORT_F_START	28
>  #define VIRTIO_TRANSPORT_F_END		38
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
