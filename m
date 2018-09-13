Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2AC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7660720882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7660720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIMRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:42:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35094 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbeIMRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:42:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g0QnY-0003My-Oh; Thu, 13 Sep 2018 13:32:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g0QnY-0002XH-Cg; Thu, 13 Sep 2018 13:32:40 +0100
Message-ID: <eb1fe15c9ced6950d6a38c901278b8196ae4938d.camel@decadent.org.uk>
Subject: Re: 4.19-rc3: bindeb-pkg target is failing on ppc64
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 13:32:35 +0100
In-Reply-To: <CALjTZvb4hOY_Hew-jEUtpyhkGbmh4Tgb0doPC6EaGtz_rMGt7A@mail.gmail.com>
References: <CALjTZvb4hOY_Hew-jEUtpyhkGbmh4Tgb0doPC6EaGtz_rMGt7A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-4saDnkeQRwr71nfUjRPF"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4saDnkeQRwr71nfUjRPF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-09-11 at 15:58 +0100, Rui Salvaterra wrote:
> Greetings! I'm having trouble building the kernel on my ppc64 machine
> (Power Mac G5) running Debian Sid. The make bindeb-pkg target is failing
> ever since 4.19-rc1. Is this a known issue? If not, let me know if you ne=
ed
> anything else in order to help debug this. Thanks in advance!

It sounds like you don't actually have a ppc64 installation, but a
powerpc installation with a 64-bit kernel.  In that case you will now
need to add ppc64 as a secondary architecture by running:

    dpkg --add-architecture ppc64

If that doesn't help, please send the error messages you're getting.

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.



--=-4saDnkeQRwr71nfUjRPF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAluaWOQACgkQ57/I7JWG
EQllCg/+If7rEF/SFCUdHE9Lo4cXEXwjzd0zkECbnOoM091fotF1hd0H6vy0Vh2R
Rxwmz+2g88hNbgaYMMEDhNhxLBTwqVnoalFPWUdRgW5J56rKUpJYYg4YQ7BRvpth
yyMCub2zPrtq4mtpSfhYwOEtD1R83FgvV9mkCm6jUgpIGo3KbHo5H3EiKEuouwok
vX3IoI2l33Dr92VEifyy/NOqKWl/JlvO2sNOpo6Zs4uMQaqZY5bi0ulaerVN45Sd
Amel1q/G5p9HzpdkzTRfBki/348y7OfYYQy7Ad0I/NgX0Cs8Q8wDc6/T4ltph3L+
mo/wwhOG+UbTbnSCiLTBZmdkGvMBe5FCkSLxPwwOrvMghAnG8xgh1ejZsYec0URH
4B0hIYn65KfQpNr1rhEW/ukDGxfagmtkQdTN/mPueeZov1mG3zrBGNBfUONmfpn3
AsQAHEeB5Q0WbUeFIZ0aI4alhJz+NLgDZzMBtXVtDbgEw0qZGHWGs379pJMhCMEv
Q4dzj0xrz5ZXY2zkF5wHm0KBap9eHQvHbv3t+yEcTP/MdNeX/X/5bRBs5fjIYEOQ
ee3jXPuuywa0NB1GRHK66uCRU/aHPpJ+tOuCwuudvPxw45qij/MEVgVfVaxU0Bv7
5pmqHiuKvLCm6C5OQcwJZ1W0Evx2NjJzyMQsT6c5MBTWfMDKQnI=
=a0gt
-----END PGP SIGNATURE-----

--=-4saDnkeQRwr71nfUjRPF--
