Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E5C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDD6206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDD6206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeLDXEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:04:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:52592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbeLDXEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:04:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FCFEADEF;
        Tue,  4 Dec 2018 23:04:19 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 05 Dec 2018 10:04:13 +1100
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Documentation: path-lookup - update externel refs
In-Reply-To: <87sgzc7v50.fsf@notabene.neil.brown.name>
References: <87k1l9dgx9.fsf@notabene.neil.brown.name> <87sgzc7v50.fsf@notabene.neil.brown.name>
Message-ID: <87pnug7v2q.fsf@notabene.neil.brown.name>
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


As gmane is no longer reliable, use lkml.org

Section numbers used by the open group seem to have changed!

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 Documentation/filesystems/path-lookup.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/file=
systems/path-lookup.rst
index bba1fef066a1..c5987d1c5fc7 100644
=2D-- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -68,7 +68,7 @@ pathname that is just slashes have a final component.  If=
 it does
 exist, it could be "``.``" or "``..``" which are handled quite differently
 from other components.
=20
=2D.. _POSIX: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_c=
hap04.html#tag_04_12
+.. _POSIX: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_cha=
p04.html#tag_04_13
=20
 If a pathname ends with a slash, such as "``/tmp/foo/``" it might be
 tempting to consider that to have an empty final component.  In many
@@ -964,7 +964,7 @@ successfully - the error ``ELOOP`` must be returned.  L=
oops can be
 detected without imposing limits, but limits are the simplest solution
 and, given the second reason for restriction, quite sufficient.
=20
=2D.. _outlined recently: http://thread.gmane.org/gmane.linux.kernel/193439=
0/focus=3D1934550
+.. _outlined recently: https://lkml.org/lkml/2015/4/20/644
=20
 The second reason was `outlined recently`_ by Linus:
=20
@@ -1249,7 +1249,7 @@ Symlinks are different it seems.  Both reading a syml=
ink (with ``readlink()``)
 and looking up a symlink on the way to some other destination can
 update the atime on that symlink.
=20
=2D.. _clearest statement: http://pubs.opengroup.org/onlinepubs/9699919799/=
basedefs/V1_chap04.html#tag_04_08
+.. _clearest statement: http://pubs.opengroup.org/onlinepubs/9699919799/ba=
sedefs/V1_chap04.html#tag_04_09
=20
 It is not clear why this is the case; POSIX has little to say on the
 subject.  The `clearest statement`_ is that, if a particular implementation
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwHB+4ACgkQOeye3VZi
gblFkhAAoNIn+2RUb3Z5GqtVaDGyo5DakKZ0UhUrFIBHuhVVK6Icjh6SsYt9Xk3G
JQiLlmhxN1ky3HA8lqoviG0FmzjV6wZNhZO0HMCkRFFGeRpUv/RcsOAXh407m5Ub
mFTsB8/BLmEi5H1oo1vq8bobmqcJNSaPElJ0cnoz6u7lbui3TIQqAnfAcRBtYJF1
nW8FSsW0P3f2/S0xv69BIybnthg0UDeQ1fQXpcVA+/1+yIcrgyCSg/4Wx/FJsraW
TXnNNsLy96KIqU9o7X6L2qA9gLa52DMKd/toE5MFXIup835Hh2VIIXMpt4Ar6X16
dFoE7uuq+puESQV49HLXZO4aFX551gysF1WT7eCj6jxAkMp5g458OyYU6vcDeMba
4KnxK//kkKFWBmKhLZqD+22kY9bTBXLYF59KYWE8mYRDDKJoJJWxmjd9BmjZgpgg
5G3LB0nYVPWZRyzIdf/0dqz6pdt2tlpD7JTz15sGQ4zXoHWjpyPMZhRQZjVAJACq
wuYD1N868gNjO+8ELGduP7lMJfqs8fc1GqOosAeJvEf7fGjicJIKrYZ88TbNRYpR
C6VEJWWXLXRdy/wzR5j4cznoc7PWAuTn0NS9Z0mDwvpUc9odKBnpkzBz90bwGfGD
oQ2NqHhmqEyakF87tRLtojczccJjQvlUtWuQnjXZGfyEXkmtLq8=
=V4j8
-----END PGP SIGNATURE-----
--=-=-=--
