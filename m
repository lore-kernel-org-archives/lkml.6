Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5452ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB1F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB1F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeGRHGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:06:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeGRHGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:06:48 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78737A80;
        Wed, 18 Jul 2018 06:30:32 +0000 (UTC)
Date:   Wed, 18 Jul 2018 08:30:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.8
Message-ID: <20180718063029.GA7456@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.17.8 kernel.

This is to fix the i386 issue that was in the 4.17.7 release.  All
should be fine now.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile           |    2 +-
 include/linux/mm.h |    2 +-
 mm/page_alloc.c    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.17.8

Pavel Tatashin (1):
      mm: don't do zero_resv_unavail if memmap is not allocated


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltO3oIACgkQONu9yGCS
aT5OfxAAircTY4JvlghEReCtGNbZ4CxNu6w7LDAqIlp0QyUc3NpLIrVWVhmJdZWD
n2ccPUS08lFg8SeTkF5zVfNL2Y79SZS+IIfoacXlsXP0utoqbqrdcIUu3XqEhEIq
l7ChvHJEJ6p1aLj2jr7aVMBHHGvsDxrghO4U3tN/j556CywhiJCsqo67bRKzD2ou
MGrWzTGFYGwaf5IWwqw853rbl5hsEtylxh/YJyFK4t6gWjaW6LamA9tqCmaAUxpm
DzoZP4x017MfcYuBH99h+a1Fxv9JPYDezoKgNRncQRSXnOkseXQGFd3DtgFpLYft
tdtWPA06m011DCCcoxAIu8WB/jfXsRsXrqCYfyUYVBSlaWp53jTo7jfAwu7mBJhO
2fP26GlVtiko+pwzq5ftM0MaYireCl6n2eEEAK6ft5OtBJ0XF5brL8ECrB3bhEW0
mv+TQFajmBa6Ko9GAoiEoDT0fD5TGFg8RF5qWK3qlureXpuTPVTyMWn2CxOoks9M
la+aDudDgJSt757XhbxRLipWZNRAeWBRpOWDkKhYC9w6Azga0DO10PTxd7PQ5iFH
tKFyz5d4WTC9hZnk9+yIf/HSrv61ZDcluV11vv96zU9zQxMQ/0TyptGFqi3nwEHx
cE81n71vTNuM7ULegymvG3AkzNBvMjg8gR+KZXGitfL2dJpEswA=
=B5jJ
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
