Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED158C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7208A21877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7208A21877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeHRMcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:32:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:32:20 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 658CB941;
        Sat, 18 Aug 2018 09:25:20 +0000 (UTC)
Date:   Sat, 18 Aug 2018 11:25:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.3
Message-ID: <20180818092516.GA5382@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.18.3 kernel.

All x86 users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 arch/x86/include/asm/pgtable-invert.h |   11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.18.3

Sean Christopherson (1):
      x86/speculation/l1tf: Exempt zeroed PTEs from inversion


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt35fkACgkQONu9yGCS
aT78MhAAjZtXoD7x3bxFv7SeCmnoRvWefFIYiNpTlvC6htt3GIh9fPfnyAevncjz
e4byNaUasYsGM66YWa6abwaoDg3wouREORcCxkCVanL5TwqjEduj3w4pprC5JQIM
0oFIKOY6CG9GVGOBAHHUTjUS9b2tqbg2Af0MfaJnrCnUdAoReDaVE2cF9/DoQQIN
YQjhWcrZEd0/dMEuqDXm7nUOd52k1lWJa1ro5k1YOWjMHvMb5Oar0G8hwPYfeo57
/2Hz20IDMllkwVcGSYr6c2sEERH1RJ5RdxJIkSsi/PuwsEzPWWoWG4wUSfqjQpAn
a0//MfLSCpN6A/dKuK0Qr+AhT4u0VOBYafquteEOSQbWfBc6GKblSN7IoyRU1wzJ
iujQsvvHbDt+ZnpT0fNZf/NHRUT5TVa0VPoxjC0rKCC8efBoPvQ7U+N6N7wzewMS
I5fZhE7LDTHMyMYEGTgeTUCRr9mDE0OcFSMsoMFibkrRAMuuX1S6SVdXxLX0WjXU
eESPLDyuuLnC6yKrv1nzHA/qitOVC3qEJq/Wm/mbT6jbWdjZXuGz3yYDCaWe5z7H
mgrfGHSHU23vB0Of8krLM0A8X7HctiUTFKGPo+0c3AAHWKT+yyDtZaONHC0HLtCy
dL1sqp+QaaaSNJBQupBLyXvzIYLC6dgCMLAF8neqO+9/Cs1TSXk=
=gqxb
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
