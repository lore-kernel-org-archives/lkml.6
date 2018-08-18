Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6FCC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCE921877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCE921877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeHRMdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:33:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeHRMdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:33:38 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4A60941;
        Sat, 18 Aug 2018 09:26:37 +0000 (UTC)
Date:   Sat, 18 Aug 2018 11:26:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.65
Message-ID: <20180818092635.GA5549@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.14.65 kernel.

All x86 users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 arch/x86/include/asm/pgtable-invert.h |   11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.14.65

Sean Christopherson (1):
      x86/speculation/l1tf: Exempt zeroed PTEs from inversion


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt35koACgkQONu9yGCS
aT67cxAAryoRwBnXB/OGM892q6oiOrhxoTVJhWGRTWcBkRi29Fj6PlxduCeKCRi6
/9qCl6xSCKpz9FIxWKVS7PQSD1CWyEL8uBLM844tybC9pyqEA46ESWqAiwJWQpkv
2avGCJH2Hh9i5B3mu8dBTGML/yY4670ACj2b4Jf9chOrDITrUChJksly9/VWoq+y
YVmRXsnakEV/F5AugHd0GvdpbSv8ZAnEaD2yOdCFv3/AX2sLvlcZG4GzMBtgnp2o
J9ywJAQJEgsollNcjhwLy1Z0vDCukBOUosIwecTLuvOXgOoJUoAS1Y7U2W5K9QjD
6vpkWBpHOKJhngstY/b616N0CTqUtRd0Hcic1hygUJGxyEc8imY5BFdr6PSaQA+E
kN4zeXp/ZRuP3MELX3n4PUMuasP/o739S3tkufGWlQMjPelusJOsQpKMiGIw3mqt
gMaaQICsUPTOuHtnm+UWI9hhGLcyiAUJlHWuhyymCLAJ3rfjYAX30f/Jqf6IFYXH
2WykvIpUwrAC5zY3VhdUPzd9h83zAnV5ckouHVj4lqlpC0gXi4Ep5qI3WdElfI/V
BJGuyC1EXXYWwXSLZdBjCD2h7i6u9D1NYxoqmMDXI/MjpzRngu0/fuAlaVOyQLPK
hoJ06po+/IC9+Ubdy3MAyHHhJi7dWqr6+vGk8vOjSHXFKprT4u8=
=YJXj
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
