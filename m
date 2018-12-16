Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EB0206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbeLPVml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:42:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39272 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbeLPVml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:42:41 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gYeBJ-0000ZG-59; Sun, 16 Dec 2018 21:42:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gYeBJ-0007ef-02; Sun, 16 Dec 2018 21:42:37 +0000
Message-ID: <1a378bff338f296670091cfad7e22b05d9cf514c.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 047/328] xen-netfront: fix queue name setting
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Date:   Sun, 16 Dec 2018 21:42:32 +0000
In-Reply-To: <87y38ycmgq.fsf@vitty.brq.redhat.com>
References: <lsq.1544392233.936009164@decadent.org.uk>
         <87y38ycmgq.fsf@vitty.brq.redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-NKf/S06HmMuX4mTcQLou"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NKf/S06HmMuX4mTcQLou
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-12-10 at 00:24 +0100, Vitaly Kuznetsov wrote:
> Ben Hutchings <ben@decadent.org.uk> writes:
>=20
> > 3.16.62-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >=20
> > commit 2d408c0d4574b01b9ed45e02516888bf925e11a9 upstream.
[...]
> We should also take=20
>=20
> commit 21f2706b20100bb3db378461ab9b8e2035309b5b
> Author: Xiao Liang <xiliang@redhat.com>
> Date:   Tue Aug 14 23:21:28 2018 +0800
>=20
>     xen-netfront: fix warn message as irq device name has '/'
>=20
> as it fixes an issue introduced by the commit in question. Sorry if this
> is already in your series but I wasn't CCed on it.

Thanks, I've added that.

Ben.

--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.



--=-NKf/S06HmMuX4mTcQLou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwWxsgACgkQ57/I7JWG
EQlH1A//btl/kXrTAKf5SPY6raBpp9W43yv6QdYhq8+iLPW533UK43ycoWLHqGyH
Av4NxHGtSvyNw/sV0uOn46KexQ1tetPRLWK4Oii3KNWID2GoFhZSEDiM7M2KNFrm
1zBN192C/sIzbGXeZc5M5pBdnc/MRSUeBQZ0w75vXBhdNqABAJ7niyXkbxfV4ESg
jZ3Xk22/iAV7jdtPfjX7eTFz2dcXZ7s90FcXZFl6lshGXVSO4n6XR46ADADbtHov
MTbqY6kHMCsS3orD8KVa71H9ZaHBG3jKrlGxmQjOcAgCXqCtrWGJMtKCzkkpgwhj
qFSHzr6yK2uP5SVGq8Ih4laqLkbIzhpVwKSrj8XYGXnETnrz6ErB5Zaq2HKbV3Dk
OA64c5IhO/LiJ0vtUsZ3fryHO8w8ig+nzHXbsNfvvZZqP2oOIOetIFD+6Q+KO4Fw
9HtX0jCVGXzTwJk2pKomv4CKe8LTDMbCqQNWzpd2OegIx7xwvy1mSHoJqENDHDWB
kRuAAzkYrB+lQd4a8rch+RU2RV5ehKYdVqO2fz9hZ2xYHASlaf5o+xlVadf6Jvej
1alJpTjgzclFtE5mYuX4Dregt7nB2LZv+8MLR3tBlKc3ZKx+fJLekUnIvwME1vSB
PI+BAvU1M8NG1FuVmjD6F0Ps0iUsNB2nW1THYMDFJgCztL0dzvA=
=28Vk
-----END PGP SIGNATURE-----

--=-NKf/S06HmMuX4mTcQLou--
