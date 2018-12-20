Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1097C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953A720815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbeLTV5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:57:16 -0500
Received: from sauhun.de ([88.99.104.3]:37714 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbeLTV5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:57:16 -0500
Received: from localhost (p54B33538.dip0.t-ipconnect.de [84.179.53.56])
        by pokefinder.org (Postfix) with ESMTPSA id 74D852E3542;
        Thu, 20 Dec 2018 22:57:13 +0100 (CET)
Date:   Thu, 20 Dec 2018 22:57:09 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.20
Message-ID: <20181220215705.2zccmtoiuc2v74hm@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwsvx6d7aaikpnov"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wwsvx6d7aaikpnov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a MAINTAINERS update for you, so people will be immediately
pointed to the right person for this previously orphaned driver. And one
of Arnd's build warning fixes for a new driver added this cycle.

Please pull.

Thanks,

   Wolfram


The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 32774a8153b4c62e408297fba352248afb2e0143:

  i2c: nvidia-gpu: mark resume function as __maybe_unused (2018-12-11 21:39:43 +0100)

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      MAINTAINERS: add entry for i2c-axxia driver

Arnd Bergmann (1):
      i2c: nvidia-gpu: mark resume function as __maybe_unused


with much appreciated quality assurance from
----------------------------------------------------------------
Alexander Sverdlin (1):
      (Rev.) MAINTAINERS: add entry for i2c-axxia driver

Andy Shevchenko (1):
      (Rev.) i2c: nvidia-gpu: mark resume function as __maybe_unused

 MAINTAINERS                         | 7 +++++++
 drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

--wwsvx6d7aaikpnov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwcEC0ACgkQFA3kzBSg
KbbhYxAAoNPbJS86aSOHeciU2tQ5pkv10M12Uusakg73Rl/j856TphCIi+Pn713N
KM5dtOAs5ss0dBb7WK+c/p9IdRjRSfzd/qpBHg3f90OrlTzMqKriBcdxAybmWH4B
bO6jyutDaXpgDnbJEDDnSaTI8QujnORCuZKWzp0yjAQnwrGPg3yqIA1f365uFMHW
dd52YmgGDnj+tzss3wGzcG2WdPYPE7TTBXA3/o67/AN3DqwzIydVpN5UXXwe/2Uj
b2NhiX/ZeIfpNJR/WcdRwok/h7q5wkYrIg5fCzkHiHIzU3+zFJuU/L9OwYF7P1J4
5hiXIGStiYY9FixiidBBKbzGg4o5ItPac1qdZRGvNy65fX9sFaO7fvzAS5UTY4Yk
l5iNfei6geDyZziN2Hc4xxFNy6ELOUMuBlbUBsfhGrdPZzhUhun84gO5F/cPVKL3
wWfK4qQmbOHmCala96uR43oQfc6wjlcJMvDWDeOcuJB5ielK9KIf/j0J+mjJpnW1
1J17c0p9LBy2m44uhft+BcxG+BReR8aOfHzKJLsDYczXAiDifDQJv+dwiAftRXTG
yleOBZJyynP0JYT15WRXmDqbnYXzOpQWfjSudMc0Ruk38xEkH2RSMUDUocZ6861H
qJXdPatRsdz8wgCVb9IUIuMsMXBUi2cwNeX2IWwimr7QdOFwo4s=
=zGUl
-----END PGP SIGNATURE-----

--wwsvx6d7aaikpnov--
