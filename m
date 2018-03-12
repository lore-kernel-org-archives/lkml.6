Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeCLUlh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:41:37 -0400
Received: from ozlabs.org ([103.22.144.67]:56255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932171AbeCLUlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:41:36 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 07:40:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Felipe Balbi <balbi@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <johnyoun@synopsys.com>,
        Sevak Arakelyan <sevaka@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>
Subject: linux-next: Signed-off-by missing for commit in the usb-gadget tree
Message-ID: <20180313074034.1ce73155@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/r2OruyXJodQf8+5NZ3_Aqgm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r2OruyXJodQf8+5NZ3_Aqgm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

Commit

  969d58abe57d ("usb: dwc2: Enable LPM")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/r2OruyXJodQf8+5NZ3_Aqgm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqm5cIACgkQAVBC80lX
0GzGNgf/fcy2BbLU9xFb8g2XNI9idLZw0SflusfJv3SjmS+xhITZnEeGKWlPoPmY
JZ9k6CshVXFXdt96lrQvGwfNnn0NQv0/5gzIQRSYhQd6xfVwSobEHypue1gIaQFr
6NZRVftq8GJFSTWoeJvGgL4vWWqW5OHPoLz/5tQ4y+r8olMezADeBCdBcxRBIFVU
dbCwdS8d26BE+Rjd02tbHbc7TVpkY9+LEgQ9T3wfDyycUxnQ3/PRtKUBSI/UIm8d
1nklkEyHwxn8KvBSaYah7OndXJYunbGXfrbwXR1eNmrbZjueixptIVsXrGTpziHU
YKTLSs9XNmpLEbQvpmzuhBhB6clSIw==
=lp5k
-----END PGP SIGNATURE-----

--Sig_/r2OruyXJodQf8+5NZ3_Aqgm--
