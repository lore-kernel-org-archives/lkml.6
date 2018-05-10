Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934983AbeEJJzS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:55:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935004AbeEJJxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:53:19 -0400
Date: Thu, 10 May 2018 10:53:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [virtio-dev] [PATCH v1] virtio: support VIRTIO_F_IO_BARRIER
Message-ID: <20180510095317.GO1296@stefanha-x1.localdomain>
References: <20180504045915.17693-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qse+WBH4guesipZ+"
Content-Disposition: inline
In-Reply-To: <20180504045915.17693-1-tiwei.bie@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qse+WBH4guesipZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2018 at 12:59:15PM +0800, Tiwei Bie wrote:
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 308e2096291f..9fb519a9df28 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -49,7 +49,7 @@
>   * transport being used (eg. virtio_ring), the rest are per-device feature
>   * bits. */
>  #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		34
> +#define VIRTIO_TRANSPORT_F_END		37

Have you updated "2.2 Feature Bits" in the VIRTIO spec?

In 1.0 it says:

 24 to 32
    Feature bits reserved for extensions to the queue and feature negotiation mechanisms

This information is out-of-date.

Stefan

--qse+WBH4guesipZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9BaNAAoJEJykq7OBq3PI/mgH/3H6Ipe1WS/YN7no0pENW3a5
p7hjNcaapuwQmOWWrBzOKVIbxvdEwgCtgc7TEfB9HQPnKh/gkpWomt12eZqL/vIJ
hYMnk/rEK4suNIiQtYzTzVO1RDyzu6OsYPFPaoPK/VZyVOuPrqo2HqoARCdXYK5K
Dx0sQ1UbY3cFcMhhupZfxqsKf3rVYhsFF2g2u/LU9s9smF7xcJABDXb2J5YwI7VV
TCIR0Ck5S09HKYNCA5jBKv/VyzgE+QQuTb2ZMKRuDY50D/mYgzfwCDPpdx1boKKL
wtFARUq/2AObvDwMK23cmINNRXqhC2eSwLuPpbG84ldKyY/ClMFCCN41g3J1kQI=
=dYI2
-----END PGP SIGNATURE-----

--qse+WBH4guesipZ+--
