Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B64E21877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 09:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B64E21877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeHRMeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 08:34:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeHRMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 08:34:02 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6597B941;
        Sat, 18 Aug 2018 09:27:02 +0000 (UTC)
Date:   Sat, 18 Aug 2018 11:26:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.122
Message-ID: <20180818092659.GA5619@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.122 kernel.

All x86 users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 arch/x86/include/asm/pgtable-invert.h |   11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.9.122

Sean Christopherson (1):
      x86/speculation/l1tf: Exempt zeroed PTEs from inversion


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt35mMACgkQONu9yGCS
aT7LMg/5AeV6QcD/oEeZOu4qHrI0SHxxF5uUcbC83EPB2bYa6JSuEz0IKOWNZNQ1
1Z3KDsjm5YrKHAu2JTst5BQkcfzdQ8SIEzhWMJR0QbJh+dHU6Mn5HgaId4EuS1Rb
iKaFlPenFHoC8oEe+ul8cOmHC8frvv3PVHEY2K3Sk/tJsH0+ll9yYakXgVTrd62x
+WxPIU0+0Wbfzs6tgzf3s6D2tGuCHcQv8DRqnl0fQnR8ttKthuGntXDeGM+4JBO4
H3hqUxkabfH4yJP1dFerFBij5FNe6RfXA0YXthJY5IaL+4tKjCrSjV7mhGIkRkFw
V4QNQZ7WcR/TWcXJEsiNXi+iW7tor8gyb6deFKWQ60EokcfPzqjSJyakcojvkrBD
x6lst2vBfTH1kEjj/cuM26mi6PBtcPJyolduhNmCw6ZbgqysOj4KLFDx1et5U0K4
6SAhni1pPIdwH4lGXAK1kyAl5LAIskEMfXa7+xPACZ5C6qYSXomtwlUXcitVEF2O
vRX4HllS16yFZGiNMn7xFYRYQwJJAdqdbwkgY5g475sabbGBjYGdSiKmmQQK4yL8
2zj94UrtvhYGMpZlwKZo4aQR0b7OP3LFrtKSV2kgL+D88Cbrb203hRk2Lls6+s58
CSh3hNQ13rKzgvJS721D0YE3819gz9Uoelo4GIy58ItqRIW5guc=
=+weJ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
