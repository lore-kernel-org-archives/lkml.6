Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F4C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F5620989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F5620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeLFKeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:34:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:32862 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFKeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:34:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B1A8020A63; Thu,  6 Dec 2018 11:33:59 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 75B9D206D8;
        Thu,  6 Dec 2018 11:33:49 +0100 (CET)
Date:   Thu, 6 Dec 2018 11:33:48 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     jwboyer@kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, antoine.tenart@bootlin.com,
        allan.nielsen@microchip.com, steen.hegelund@microchip.com
Cc:     linux-firmware@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL firmware] microchip: add firmware for VSC8574 and VSC8584
 Ethernet PHYs
Message-ID: <20181206103348.m7dtld3hccuhfeuf@qschulz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rx5hvc7fwceios3q"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rx5hvc7fwceios3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Both VSC8574 and VSC8584 Ethernet PHYs require a firmware patch to be
applied before making use of them.

This adds the firmware for each of them.

The Linux driver using the firmwares is already in Torvalds' tree:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5afc1678044a3eea48f0295ae7bc2b13d59b128
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=00d70d8e0e7811ed8acba24e04b9f193c3b84beb

Thanks,
Quentin

The following changes since commit 1baa34868b2c0a004dc595b20678145e3fff83e7:

  Merge branch 'nxp_mc' of https://github.com/NXP/linux-firmware (2018-10-26 08:13:19 -0400)

are available in the Git repository at:

  https://github.com/QSchulz/linux-firmware MSCC-PHYs

for you to fetch changes up to 57d49d580af5c67d7f725dda75aa71cb94505514:

  microchip: add firmware for VSC8574 and VSC8584 Ethernet PHYs (2018-12-06 11:02:51 +0100)

----------------------------------------------------------------
Quentin Schulz (1):
      microchip: add firmware for VSC8574 and VSC8584 Ethernet PHYs

 LICENCE.microchip                            |  40 ++++++++++++++++++++++++++++++++++++++++
 WHENCE                                       |   9 +++++++++
 microchip/mscc_vsc8574_revb_int8051_29e8.bin | Bin 0 -> 1655 bytes
 microchip/mscc_vsc8584_revb_int8051_fb48.bin | Bin 0 -> 92 bytes
 4 files changed, 49 insertions(+)
 create mode 100644 LICENCE.microchip
 create mode 100644 microchip/mscc_vsc8574_revb_int8051_29e8.bin
 create mode 100644 microchip/mscc_vsc8584_revb_int8051_fb48.bin

--rx5hvc7fwceios3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlwI+wwACgkQhLiadT7g
8aPGZRAAh7BKsWLxPiV0GSuIaDTWlGR5g+jr0kx3LyhMXsr1wFAYzWYz24D5DrFX
F/KCHG3Xy5Sjqs56v1fJZ0PGa0BWH/pagsLP7DHJUc1/74wkJ2kDPOn7r8Pp3uoI
MeK25HUNTWx59OH4XdZJETCQCAHurv83X8XxKimbXyiAV6dV2wsnmnYtVl437Go+
0Al+beX7NMxvNXHBppyLo87tZqTEfB82BMGTnSJvXwATAVT+3/wZtGLQU3ZQZLgO
IyTmtW2iJiRnqnFemio5hvZX561V9LFRzgUA5g9deofo8pp3YgEmHXAfCXMEAqu4
O/xS7eJ08A31+x5rwfo9QgGuBN96IzNlxUYbszgPavFwU+cUNtq8+9t7sPnD/hbd
ighMKC3NW8QEQAihViEltb6WPfq61MmoG1WOj6WFzptUjbsGl+EbJrw4tTp1cQHm
rsc6MezwiPtn7hSRAqy1VDBoqD5tzJMhINHZ1k7swWZCjxNy+uBVDplST2l/a7zp
oG9zVtDqqyOttkoGEkTbg9nbOiGedVcaXQBSMX1GRae1wtI+Ho6mfWayOUgCBJSA
g2yM1fTwTr8gFnqWbBW1sVBkf5RumaiyOVD2nBnjxH5gmoDpse5wgKfvOV3wpf8d
1AoURptaRvmlWLdCHS9UogwD/gCaVklp/38Pzw+lv03nStZKgbQ=
=PZhl
-----END PGP SIGNATURE-----

--rx5hvc7fwceios3q--
