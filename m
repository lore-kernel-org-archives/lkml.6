Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeDBRsT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeDBRsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:48:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA392178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Mon, 2 Apr 2018 19:48:14 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-4.17
Message-ID: <20180402174814.ppsa76dh3btqexu7@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b3fuejqnyysofrxc"
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b3fuejqnyysofrxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-4.17

for you to fetch changes up to e3d7fbab062b877b96c09ffb43733502cdc1bd0a:

  HSI: hsi_char: Delete an error message for a failed memory allocation in hsc_probe() (2018-03-19 16:31:07 +0100)

----------------------------------------------------------------
HSI changes for the v4.17 series

* spelling/typo fixes
* remove extra error printing for -ENOMEM

----------------------------------------------------------------
Colin Ian King (1):
      HSI: ssi_protocol: fix spelling mistake: "trigerred" -> "triggered"

Markus Elfring (3):
      HSI: ssi_protocol: Fix a typo in two comment lines
      HSI: ssi_protocol: Delete an error message for a failed memory allocation in ssi_protocol_probe()
      HSI: hsi_char: Delete an error message for a failed memory allocation in hsc_probe()

 drivers/hsi/clients/hsi_char.c     |  5 ++---
 drivers/hsi/clients/ssi_protocol.c | 12 +++++-------
 2 files changed, 7 insertions(+), 10 deletions(-)

--b3fuejqnyysofrxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrCbN4ACgkQ2O7X88g7
+prv8w//dkTn5qSxlAadtrqeDUCD0ddW1NKUMmN+/bil2ZzxtZXjsKVK0A2O0vX5
+vyarnDfM9Qj5aGw2kBC3Jaca+wKfTLGvZWHaYUsAUAIdsxbsP1aGp2ArgQ3MIyk
Vk7M1JRMAD7U+nSwSvXe9nuAME6U62Mb7hgkU/NxmD6A/O5vPEJ300YOMkpAVkHM
MoYKpgpOQcMPX7qaKTdokzVNMc4XOX5A8EmmWmmIgviz3TMm8icETXz95B0cp1om
oR7e0jwOBqfo1vhMwWrJ079OTDFnRleEvEwdDpxEvlvdtYD49TIOLjfiFXFxZ/Sm
uOk9P1k0fYzsA71VmIKDGT/1rXfOpjK0pzMNjXhKw5+AvT7hvtZ3UDqAz8Fsot8v
uctZbLM6yD6sBZg0A4HxcNsHDV7C1UnG5az1tA1vdymWDsR4N1yr/B0mP0xgMDHU
lKFnk9ygkCRdgdxkVvm9qJvQPLmVWQ/ziMDW9mW+J/wD6HaMi6j0/yEXAtYwIRB4
agHbsqtw4zNl8RM6rV5I9v+fyQILoS5IncTkFLM3aa5uhM/mVlxj/Pm6nN955cgU
fwOOoRKF+DeKYGPFaSS078f+lfsf4ct1xic9ORPO8KI9VYR5sC2fY9tLGCioNHEz
Xb9bpbEd4Z2ir4pDicPnCe7ctTd0/NKzXWaLY/8lG/xwQAxX0HI=
=lgcE
-----END PGP SIGNATURE-----

--b3fuejqnyysofrxc--
