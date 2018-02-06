Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeBFVH3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:07:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:38200 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753100AbeBFVH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:07:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,470,1511856000";
   d="asc'?scan'208";a="16004418"
Message-ID: <1517951251.9683.5.camel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH] Documentation: networking: Update
 ixgb kconfig select documentation
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: Alexander Duyck <alexander.duyck@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Date: Tue, 06 Feb 2018 13:07:31 -0800
In-Reply-To: <CAKgT0Uc-br8akeUyjf0FenLPLxDdq14D1rppjvb1yfNU33t+Mw@mail.gmail.com>
References: <1517949734-27314-1-git-send-email-clabbe@baylibre.com>
         <CAKgT0Uc-br8akeUyjf0FenLPLxDdq14D1rppjvb1yfNU33t+Mw@mail.gmail.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tf1RdcbTox1Fhv56qLPV"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tf1RdcbTox1Fhv56qLPV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-06 at 13:01 -0800, Alexander Duyck wrote:
> On Tue, Feb 6, 2018 at 12:42 PM, Corentin Labbe <clabbe@baylibre.com>
> wrote:
> > Update documentation on how to enable ixgb and ixgb DCB.
> > Simply remove NETDEV_10000 and replace it with the new used kconfig
> > names.
>=20
> Minor typo in the patch description. I assume you mean "ixgb and
> ixgbe
> DCB". Also you might want to mention ixgbe somewhere in the patch
> title.
>=20
> >=20
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   Documentation/networking/ixgb.txt  | 3 ++-
> >   Documentation/networking/ixgbe.txt | 7 ++++---
> >   2 files changed, 6 insertions(+), 4 deletions(-)

I alredy have a patch to update the ixgbe kernel documentation, please
see the following patch:
http://patchwork.ozlabs.org/patch/870106/

With my updated documentation patch, the ixgbe hunk of your patch no
longer applies.
--=-tf1RdcbTox1Fhv56qLPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlp6GRMACgkQ5W/vlVpL
7c4k/xAAjVt0Xplc6CGADcwthmLWFgr2gmkLJDwHoewnRuT4sKkNcwJbCfu36Js8
hhv6BVTIe3f8lnzppXS3Q342PlTHzIEJzCbezRTKl/3BhQoY1uhYlHGthSsxhEh4
5QKtRgviQHVc6CvaVd/zMzYli/SdFpVSR5SyucvCX9iWEW3sqdrMD3g8zLcuYwEw
2dBzZA4O0fh1p7G0ANnGWvpvc8qv351uqI+dzDfXNN6o5cZYpYckke0jD5eKeVi8
cqOj9dqe/onIAWZL/LQ/oiSpRgk+xg68fmbOQhGOYzCCFZ6xx/WIuzpeUHXkXY+c
bvVVFacij0TxmUXLcuIRTnNyXLdLCjo/eqSJVe9qHIuXdFshddqTDh2xPhgtz2sQ
0VRNjG01JidsKkA9SFfxjC0l3HAevwId4qikVMxZqjhDdeI0wxxGYg3+qxDT3MpA
86FsT4pXTu8icVjn6OlP8+t9/H7Sg+tmNpYNHB2hBt5QX4GQP15iGKyWPbBQKj9e
o0xYEOMYcqARijDkOqifZk8syPB+/Oq44zbFHn8wPenTktTdfxiUhjRymHL6IKr2
7gCRc2aUE7dexV/T68qeMUQySe/v+WXjLbK0OjrUjwOWGc5gMf7eIqjq4asgpj3j
UIXRInHlNm5EpNMMfuN7GDlAylUyEcYzYPuVKpGLG8euUbRusSM=
=6b/I
-----END PGP SIGNATURE-----

--=-tf1RdcbTox1Fhv56qLPV--
