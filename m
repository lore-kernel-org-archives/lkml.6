Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F142C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C5820821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfBEJTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:19:22 -0500
Received: from brunni.mail.netestate.de ([81.209.177.48]:47951 "EHLO
        brunni.mail.netestate.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfBEJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:19:21 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 04:19:20 EST
Received: (qmail 9775 invoked from network); 5 Feb 2019 09:12:40 -0000
Received: from localhost.netestate.de (HELO fiano.netestate.de) (127.0.0.1)
  by localhost.netestate.de with ESMTP; 5 Feb 2019 09:12:40 -0000
Received: from fiano.netestate.de (81.209.177.7)
  by brunni.mail.netestate.de with SMTP via TCP; Tue, 05 Feb 2019 10:12:40 +0100
Received: (qmail 3698 invoked by uid 503); 5 Feb 2019 09:12:40 -0000
Date:   Tue, 5 Feb 2019 10:12:40 +0100
From:   Michael Brunnbauer <brunni@netestate.de>
To:     linux-kernel@vger.kernel.org
Subject: Kernel panics with recent 4.9 Kernels
Message-ID: <20190205091239.GA3687@netestate.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hi all,

with Kernel 4.9.150, I sometimes have "kernel panic - not syncing: Fatal=20
exception in interrupt" on two different servers. Dunno how to reproduce but
may be connected to high network traffic. Find screenshots, config.txt and
boot.msg here: https://www.netestate.de/kernel_panic/

cu,
brunni

--=20
++  Michael Brunnbauer
++  netEstate GmbH
++  Geisenhausener Stra=DFe 11a
++  81379 M=FCnchen
++  Tel +49 89 32 19 77 80
++  Fax +49 89 32 19 77 89=20
++  E-Mail brunni@netestate.de
++  https://www.netestate.de/
++
++  Sitz: M=FCnchen, HRB Nr.142452 (Handelsregister B M=FCnchen)
++  USt-IdNr. DE221033342
++  Gesch=E4ftsf=FChrer: Michael Brunnbauer, Franz Brunnbauer
++  Prokurist: Dipl. Kfm. (Univ.) Markus Hendel

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlxZU4cACgkQvo+oDi22HrnpzgCdGvJiavfz2Z4H/a7J9IdrKoY2
4YQAoMPvcwLE8iXDbE2PTpVvq2X2iHez
=4rrq
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
