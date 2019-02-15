Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2979FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBED2205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222626;
	bh=tmrb0ZW4qo9T7X73hazh21k13kbx7mZCMKkEsInuXa0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jakSubKME6fLZxskPQPP9ZusOJlGnAVOd3m5QER7x/VxXAUMuVqj8+d7n99L0Xl5/
	 p+ky82iTtY2OTI4WiitQgHMTy53HLaqJm4egOr+iZCK05A5gffrtodOFpGpiH9ImW/
	 W4/1tC57TAr6VdaxRqC0eQNKaWTRXMijc0r+HBSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404780AbfBOJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfBOJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:23:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF37121925;
        Fri, 15 Feb 2019 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222614;
        bh=tmrb0ZW4qo9T7X73hazh21k13kbx7mZCMKkEsInuXa0=;
        h=Date:From:To:Cc:Subject:From;
        b=vKmF0z4VbeWP+VyNq81+ME89U8Cva1CfXa8fd90YvLrU079RKDTPE8SMVUhjC9KFE
         eGXNivCQ28nv6t7UJoPjCcnXoEw+VHm6xuGSuUIeGybqU6i3epO3sOcIMFJRD6UN3D
         kLwG7DiH9h63ZsWti9EcOmWpqRPt8h/xlYfUsVRs=
Date:   Fri, 15 Feb 2019 10:23:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.101
Message-ID: <20190215092318.GA1193@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.14.101 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile           |    2 +-
 fs/binfmt_script.c |   10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.14.101

Linus Torvalds (1):
      Revert "exec: load_script: don't blindly truncate shebang string"


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhQYACgkQONu9yGCS
aT4N5BAAkmAMAqLge8BxVGg7pzE4Kczz9jD04AiSGxS1gf3ZcQNy1oIcowwEd3Jb
a4Q6TvT9eYNBSPjOfnwwPiVJms8O+pIwSgMpVgDLp2Eg96it0wBOlj/Jd4JHpZkR
026qCGYZy0h7gZfynm6vJGt+X0rjWFi89Rn4YWksgXVJc8SRo4zqrHUuHEslQbrY
wBI7bXzqx0ViDNS8imrP5bOsYoU43+mn/RJPunlqZjkQs4rTeBo54SJQODHmSffd
drPYzMyLeY9BBTE5hDlixpmx7jgFiHy8M5Q3aOLQdMcBfxbQFHJBS/kxLVs7ge/X
fq9wCDOX8X8P2p5P5xFH71cJLvVaFbcueqICGH2PyVbHvaYT0MKwKkDBNf58UkvI
HC/gP1oeYr1P81u8JEaPvqOMYI/yUGA1ErYJ3lBuA57GY+dUxoDpsYXaKx7FFDsx
I8Rg3904q4Fk9qA5QOQutN5d26wDiWrLU6HAvje8V47Tu8HkjjbrJGgR2URjvxzn
1XZpyI6/RpINU/p9G3nRMR9DuTLheaqBxDwII82sMjvxPrStp/J2DznT28vjQw4p
+6GXyjnulXYWt6p0dpr5X5zituv66BN+R99PxrK6PSONLuo//2RyYd+9UZ/VLint
uykxmLcjPDKPJ/Py6lQoU1F/zEkOailkSznt6XacahMBJqav+Lk=
=4n+4
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
