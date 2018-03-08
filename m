Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965729AbeCHG1Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:27:24 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:54105 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965405AbeCHG1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:27:20 -0500
X-Google-Smtp-Source: AG47ELsWcTM1nvFVQvt1pR7tXinzfnl1H+5tJaeg98cf1aDZsQDL1GCSqHKaEccJy9TtrmqfMhfKcQ==
Date: Wed, 7 Mar 2018 22:27:16 -0800
From: Benson Leung <bleung@google.com>
To: torvalds@linux-foundation.org
Cc: dtor@chromium.org, dmitry.torokhov@gmail.com, bleung@google.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform fixes on v4.16-rc4
Message-ID: <20180308062716.GA62475@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/chrome-platform-4.16-rc4-fixes

for you to fetch changes up to fc88bbdae049683f321dfa19648d035c93a0b613:

  Revert "platform/chrome: chromeos_laptop: make chromeos_laptop const" (20=
18-03-07 21:18:04 -0800)

----------------------------------------------------------------
Revert a problematic patch that constified something imporperly.

----------------------------------------------------------------
Dmitry Torokhov (1):
      Revert "platform/chrome: chromeos_laptop: make chromeos_laptop const"

 drivers/platform/chrome/chromeos_laptop.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)


Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqg18QACgkQHwn1ewov
5lgTuxAAn5Jg69+0iVSrd5ZuL3Rmse0ZGjzeWJARSRlZ40eO8LHaehhfQONxLMY+
bi5gFHsW4GVV+K54IvV9tejYxmKnSoOvshw3OmaxjQ3UKGXajKwPlTXgwU9w+aN3
FZPIcE7c3SBhrCHL17UN6+WnXNbclYGPY/sz2rDlSC3OSWvaGnL3GWELLscXhE6Y
L1u1bWQYT96rMsf12E3VJAkNSetCsz+VWlmORFGKT+JYYbIQlQSga3vjsYF2tGXj
UYMsFccr4AoGlaQFfqZfpH+j+lTkjqXtWACDqAd7tg3DSlOp2cI+gyKKm1Q4dGfX
rZ9aE/RlRfr3u6ZO/UwLYrMCfZF2rdP8e78toN4cT2ua2K+Kt/w9gOS3rXRgcqtJ
fJMI1zwYSZOFyEo2eQUFW+CNekMdA9PKnU7wetos2xeEks7IY9hkX9AsrVryEMcM
kppeMFXRO5a4YUrgi3OJZSmiByjL2Oz/5huHS/yAXoHRLTBdh4hZ4nhz5Tf75J62
8bh+9259MFaXgwIDDtvWttTSrVe5Ng3kfCs1xmPb82De4HEWjpl2TWuLudLNt8Vk
5SYNrzOBsNUJ6qWyV1TrA3Q+jq8He/WRu0bOGvIMil6XYFs3DqG0UL8arHQsllbb
zFORoyXZmuvMWRtPIhzf7A61YVT1RPLxl8FTaZoEr+vHYasoYtI=
=pMVz
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
