Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86358C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D321877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9D321877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeHRMea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:34:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:34:29 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B922F3EE;
        Sat, 18 Aug 2018 09:27:29 +0000 (UTC)
Date:   Sat, 18 Aug 2018 11:27:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.150
Message-ID: <20180818092726.GA5694@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.4.150 kernel.

All x86 users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 arch/x86/include/asm/pgtable-invert.h |   11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.4.150

Sean Christopherson (1):
      x86/speculation/l1tf: Exempt zeroed PTEs from inversion


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt35n4ACgkQONu9yGCS
aT4+Wg//ZnuQDV13fQtT9t/bThOpTd4j1g1tFaIM3/PS+hH05ggJoaioo+E6JCGR
mtG6yFHGOOMu8ZWvs9EB1L+3blnR46rsdU7K/klaG1/tXsevPNi75Ppw1Jqwkopw
Bmu96YymeRdoCTh+zmRonqRiMjbB7/r8rPWvknGLnRkaH3VOaeLRY7FzAc8jilGJ
1w95HcqfWR7XZUKzofpWdPfitP+TIPEUTKj/iTIEFvXLEUqOZ6vqA0V5PW2NlDjM
AxObWvaIjPikLhiYx4PgCqcRlOyuNQAC3p+IR+TWEO7ZbkC/3oDXQjlEFNU547kH
N82b9aRKL0yFALIauCAx7LbGE22RTni3dW5a8W87ucvWyCzRqB07w1nphnwd64+g
jLMDKNvAnQGMSkNcHtAO4LaB58ExrNyUSLkR+ueEuGEcDV5/qXF13uxBEE7ib9R2
MNNeH0hrL44sTJhSOgJh4xTsNbyBC7YS3J8xPKbzXy8mIbFewmFzirT3XJ20NlHW
WWG26foY+cjfhqzZy2EqKcy41Ech4wa6rrGkwnmsU154O/1oSJJjmSkVHYOZkycn
PgrXb9aQ8L+jtE2RZ4XbuZYVsD/YD8lrg1JLeVW3MpoiE6weqyewSN2Uq6fUYcq4
u52joE0+zO4HNkfxzqCDBJIvtV0m8BiPPHCYRSjph86E2wUqQ+k=
=1D7E
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
