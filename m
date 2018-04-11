Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeDKBVd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:21:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeDKBVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:21:31 -0400
Date: Wed, 11 Apr 2018 09:21:26 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        syzkaller-bugs@googlegroups.com, mst@redhat.com,
        torvalds@linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vhost: fix vhost_vq_access_ok() log check
Message-ID: <20180411012126.GA28698@stefanha-x1.localdomain>
References: <20180410052630.11270-1-stefanha@redhat.com>
 <8642c057-e49d-d95d-19e5-6d304f20064e@redhat.com>
 <20180410.105043.1798364865868187298.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20180410.105043.1798364865868187298.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 10:50:43AM -0400, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Tue, 10 Apr 2018 14:40:10 +0800
>=20
> > On 2018=E5=B9=B404=E6=9C=8810=E6=97=A5 13:26, Stefan Hajnoczi wrote:
> >> v2:
> >>   * Rewrote the conditional to make the vq access check clearer [Linus]
> >>   * Added Patch 2 to make the return type consistent and harder to mis=
use
> >>   * [Linus]
> >>
> >> The first patch fixes the vhost virtqueue access check which was
> >> recently
> >> broken.  The second patch replaces the int return type with bool to
> >> prevent
> >> future bugs.
> >>
> >> Stefan Hajnoczi (2):
> >>    vhost: fix vhost_vq_access_ok() log check
> >>    vhost: return bool from *_access_ok() functions
> >>
> >>   drivers/vhost/vhost.h |  4 +--
> >>   drivers/vhost/vhost.c | 70
> >>   ++++++++++++++++++++++++++-------------------------
> >>   2 files changed, 38 insertions(+), 36 deletions(-)
> >>
> >=20
> > Acked-by: Jason Wang <jasowang@redhat.com>
>=20
> This sereis doesn't apply cleanly to the net tree, please respin
> and add the appropriate Acks and Fixes: tags that Michael and Jason
> have provided.

Sorry, will fix.

Stefan

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazWMVAAoJEJykq7OBq3PIN1IH/ikRjLXh9rfQ7bPYf9bbkcyE
43iYyGKK5W5N5GA5urguo6yZHly24hLAhvm+MdbLFiXmjrEsNODc7Lk2+p9d1HJa
m0Dc+pyjig489X/jFWtEUwFS2woZlAbxCS/iyEjMDkotc43GCRvm1C6OT0nBHdky
XSdsu2rJyc/PNJtLNkDAFaRm2gvbvCfLG82SlZY39S679M1Xfm+23IvZD+6E6Mhr
c2QrUEYjF3drmY0HjfTEqiRBH4f+/wJe67W4oiBfjM1kNJd3rOO5qkMnmF28dQjC
S/7S/hC5FJplkvxXKKis749OHLbgPFPtgwFkW5FQfgd9miWOVp7wF9lrnq88SjY=
=eq0T
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
