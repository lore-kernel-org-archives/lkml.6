Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8278C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC721872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cdm2VheA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392209AbfBMVR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:17:27 -0500
Received: from ozlabs.org ([203.11.71.1]:53627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfBMVR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:17:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440C5r4gnnz9sMp;
        Thu, 14 Feb 2019 08:17:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550092642;
        bh=usZD1EHBiWCYhzRpVGMb6jzegoQs6kDHeIOc47qPbdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cdm2VheArDNKYky10oqqe1JnTxaEux1KjBZzry81HiR7z96c8QqmIn8ZE05uzDDLl
         uiq2P7aVhxe8pG+6hpcd8AJV4SKgLuMkNPM3drX8C7nwEFQ3C4BshFc2DhQ+84KX6f
         MEjdj5ecERJlDWI1ENNf1+ngQlSl8MU3rHGwtgKFCl1N8JxjDZYr13orRAYcVS6J09
         rL6Z8QGQUDfhLgPOU3Eo/XI+FsjhHtZ7U3GgCjU3W4mSr/66tZY+WAZNMfZj1ZDRfa
         ryrxvUKY5f7x8uRjbthUQSn45jAXOYxpxKokjNqviLB/A7m6G1Ac/PvrHY9xUSgzAu
         3P96utEf/EGLg==
Date:   Thu, 14 Feb 2019 08:17:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: linux-next: Fixes tag needs some work in the pci tree
Message-ID: <20190214081716.1367f024@canb.auug.org.au>
In-Reply-To: <CAErSpo41bDxfajDJFH1AQK0ZwX=fC2jnay8Y5CyaS0f=+9LOHA@mail.gmail.com>
References: <20190213100309.03b5ea58@canb.auug.org.au>
        <CAErSpo5vmvx8QcQoEGzvN+5sWbL1syr2c5hD9AJwW3FGJ=8Hyw@mail.gmail.com>
        <20190214070958.058aaf32@canb.auug.org.au>
        <CAErSpo41bDxfajDJFH1AQK0ZwX=fC2jnay8Y5CyaS0f=+9LOHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PH76b2KzPsXn/xXl=LbMreg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PH76b2KzPsXn/xXl=LbMreg
Content-Type: multipart/mixed; boundary="MP_/Ckag9eUwX/k/LeRKcpE3w7."

--MP_/Ckag9eUwX/k/LeRKcpE3w7.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Bjorn,

On Wed, 13 Feb 2019 14:19:32 -0600 Bjorn Helgaas <bhelgaas@google.com> wrot=
e:
>
> Thanks, I guess now I have no more excuse :)

:-)

> Is the "missing a Signed-off-by from their committer" thing that I
> regularly trip over a manual check?

Ah, attached is the other script I run (maybe I should combine them).
--=20
Cheers,
Stephen Rothwell

--MP_/Ckag9eUwX/k/LeRKcpE3w7.
Content-Type: application/x-shellscript
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=check_commits

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

exec gitk "$@"

--MP_/Ckag9eUwX/k/LeRKcpE3w7.--

--Sig_/PH76b2KzPsXn/xXl=LbMreg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxkiVwACgkQAVBC80lX
0GxHnAgAn0wqCQDaZTTAKXS0uh4RKt4K+8EFvWHTku2hhvUXsbP2ZKTBcWWj71T+
sdu4+Gb5AgNXCUagRL3ujNwQKXosfQ0XhKVr9PlC0mh9zzodX/p5Wl63ECQRrJkI
0wiT1gyQMVgmSIpge1Q3iC24fCUbAaL+bQslxYk1Lkg+ka20sFax4ji2+7yn4Cks
sJHAm+SrfsamfhK3plTivebLHZe7Ifw6RpCUykRVn7WoilP1khBHl7MXzzo0bS59
5/opDSbEDf8MWYuWn49BgMO2GLy2Jy44DfRP5TqtrZxUDMu6GZvTerd7uAUqUtKq
p9v9r3lHVNUyhSpLLXVfkFvHkcfdTw==
=10xJ
-----END PGP SIGNATURE-----

--Sig_/PH76b2KzPsXn/xXl=LbMreg--
