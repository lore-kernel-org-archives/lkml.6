Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754316AbeDID2o (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 23:28:44 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:42091 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752235AbeDID2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 23:28:40 -0400
X-Google-Smtp-Source: AIpwx4+7yMq4xz6rlzOea/kD2JPU3+PLE6FieZ1fiMXWXPqkekd/odXrssrpSC0b3MM/oL4jygOGoA==
Date: Mon, 9 Apr 2018 11:28:35 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Linux Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: kernel BUG at drivers/vhost/vhost.c:LINE! (2)
Message-ID: <20180409032835.GB1648@stefanha-x1.localdomain>
References: <001a11449424f11322056932b09c@google.com>
 <CAJSP0QVHk7NSQcjfLWq13=1Vzm=_vtmKZqp4dDjuh8ETLO5g_g@mail.gmail.com>
 <20180409054316-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20180409054316-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 05:44:36AM +0300, Michael S. Tsirkin wrote:
> On Mon, Apr 09, 2018 at 10:37:45AM +0800, Stefan Hajnoczi wrote:
> > On Sat, Apr 7, 2018 at 3:02 AM, syzbot
> > <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com> wrote:
> > > syzbot hit the following crash on upstream commit
> > > 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +00=
00)
> > > Merge tag 'armsoc-drivers' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> > > syzbot dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=3D65a84dde0214b0387ccd
> >=20
> > To prevent duplicated work: I am working on this one.
> >=20
> > Stefan
>=20
> Do you want to try this patchset:
> https://lkml.org/lkml/2018/4/5/665
>=20
> ?

Thanks, I'll give it a shot.

I also noticed a regression in commit
d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log when
IOTLB is enabled") and am currently testing a fix.

Stefan

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJayt3jAAoJEJykq7OBq3PIvCQH/2E79UtiLD6eBIXZkG58tEo5
Ez30uLYssZ++XNLiJVf/zFggkbtAbO7MxF7NC7irzgyaywS9mClGLlmfV9RTN5En
AwEnk1TVhOfZdrsO97o/k37V8WCF16mGNmQVA2XCoex6P8vnnUIMEBvdZGSToEQx
WgtPjrHCAMfpEjotN/3mstAdv6O3+Cm/utLUNC4ZsJexuk7JvskDO9AljnCViVcz
ZUAZsVHHY2nQZfjzyx1GudJrkceB/3/newMoDQDVLqvLKoFZEV65nxXWhmDO4zO9
ocWB9oLqCU+CpD3LG1Eh+BMT+KuqvWXMzzO48IFZtUn22BHAQGNrWBDdrVo22Fs=
=K4YJ
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
