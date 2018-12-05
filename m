Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1EDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8332082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8332082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeLEVBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:01:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:58404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728156AbeLEVBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:01:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4906AFE4;
        Wed,  5 Dec 2018 21:01:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jonathan Corbet <corbet@lwn.net>
Date:   Thu, 06 Dec 2018 08:00:58 +1100
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: convert path-lookup from markdown to resturctured text
In-Reply-To: <20181205124644.3f8a452a@lwn.net>
References: <87k1l9dgx9.fsf@notabene.neil.brown.name> <87sgzc7v50.fsf@notabene.neil.brown.name> <20181205124644.3f8a452a@lwn.net>
Message-ID: <87woonelit.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05 2018, Jonathan Corbet wrote:

> On Wed, 05 Dec 2018 10:02:51 +1100
> NeilBrown <neilb@suse.com> wrote:
>
>> This allows the document to be integrated with the main documentation
>> tree.
>> Changes include:
>> - rename from .md to .rst
>> - use `` for code, not single `
>> - use correct sub-section marking
>> - fix indented blocks, both code and non-code
>> - fix external-link markup
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> Looks good at a first glance, but I have one question...
>
>>  Documentation/filesystems/index.rst                |   2 +
>>  .../{path-lookup.md =3D> path-lookup.rst}            | 875 +++++++++++-=
---------
>>  2 files changed, 448 insertions(+), 429 deletions(-)
>>  rename Documentation/filesystems/{path-lookup.md =3D> path-lookup.rst} =
(59%)
>>=20
>> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesys=
tems/index.rst
>> index 46d1b1be3a51..3c0f441a9536 100644
>> --- a/Documentation/filesystems/index.rst
>> +++ b/Documentation/filesystems/index.rst
>> @@ -359,3 +359,5 @@ encryption of files and directories.
>>      :maxdepth: 2
>>=20=20
>>      fscrypt
>> +
>> +.. include::  path-lookup.rst
>
> Is there a reason you used "include" rather than just adding it to the
> TOC tree with the rest?

Simple.  I didn't know what I was doing, and so randomly made changes until
the result seemed acceptable - then I stopped.  If there is a better
way, feel free to tweak that when applying.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwIPIoACgkQOeye3VZi
gbmOuRAAphLwAwpqMrOx5FjVzmI5fe7P245acp0qETdojbIiZAvgbch4WFdIpiBY
rB8NAd7gWoh96T/YFO+DnuZdP+V/CMrsWswcGxGp4QWZlB/nXmM8e/uAzZ4v6LAB
bycspvt40p1Ubafck1FlNxxO6axtsqTvmdidVHWzUUjTc5q+k65bOWSP3/nNmIpD
CZV2Val+RnkcS/ZbbwtM1dkowrLOWNV1dn7qNIKo1xC3QX/vA7QOtnjLgHZBeTQY
ywUgiKOcvJQgpQ9cBzUyz3JxnXr+D6EobThA7qAceEeU10D80cSuzYOcDeH6Xj7A
FvYUbic+t7PXTrxTYDHopCb3Ejck7JbxwQtvE5s6w2YR7qeVSDonDs/MCyAmbM/C
xar0VVCfGUQDkRRvwcXsHHQ8Iqku4cqx9hoT2TxKXvf67bPEY77HXo0iyL3NMj/J
sqcKKYh/pHDvKVLAd14NcFRFPYXdonQZQW1PfBY3pWgiiUiGWZ9wf330iq6ZM8GP
bXW55JaGVQStpFwnyuA4IEjxqgsj5993Uwb+2zlqHVBMbelwR9RtFFiMs1UbCdDP
gX397BtDqcBnW8qStK6AQWTQhQOqZQ2iEXIA+j5IUpr+Jj81kVn5yrAI0TK7tj4s
F/3ByfUn37q+zMdTFM4bc++//VeRWp0rkukiY5NdGZmKE8FyHR0=
=XcmR
-----END PGP SIGNATURE-----
--=-=-=--
