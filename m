Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8767C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8665C20838
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222688;
	bh=pEzY6W6Kg4HlbD5Ls0bj277mIMf3T8ixBKKT9MfdksM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cVkluZ5/9YzvG+H9baW3dwnBZwEZAZkT0sHtKdboNRRLPwIwalzfbdCu33wFTqgs1
	 vC1TGrdI2dwzuZyidDKNdKvkBRKsseLufHgQZr9gPFiRgifzAMEEHzHvP2slu/YWB/
	 cYdSCy7l2cGXei5s/IfRVkLCqU6n1OCwQE10AcDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbfBOJYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:24:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfBOJYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:24:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C4621925;
        Fri, 15 Feb 2019 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222676;
        bh=pEzY6W6Kg4HlbD5Ls0bj277mIMf3T8ixBKKT9MfdksM=;
        h=Date:From:To:Cc:Subject:From;
        b=yHlRCS70bhwYHKMz0dZk+u2mWqPKVT/eEAfaEesw70VC3gk8EBYx/pMtGBmJGX8Ym
         Z4y7/ZQrlGSj43yzjhwolQrRg/oWfUXy7cKi91yckVWIAKfFQcg1OtP0SLsrqwdUOd
         aFyLvSIeVGWDgtA4fBO1ykaF57EaGA3JdEYlUBzk=
Date:   Fri, 15 Feb 2019 10:24:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.23
Message-ID: <20190215092410.GA1387@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.19.23 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile           |    2 +-
 fs/binfmt_script.c |   10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.19.23

Linus Torvalds (1):
      Revert "exec: load_script: don't blindly truncate shebang string"


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhToACgkQONu9yGCS
aT6JRRAArGixOTwYcymskqvVDMbaIg94hWMQo9CNNfCbVxtMJOvgJvdXRctOHxDi
S+23hJMvTAHxtvq4UWrfnNyB5niiTG60orrt5jt1VqwkrZg5qvUk51e91npNdB7K
a6vu/IVSo/COpm36ZZ8V1sC0xBx2mNZwpY+E52MCZujgnHwumhDFP+JW9/znEfQg
HotEPLpzZ/FuwEL41DOG6ppVBsahBW8xR6LihC4zQgk2ezLI3BGpb7+Yn4nzDNNX
0fN8UAjEsqQPctKpFEp31qeqGT6+iXysA0XAwNwG+W+QazZbet2uTBsMU5cZwXJa
icoQcSMwJwYAvQEvT6LAJ3/b6PWIda/cT7ajFcA4IrYZDj359XNjZbaoJ9AP5buz
Jd9rMKqcmRkju33eWcuctBCLveJH14vpgVP2tcwAVceTRe18X4QgRfsdwcv0uEQT
IEPHUoCI4N8sNPH7E8WOiC+6/mMlGarGn+U/oxJlonADq5RrV9QaIyr993eYBQgP
UFHtm4jFoc/QAdoQYurnwzr0C4uXb3anxB29vJ/N5iYM0KwEl/z37ZIKBijddOnN
ARJmMefs8VzUkcfoixnoRCjn+eLHFgVplgb0EncPTAJocBT7V8mrJ1iX0arFjiyW
iVqLbhXV6z6oq2Tjtix1eJfsH/m/p4Q1OZnS/D6zasjanTBSq4A=
=iK1z
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
