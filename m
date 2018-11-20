Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4C9C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34C206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F34C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeKUEWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52174 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbeKUEWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:25 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPABp-0006qy-9Q; Tue, 20 Nov 2018 17:51:57 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPABp-0003q9-2G; Tue, 20 Nov 2018 17:51:57 +0000
Message-ID: <41d354185275e1043cb3cea1b68192b6733d9a9e.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 151/366] MIPS: BCM47XX: Enable 74K Core
 ExternalSync for PCIe erratum
From:   Ben Hutchings <ben@decadent.org.uk>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        James Hogan <jhogan@kernel.org>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Date:   Tue, 20 Nov 2018 17:51:52 +0000
In-Reply-To: <CACna6rx3LPxuYKtJOmZP-Pt-HMAhh99qHVsxVFv=XoPuJ1azbw@mail.gmail.com>
References: <lsq.1541965744.387173642@decadent.org.uk>
         <lsq.1541965745.189575243@decadent.org.uk>
         <CACna6rx3LPxuYKtJOmZP-Pt-HMAhh99qHVsxVFv=XoPuJ1azbw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Yj6Ow3Ai7w20I1uGxoH1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Yj6Ow3Ai7w20I1uGxoH1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-11-11 at 21:17 +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> On Sun, 11 Nov 2018 at 21:05, Ben Hutchings <ben@decadent.org.uk> wrote:
> > 3.16.61-rc1 review patch.  If anyone has any objections, please let me =
know.
>=20
> Nack. This patch has caused a regression and had to be reverted.
> Please check upstream repository for a revert (search git log for
> 2a027b47dba6).

I've dropped this from the queue, thanks.

Ben.

--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.



--=-Yj6Ow3Ai7w20I1uGxoH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlv0SbgACgkQ57/I7JWG
EQmqbxAAmsbCCoAcC55mud5vEZBf+MNx838Wp88wztHpkS9FTmFaA28MZvOiKxIF
e5+knPBk7mp5IovgpvM1v67+sUIrQzM6Sy4y3vCCjmAdNeI/BdqWlvXKfaolXRBT
4Dlp+x8uCJvCHzkWwRfetgb9U5rdT/LAw/END+Rn8UumieHCtStO6hjL2cAX/x56
xGrzbXoBDGELepudDZTqUwUg2lgEO5Sifktq4aeKmvXE/8KJPAlmIu5J4qY7/fcl
43LGez/+hZEevHhYzssEMxy/vJ+EOzYhin78NH37njIRRKYnIl7ZACKxPaRa2gpw
0lddh03MIEXs9wXo+M0EpGOXdG9aUX90iGceihC2IRb4PRnQTQxz2BGU81q6/T60
IMiybKIC58QZV6JGYkyNsla8b6yXZ8endu4/jRzOlWkRe6MbvipL2csKLALmFwdW
KLhtRtWfLaQrDnaC3pWNM+sGl9Q7/klljG+XgKgTCPWSOGYYZl3Fbq/5Rkji0d+r
CgdE5fLptlxhd7l8524oCIwNS9zgtLWRJ311wkXs94xFLLz3Ql3f50rOo6OhdQgB
Wqd4l0MByZRgTlxNrppg2JrlL3l6PpXRDg+ngDDBcA1eDdj9kNleXYVnwyuGpDHq
nuIYg7O9SiPxa5oXzKCoZaCYhvJCvG/dWayKD/cgHlEl+Y9RNgI=
=Fc2q
-----END PGP SIGNATURE-----

--=-Yj6Ow3Ai7w20I1uGxoH1--
