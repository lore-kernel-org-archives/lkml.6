Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B68ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD7320836
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD7320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJVGuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 02:50:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41158 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbeJVGuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 02:50:15 -0400
Received: from 92.40.249.44.threembb.co.uk ([92.40.249.44] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gEMIe-000623-Mj; Sun, 21 Oct 2018 23:34:20 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gEMIW-0003GH-Bu; Sun, 21 Oct 2018 23:34:12 +0100
Message-ID: <e699e2b61cea46d0129972ead80e3477ef9325a5.camel@decadent.org.uk>
Subject: Re: Reiser4 enhanced Debian 9.x Linux 4.18.xy series hung.
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Metztli Information Technology <jose.r.r@metztli.com>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 21 Oct 2018 23:34:07 +0100
In-Reply-To: <20181021122216.84B20292433F@huitzilopochtli.metztli-it.com>
References: <20181021122216.84B20292433F@huitzilopochtli.metztli-it.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-zCpi+KzoErus3IXTogdq"
User-Agent: Evolution 3.30.0-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 92.40.249.44
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zCpi+KzoErus3IXTogdq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-10-21 at 05:22 -0700, Metztli Information Technology
wrote:
> Niltze, all-
>=20
> Ever since I build reiser4 -patched [1] Linux kernel 4.18.xy
> iterations I have had kernel hanging issues --which manifest
> themselves after considerable load and/or multitasking in my local
> development machine *and* in an vm instance running in Google Compute
> Engine (GCE).
[...]

Please keep debian-kernel out of this.  We have nothing to do with any
Reiser4 stuff.

Ben.

--=20
Ben Hutchings
Knowledge is power.  France is bacon.



--=-zCpi+KzoErus3IXTogdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvM/t8ACgkQ57/I7JWG
EQlaVw//R8iCp66NBncd2r1UOuOIHvab4Y8Yo7YToYGb+1UkBh20qkOnJZrhi5+/
+kDfHBnI1k+iuk74nLgxJB/bf7yLf6XMPXDCsB40KVXxHmGbDwoa7e2DQq1OEzZR
Zn/04Ck0C1z3PDpvtdL6FjYF2Z2pzVP8lOZrXlxaQTh3TWIgFoCQ/yeR6VEGszWk
7JSvL2aTANWrCtBlwhHjAn4JeVnh9TOuTVxx3l1s2lSGWh+TbtTpduOcI1bRSlgc
3VGod4XPoSWXboma1Ca7GQPDJqKwjjzreMMQll3Cm6W2DKgWWncV8ou2DB4+jmZG
tTZNT7TIOVRoHe//fIstXo4R7KcMK73NhoOs88k+g+Sn5ABXqWK0l9zdl0itzyxy
EfbUM276mHJnWdtYTcP4Ph8nfaKvw8EfEqtCHrj9m+LzYBbCKoVp+qK+pscLR4Rz
9TRRs3f/gw9CeiCyPGySsX0hjy/wjikC8Nqca37Sm07PwokS6B6xFbmc515gNErt
yqEgbZvvCFMLdu0w2pSEFIxqRVLFaiXlm5jB87shac6e65J1i7fj9nSWHPz6ac76
CP4YCqcWMDZtBNIHDL5ynmmmBA82W4Mk8GgOzoHuAdomkTA0T+jxcEaIRWdV7/ZF
qQE3WtZrZIYCVnTCNM6s7baxp1V2eMwO8YswjE1JnzjrypE/f1E=
=8u2v
-----END PGP SIGNATURE-----

--=-zCpi+KzoErus3IXTogdq--
