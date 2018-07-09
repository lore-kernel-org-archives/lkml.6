Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A837AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636C2208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636C2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tripleback.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbeGIW1f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:27:35 -0400
Received: from mail.tripleback.net ([198.50.226.104]:47272 "EHLO
        mail.tripleback.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754018AbeGIW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:27:34 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 18:27:33 EDT
Received: from [192.168.0.22] (adsl-pppoe-153-252.hurontel.on.ca [216.46.153.252])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kash@tripleback.net)
        by mail.tripleback.net (Postfix) with ESMTPSA id DADDCC0CB9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 18:21:39 -0400 (EDT)
To:     linux-kernel@vger.kernel.org
From:   Kash Pande <kash@tripleback.net>
Subject: it87 removal from github pending
Openpgp: preference=signencrypt
Autocrypt: addr=kash@tripleback.net; prefer-encrypt=mutual; keydata=
 xsBNBFk4mtYBCACd55EsQx9d/7r6jPgo9+Niwyv6QBYGBc5ww9pPOBrN0oSO47Hm+oSOO5Bu
 yywIw4U5DTUtvdj7elfnsJMhunduhc2P8p7rhLxcQeFIm+yghOepkjqhxTdFLsgavmcnubxy
 Olc29b2fByIVXnFAwHypgpHEqEWTHp2cnNVOtuO9GeIr8YxB+wO4Z5rDnNnEsOuLSJq9kG9c
 uoI8RF+StEBmYVRCfELhafBlluURLRPO/Uoax8+wFyq4/d3iDVtKyrDdvxLG0aXkj3Wfc6rY
 l8trOQl1zw8dCfJMw0+LPaj2EVza1HGCdhgIrg2cS1nKNjNDnIZB/8RwBU99FIY1xoGXABEB
 AAHNO0thc2ggUGFuZGUgKEdlbmVyYXRlZCBKdW5lIDd0aCwgMjAxNykgPGthc2hAdHJpcGxl
 YmFjay5uZXQ+wsCOBBMBCAA4FiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlk4mtYCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AACgkQLHWyk7icJXiG1Af9HI1f87UPQPEpsWVHuoeMlPra
 NPrefNZ+O1vnQEdTHEQ+Mc49ozLtpdrpi0VqKYlsdVHxhY5YbzyTC2tdHtiL2LTwbnkrqKMN
 6DJSiogXFLH/q+SzXoAUxqN8rrRptVEHSYrxENt+ZN5R0A071QrURdEa2vLXicjMGitvdVcV
 pxdRLJgSqQygSlKysoQsY2vvgRujD322BEwDqgq3XWCMIo3ld/riMSCiO8ShCvmqojeWRfh2
 ComhNSzzbn2oGUceEJRJ++mv+0i1jMzO+9L5qsrYnH7KnPA1HsORqHGi7+wJdRn4zG/+g+Ey
 hoTk2WVCDC/Gp4t9CYeQOa/rC1kxm87ATQRZOJrWAQgA75dQD3FhNz1JDUuAEDRpKOJA7A1A
 t11ItkvolADQwJYtAqoMjFybAG+rN+H2+6CLFsShO2RLY8K1FJVPy31am9qeY5WWO1PhU3tg
 PHVeGOYF/mWTxNBKSwZgfWo8cOT9OcUTjTTR8z58kEcbZJ6PtiPyCsk2MKFMT+OcJ3w7GB2K
 KViN5L4f4sBOOgFZ5U+hNNcLOTmYk8ba2w0GnT4ePnidby8XStGIt1sVeNkbD2hdRUdXtpku
 OKQ2iw/j/GBo7+B7lYMBOSZaxKwpyEt7DPSJuLATSu6l16oDk4uqXulXC1td1fXfXfGLudHN
 sXUJDE/0jf2r8Mi3rPUdPn+dpwARAQABwsB2BBgBCAAgFiEE5MQWwRLWQeWW1A0MLHWyk7ic
 JXgFAlk4mtYCGwwACgkQLHWyk7icJXiv4gf7BqzcEq7IYUIMUI/ubyQuKdASfLHxbGmEJkxk
 Q7iPf38zLucS7jL3XnXrhkU4rzNneaQ0jn/bYhyo2ZDrmIloSOIYQPJTdCU53waLqbdgOSZH
 zVm7aFHVs7/C/joNxZ9Qcg75zdhAJP1bTWTBdmvofJFjwV3YXxhW9U0qIt6Dqq4IQ6TB2tzw
 bMiVH+IeWnlIwBScamT3DAXmu4CxKUpgkqmFsDL2aZve1ZUxwMwgblDZqBKdZoLJEYQ4Llf6
 JXZmkBNIuO8GA0ZGamjEOvxwn3OYPd7I2FQESawdKNAzv734vCCYELEQFP2mh04B32bEH4ei
 2oovF94E7UQCVIZg7Q==
Message-ID: <5386bafe-b431-c530-f6a4-8d2492924212@tripleback.net>
Date:   Mon, 9 Jul 2018 18:19:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kjiEbktygQThLBMUmIj6GtZueXinSyIVi"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kjiEbktygQThLBMUmIj6GtZueXinSyIVi
Content-Type: multipart/mixed; boundary="cVpGBAo5CIPetnzMOpwNT4yywQ68Z7N42";
 protected-headers="v1"
From: Kash Pande <kash@tripleback.net>
To: linux-kernel@vger.kernel.org
Message-ID: <5386bafe-b431-c530-f6a4-8d2492924212@tripleback.net>
Subject: it87 removal from github pending

--cVpGBAo5CIPetnzMOpwNT4yywQ68Z7N42
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Just thought a notice would be appropriate here that groeck has decided
to discontinue work on his it87 driver due to difficulties upstreaming
it, which is a shame, because it is the only working version of the drive=
r.


https://github.com/groeck/it87/blob/master/README


Kash Pande



--cVpGBAo5CIPetnzMOpwNT4yywQ68Z7N42--

--kjiEbktygQThLBMUmIj6GtZueXinSyIVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAltD33MACgkQLHWyk7ic
JXibBgf8Cog4NVh/O26P5auJg9pr5wrbUikXVTMsYrOU+6zr56a1jthRhIniLETk
pAtmoYh/qQXHascCI5treKDm4AagBu7yA6QEpjNmn9dTGsmWCpX7M0FBTxdAAF1T
0cX3n/b/oP3YQIkSQ+v4iJJ1rnP5SB4Nfx2qFHRpM9E7p5DZGyQJBE+UnY6zgm4Q
C8JI0Zl9cy8C4ccugI1ZZhX/Qcu6ccK1M7OzefhGkf8Ch99HZdkOascNBkKGNsi9
ZLk82cPEwyJ03334HUdyvmA2vYvkxK3NlHC/GkWEdAUja3+TqEd7AX5lkZZgMLqW
YKixbr59ocEzf3rrkc3Y0c6/3gNzgA==
=RT9F
-----END PGP SIGNATURE-----

--kjiEbktygQThLBMUmIj6GtZueXinSyIVi--
