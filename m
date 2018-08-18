Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E29C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DCB21877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DCB21877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeHRMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:33:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:33:14 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6734941;
        Sat, 18 Aug 2018 09:26:13 +0000 (UTC)
Date:   Sat, 18 Aug 2018 11:26:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.17
Message-ID: <20180818092611.GA5482@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.17.17 kernel.

All x86 users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 arch/x86/include/asm/pgtable-invert.h |   11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.17.17

Sean Christopherson (1):
      x86/speculation/l1tf: Exempt zeroed PTEs from inversion


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt35jIACgkQONu9yGCS
aT560hAAiKSpSKYEHo/u98uQ241/gfQXro7ziGV8UtirOyTJFL0lIwCs3KMlzPuP
TZ2g6ftpeCYWKIV+YNZCZ0RIhp7HQuQZ6MoZ3qB7OodDsyaZT1oSjaFMbID6OiJ2
k8ScZzehcKqs9C1gIS0aBAvEHRhlzVe+38oZis3usbxxMIH+90s80oXI4j0HENp8
Gugao0tNr2ly7I/tVG904pYpbYnNUmby5gAsD+iv9DIRw3JAhdEvcKmxvA0lGs2z
7MI9e2jboKyga6ZAy4oqZGky5lk4B0NgyMBC06Yf+6rp+9r954fs2HMB5II6tYeh
+3Qyr/aIKXIpcZRXFqZ3PDDMScee8Y8C2fVGEzzIw9mqC6bzw58HPQfbS9yX6QWB
ZIBjpcb6TT2ZG8YfQJKSAG6BzZ5KdARrCiNyeORNMAeJUSNVRTArmfHjjhxeDNa/
nPGsW5B3/Veh37sodimEwJBjthKaNtp3VS1BNDmuy1NfcuT5R30PfFmPiLg2WU/C
gFh9w95pgwzMaQkltePNYgLiN3sXsBeelszV7kOHoeKCUrfdx96f3s5xJ+pOGUTv
14Sh7MOx683q41mj2nRUmRzK3toAV37rV9E20HGAJj1hHhej6A8/hQrNq9akFtXn
6C02lrn7LwZgOr4h9ydovTv35ww/meStmZn7MtYqRcLSaFpNyhA=
=gZ46
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
