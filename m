Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA3C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EAC2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WYHkgznk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EAC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeLKWvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:51:12 -0500
Received: from ozlabs.org ([203.11.71.1]:54867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeLKWvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:51:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43DwCb58Rgz9s3Z;
        Wed, 12 Dec 2018 09:51:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544568668;
        bh=NNmfWk30fSpXR/IDf6l3Y7W2EkeqRqOzZueDTsKpZC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WYHkgznkdsBLvMqpx24KzddcagbTgrwaSIG603mZZZW8BvFQRgiTXvZ0JyFQHY3uq
         daBYvmQeWYoW8MaSfd3S4b4kZaYuMqbl4lPWJxnhIKjO04COHcBtdlDDyhXsTfGkJl
         OJFbOPMlUH2P+sJwEfs7bZLIN0B2vpsPX4+Arn6d/sjybQ7E6zyoEVQHAr03KfAW6e
         9u/9vPZ8/+dDg0PN4EZdBf4/Tu8TDetFXYg7QVYjtsZZO/JEvAHBE92zHclNLrrm4q
         Jo5rvtWh1Zir1qeRAp5XAK0Y3/ZiHIy5fzvrERZzRfgtxMBZXzggAkpXYJnsG2dlsV
         vXZGCvBvvkysA==
Date:   Wed, 12 Dec 2018 09:51:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andreas =?UTF-8?B?R3LDvG5iYWNoZXI=?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20181212095107.5e35982a@canb.auug.org.au>
In-Reply-To: <CAHpGcM+wCSrj0pk89ZoMENp+L_zSXbSFhEJcsdDEOh1F-GmGvg@mail.gmail.com>
References: <20181212072402.7b967df7@canb.auug.org.au>
        <20181212073802.2fc8dc53@canb.auug.org.au>
        <CAHpGcM+wCSrj0pk89ZoMENp+L_zSXbSFhEJcsdDEOh1F-GmGvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FSyM6y_exB6/NT96yZnpR92"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FSyM6y_exB6/NT96yZnpR92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Tue, 11 Dec 2018 21:47:43 +0100 Andreas Gr=C3=BCnbacher <andreas.gruenba=
cher@gmail.com> wrote:
>
> Yep, I've not asked for a way to get the server to reject or warn
> about such pushes without a reason.

Sure, but also here's the script I run (which could be run before
pushing) ...

----------------------------------------------------------------------
#!/bin/bash

if [ "$#" -lt 1 ]; then
	printf "Usage: %s <commit range>\n", "$0" 1>&2
	exit 1
fi

commits=3D$(git rev-list --no-merges "$@")
if [ -z "$commits" ]; then
	printf "No commits\n"
	exit 0
fi

author_missing=3D
committer_missing=3D

print_commits()
{
	local t=3D"$1"

	shift

	s=3D
	is=3D'is'
	its=3D'its'
	[ "$#" -gt 1 ] && {
		s=3D's'
		is=3D'are'
		its=3D'their'
	}
	printf "Commit%s\n\n" "$s"
	git log --no-walk --pretty=3D'format:  %h ("%s")' "$@"
	printf "\n%s missing a Signed-off-by from %s %s%s.\n" "$is" "$its" "$t" "$=
s"
	printf "\n"
}

for c in $commits; do
	ae=3D$(git log -1 --format=3D'<%ae>%n<%aE>%n %an %n %aN ' "$c" | sort -u)
	ce=3D$(git log -1 --format=3D'<%ce>%n<%cE>%n %cn %n %cN ' "$c" | sort -u)
	msg=3D$(git log -1 --format=3D'%b' "$c")
	sob=3D$(echo "$msg" | sed -En 's/^\s*Signed-off-by:?\s*/ /ip')

	am=3Dfalse
	cm=3Dfalse
	grep -i -F -q "$ae" <<<"$sob" ||
		am=3Dtrue
	grep -i -F -q "$ce" <<<"$sob" ||
		cm=3Dtrue
	"$am" && author_missing+=3D" $c"
	"$cm" && committer_missing+=3D" $c"
done

if [ "$author_missing" ]; then
	print_commits "author" $author_missing
fi
if [ "$committer_missing" ]; then
	print_commits "committer" $committer_missing
fi
----------------------------------------------------------------------

--=20
Cheers,
Stephen Rothwell

--Sig_/FSyM6y_exB6/NT96yZnpR92
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQP1sACgkQAVBC80lX
0GwJywf/byUJe37+q7abz6pFZ1C5eRE+KsHO0ZkxrPPkzrXxtjiVbo7VnITO0shv
LWcEhEYQcowuZhDr7dsyBCAXzvWtRrFbQW/za4GLvHsNqDAj/xqFudxsYURMOh4g
eSKuyU2ZpaT7dxhuEGYzEuF/IjTC+RZpL6rIaFA6H26EdrT5iQEUWT9Ab8BnvUpE
BzI6knPjhXFVEniVItFRb2gbQ6qikkDZ6dO9WFyTbSm98/+L9IzfYJjM9QbMtnpp
kWhj3lLZDJ/SsJlynGW6rc2pAoxyLhLnJhpFXmCEweGv0f2IjCYkIwlrUtm0m3Ut
jOBs3UEhRxvJwRGMKI38mtVObUwT6Q==
=B/mI
-----END PGP SIGNATURE-----

--Sig_/FSyM6y_exB6/NT96yZnpR92--
