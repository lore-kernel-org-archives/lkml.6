Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757791AbeD0J3B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:29:01 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34884 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeD0J27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:28:59 -0400
X-Google-Smtp-Source: AB8JxZpIAMtZB3Box65b+K4Fx15q27/FE/40VIEHHrOJV0P9Vmhb1ABu/2Tg2t1gjBnSRPrRNnQZdw==
Date: Fri, 27 Apr 2018 11:28:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ata: ahci-platform: add reset control support"
Message-ID: <20180427092856.GA30388@ulmo>
References: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
 <c8ec7474-7eb4-24cf-1f53-b4bcee5508dd@redhat.com>
 <20180418083647.GA5503@ulmo>
 <20180426192040.GT1911913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20180426192040.GT1911913@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 12:20:40PM -0700, Tejun Heo wrote:
> Hello,
>=20
> On Wed, Apr 18, 2018 at 10:36:47AM +0200, Thierry Reding wrote:
> > I see that you've applied this to your for-next branch. However, this is
> > a fix that needs to go into v4.17 because that's where the regression
> > was introduced. Is there any way you can promote this to a fixes branch?
>=20
> It's in for-4.17-fixes.  I'll push it out early next week.

Great, thanks!

Thierry

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7VQACgkQ3SOs138+
s6FdOw/9H8ua3amf4gF4ALR4Ye9RLllwoIHD/LF43KfvhDk2K6G+MimAmsTY3DT2
1aaDw3h2AMpLd/0WcBlGQaMHv/myHGaoiTDC+hF0ll4uRrQORYi8EwUygVOVBk9+
ETmPKaQYmmf6/qd1zOFx7tdCxKQA4R+ot66rbG7iznR+Simeq04gQVSVH5AERz7J
JIakdSVdumWqwuoDZHIOXwbPuo79CmMzEtpUs8FrQA3GHv6uVombsVrT1So6lKpx
81bAMZexdzxKUOSutZF4vDv8DLjaDW5nBqDd92U7ncVIYjUAbxFu5AlfwYCRQSV1
ECtlcBKLhgirb82CLhuMs2NbtpiwLYC0amPYmeVJt8gAdb5hG2Ljzqx81KehtKC7
0nKkGcUiQiRsDlThbhJcEgonLuvJBmgXyboowIKZDEANRMXT6omCMvPX2Wko84Md
b5sxZ+3uzKyUhBYH2VL9FrXxXKLrkrZsCwTc03IeBWcPEkUwUYi08oirrFBasDlw
f+sYq2rZCgd/JcsO/GvQPzKKiE1zd2EY0Zz8BLjBTTg64pXl3stip2gaxXZxNwHY
51GNVkjfO/c0jffs3w7Z2DkFtSj2iB/RvJZT7aSMAc4NKdekHIr7grQoZ+b1fan5
t2ZZihHAg5i0oURWQs/wLTUyv7XkUk8Urc7v5L5I521MUQs0Log=
=wrNj
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
