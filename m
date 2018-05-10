Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966098AbeEJPDD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:03:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965404AbeEJPDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:03:02 -0400
Date: Thu, 10 May 2018 16:02:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio: support VIRTIO_F_IO_BARRIER
Message-ID: <20180510150258.GB9308@stefanha-x1.localdomain>
References: <20180504045915.17693-1-tiwei.bie@intel.com>
 <20180510095317.GO1296@stefanha-x1.localdomain>
 <20180510103941.znxka65iluybktuq@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20180510103941.znxka65iluybktuq@debian>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 06:39:41PM +0800, Tiwei Bie wrote:
> On Thu, May 10, 2018 at 10:53:17AM +0100, Stefan Hajnoczi wrote:
> > On Fri, May 04, 2018 at 12:59:15PM +0800, Tiwei Bie wrote:
> > > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/=
virtio_config.h
> > > index 308e2096291f..9fb519a9df28 100644
> > > --- a/include/uapi/linux/virtio_config.h
> > > +++ b/include/uapi/linux/virtio_config.h
> > > @@ -49,7 +49,7 @@
> > >   * transport being used (eg. virtio_ring), the rest are per-device f=
eature
> > >   * bits. */
> > >  #define VIRTIO_TRANSPORT_F_START	28
> > > -#define VIRTIO_TRANSPORT_F_END		34
> > > +#define VIRTIO_TRANSPORT_F_END		37
> >=20
> > Have you updated "2.2 Feature Bits" in the VIRTIO spec?
> >=20
> > In 1.0 it says:
> >=20
> >  24 to 32
> >     Feature bits reserved for extensions to the queue and feature negot=
iation mechanisms
> >=20
> > This information is out-of-date.
> >=20
>=20
> No. In the latest spec draft, it's 24 to 33. And it
> becomes out-of-date since VIRTIO_F_RING_PACKED(34)
> and VIRTIO_F_IN_ORDER(35) were introduced. Do you
> want me to update it in the IO_BARRIER patch or do
> you want me to update it in a new patch?

Please update it to 37 in the IO_BARRIER patch.

Stefan

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9F8iAAoJEJykq7OBq3PI/VoH/iZO5Bg02FHvoa5thCUZSaaF
j/F6Ox+jdwjqTsKi+a10BTIhjTtrhqaqp4YbuO2kGdJQU8KCrjt5Dy6TKa8NO50q
DLsZBTnv6Ee/dsWh2W63vHSfXZnF0lKogQt5Hmjion6ZEutXdmvC/iYu7wB3Ixuz
FJ/JZqRav6Fw1SV7/MNN83VznnphCT7CCzZNzKQe1OXA9FpugsdgmDatNVU1FP95
DNFkZpnD5MGJxQZZ5qX/CXb/xvM/0kw7Cf9B1ZWBQa8zNYv1qAaXCSWV1z9QBWhl
RG6AN3tYr/k8JCSDlo0dwXEXfNwdCnPSISD7Se+5fUpce7MP+/CC6SuYcy6LxyQ=
=owNf
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
