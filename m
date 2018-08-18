Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A9C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0773721746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0773721746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeHRWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 18:02:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59740 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbeHRWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 18:02:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fr6Ld-0005tr-Rk; Sat, 18 Aug 2018 19:53:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fr6LY-0005Sq-M5; Sat, 18 Aug 2018 19:53:12 +0100
Message-ID: <7b13f62636d1f0547287cfe0a6135651eba194c1.camel@decadent.org.uk>
Subject: Re: Current LTS and their EOL
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 18 Aug 2018 19:52:58 +0100
In-Reply-To: <20180817161727.GA24945@kroah.com>
References: <20180817154006.GA3725@intel.com>
         <20180817161727.GA24945@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-5UBCvE7r90rkkC0ZzO/y"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5UBCvE7r90rkkC0ZzO/y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-17 at 23:48 +0100, Greg KH wrote:
> On Fri, Aug 17, 2018 at 08:40:06AM -0700, Rodrigo Vivi wrote:
> > Hi Greg, Ben, and all
> >=20
> > Is https://www.kernel.org/category/releases.html updated in terms of EO=
L?
>=20
> As of right now, for the kernels I maintain, yes, it is correct.
>=20
> > Some news out of Linaro conference [2] generated a lot of doubts and qu=
estions
> > around.
> >=20
> > Specially because on the way it was stated by the news 3.16 wouldn't be=
 active
> > anymore. So I'm not sure about the news, but I'd like confirmation from=
 you about
> > expected EOL.
>=20
> Linaro has nothing to do with the 3.16 kernel, so why are you confusing
> that with what was announced at that conference, which was about the 4.4
> kernel tree?

The article says that other longterm branches are only supported for 2
years - which has been your usual practice, but obviously doesn't
reflect what all stable maintainers have done.

I try to ensure that every stable branch used in a Debian release is
maintained for the lifetime of that Debian release.  That means 5-6
years after the initial release of the kernel version.  So far that has
included 2.6.32 (maintained by Willy Tarreau), 3.2 and 3.16 (maintained
by me).

In the latest release we used Linux 4.9 which currently has a stated
EOL of 2019.  But I'm prepared to take on maintenance from that point
until June 2022.  Greg, is that OK with you and should the EOL be
updated on that basis?

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC



--=-5UBCvE7r90rkkC0ZzO/y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlt4awsACgkQ57/I7JWG
EQnf7RAApziWSvYy83bttdaX9dw4LGPPNWlmkbg6vPHn8ifLnbqO8S7JG3FK4xvb
nuR/Rb1v6X6TeEHxXItBnVoZpNpDWmrHBouzdKTByIBOAy1+2IflX7pmuyFdf9On
ZPpIK4d+RLkNhXrWXHXGqoU3pzpb2cISAn0nGfbw7jV0dj8Q9Nu+Nb6AtcMqBWHD
h4Pndt9vBWH1/PAtd3UQjE/W8ww6tImfpf/6VADuHwoP4JfU4TD/IWrk7P2hyvt3
DTLPOFszzuBpePSrg9cgj7CCgVE7cNk/AM8i58xSaJmWRecNc8Ij7KgZEEYzRjRl
1+oCxRqqc3jqlIX9v2a7+IEefIooun73U+QogsMSkzsHAg4yIMrRPFpdHyMX7enU
k69s+PLzeqixzfMtQSZpwPSAXYxYg852oXTovdhgFU+C4WLFr93JqMMAfoOTamBR
b6XjvTtxNjQhp1qA7pkC69yX3U/T93R5JeSgv9mgdImzVLs/egWEju6f6MSpHJET
Vdhhq9QAeQoWTtw1QQiT7as6rtsnWpmHl7AyhKhOoDMfW2sPVL+hlYi6RH9J/VIM
4OTWCGuJcWR+gpA7+z8XvFLtyslt1jcbBNJHOOY9fpk2QGi0xqBAms+ml5NJQqQ+
zS2aVaBVaaPWRVw2LBgzf7xisvuZHLN2b1RwcGZmGGt2uqAAKxg=
=1s9P
-----END PGP SIGNATURE-----

--=-5UBCvE7r90rkkC0ZzO/y--
