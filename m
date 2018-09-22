Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B819ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02A42150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02A42150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIWC6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:58:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47639 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbeIWC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:58:46 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3p48-0004F2-CH; Sat, 22 Sep 2018 22:03:48 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3p43-0003Zy-3L; Sat, 22 Sep 2018 22:03:43 +0100
Message-ID: <8818ebb8014a4dcabd5ea45fd9eda6c134f7d799.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 00/63] 3.16.58-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Sat, 22 Sep 2018 22:03:35 +0100
In-Reply-To: <3c4507c7-d805-5895-e634-09e7ba4e2c4f@roeck-us.net>
References: <lsq.1537575341.194909669@decadent.org.uk>
         <3c4507c7-d805-5895-e634-09e7ba4e2c4f@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-xSlCntg7590pOmQtcO/A"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xSlCntg7590pOmQtcO/A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-09-22 at 05:28 -0700, Guenter Roeck wrote:
> On 09/21/2018 05:15 PM, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.58 release.
> > There are 63 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Mon Sep 24 00:15:41 UTC 2018.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 139 pass: 139 fail: 0
> Qemu test results:
> 	total: 217 pass: 217 fail: 0
>=20
> Details are available at https://kerneltests.org/builders/.

Thanks for checking.

Ben.

--=20
Ben Hutchings
Any sufficiently advanced bug is indistinguishable from a feature.



--=-xSlCntg7590pOmQtcO/A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlumricACgkQ57/I7JWG
EQkUCw/+Ppuj/Bla55QIeiRXI7c0QTljYTgjdzPyN6icuOl1DC+mz8VhmfuDc24e
bCOu43tDJ+LoMrWT8bGOXAppZFx8R4fF7XQfOHOUCIYYG+pOKo+BoHsoZ2YsZZjc
zvoL91BzzvKQca0WiS8MhkPhUio9btmXH02Tjt1FSw+G0Y5NvXJFHjKJ4hoEOubK
ShkA/ejMQOV37lA9IgWyoOXYCR/OZlN5O1Aiq2gyrinMQ+R/68mUMSW4xzVx4dVJ
+SEhe78yqQnwFb8Cyx+VNCuctJKX65WCMRt+8SqMkUdbRbxjZ8/hGFDdj5DlRUr3
wyYm82ka8iUDPOjt8d8g9i1diIgsnwKOqrRlHkAhVXygviMZtdGIyBi2sH+AILJa
OIPo+2O/8IDh4cTd8Lti+OaprEQesDaGyNwMOiQGlw4c1VIH7zUJzNA0W11bLJcY
k7VIFaIjSJlYLDwL+FwUyfRLQLZuP2cnrdHScSU24IHH1klDiogEWPLG5PC6ing4
miHnoOWfmhJlYf8lgq7e1VWU+VyzNlCzIO0cUiVdcxNmiKh7dv4oBZIdCRxwMQOk
BBzyEjI2Qz7rY8pyGoui/7SIdaaDZK0+uXonrsEeNChdfzcgO4S7k033ramIHYky
WBPIolnqpae6pTlAcDg6jFK+xpjA2tu460tFjy0EPl9F6woGzfs=
=mZ1y
-----END PGP SIGNATURE-----

--=-xSlCntg7590pOmQtcO/A--
