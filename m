Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeESOyo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 10:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbeESOym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 10:54:42 -0400
Date: Sat, 19 May 2018 20:24:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dma <dmaengine@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v4.17-rc6
Message-ID: <20180519145437.GA6437@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is dmaengine request. Please PULL to receive qcom bam dam runtime pm f=
ix
and email update for me. So I have moved and would be using kernel.org id.
My PGP keys are also updated, let me know if anything is not right...

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-4.17=
-rc6

for you to fetch changes up to dbad41e7bb5f4b9949ff5ea1d76c20711f326308:

  dmaengine: qcom: bam_dma: check if the runtime pm enabled (2018-05-17 16:=
16:49 +0530)

----------------------------------------------------------------
dmaengine fix for 4.17-rc6

 - qcom bam runtime_pm fix
 - My email update

----------------------------------------------------------------
Srinivas Kandagatla (1):
      dmaengine: qcom: bam_dma: check if the runtime pm enabled

Vinod Koul (1):
      dmaengine: Update email address for Vinod

 MAINTAINERS                |  2 +-
 drivers/dma/qcom/bam_dma.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

Thanks
--=20
~Vinod

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbADqtAAoJEHwUBw8lI4NHf7cP/Rxo24700NWgsnPwRQeqY8B1
3TjYkOsQteBowMw6EOqUZ6c6Wyg5Bi0rFhMJsuujFB5gTVbVod/Hz2yJWySlNtUA
PbfGe6RjBYG2LF0AY6JRTz1Cm19DL58KcMQea5f0gpnQrKpcms+8rrvtMLSPDCx8
m6E066FUIAtE0Z0Dqu5R/+ZsJHv5C+vx49j/nQuVTEWpGO0PpbXqPhxBWcYJq3sM
btZWmpGlZxnAiHsoFK8cWZZ29pMXJDwDotBGUQcEFl9o47mzciYFxyjdI3odNTGF
aZcCDKpb2sDYbiPCvYMcIkMaxkuidgOk0v9QRmazy/Lg6TsqT87B2Jnhy79OB3FE
3ANG19Zs/rrj6T5WzgPEuL3FFyQzUKmdu2NJx0Q0HykYo75idabXC5Ejzr/lbbCv
taHw2G7GL6uZP+5d5AsLaOdxMEBRt/YIjtSkjgz+zosO5y+JE4VrpFQdAbnkuao+
xMMXzuhXyaR2KVVCRpgTrwX87C3k5XBb+FaPAZ1WGiD6pKi5c9vjgseiS4ea4bgg
f8Ipyzumf2wCkWZ54kPzlV5Yf90C4qIuoCr4ga5us3HWXCnTVAZO8grOGZ8QH52e
mGR7T5+UK8dCyC2XuKOBhV1ihWnhgvu4atzrtZHhmqWFaFx80YVIwso+cGzzGWUA
QIoqXNf0/S4pkYGkaFy/
=I+0v
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
