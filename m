Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C522C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B15208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B15208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeLFNIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:08:52 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43608 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:08:52 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 439bX117TLz1r8W4;
        Thu,  6 Dec 2018 14:08:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 439bX05zPYz1qst5;
        Thu,  6 Dec 2018 14:08:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id xDE9ppMOprPV; Thu,  6 Dec 2018 14:08:47 +0100 (CET)
X-Auth-Info: NojaainKu6o2YUrIUvBLiPLKL4pPpo1gPXk7DbiLVlY=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  6 Dec 2018 14:08:47 +0100 (CET)
Date:   Thu, 6 Dec 2018 14:08:40 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device
 (vf610 based)
Message-ID: <20181206140840.53d49cd6@jawa>
In-Reply-To: <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
References: <20180921152726.31742-1-lukma@denx.de>
        <20181009105028.17971-1-lukma@denx.de>
        <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
        <20181206092255.2359f7e6@jawa>
        <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> On Thu, Dec 6, 2018 at 6:23 AM Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > At the time of development - I've checked my NXP related patches
> > with W=3D1 passed to make. No warnings observed then. =20
>=20
> In linux-next the warning happens without W=3D1.

I will check this latter this week...


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwJH1gACgkQAR8vZIA0
zr2bcgf/ZQO9ux6TS1P3o6t1LwXRUeqAlF2ZiRhx85OpxJ2V2UyBgX/QYFTcFCOU
1PfoE3JHZiHWlenl5Nk92994ryNWuaqrPkQN1UfEausOzdiSpjZ8GAFAPlPWz8C8
41f7StzyUj1a5/UPK6uCc0BeLT3Zj2SaI0fz6VWuuTwzdlETlCFyHze/lDjkuKI/
ZzA0B5dPZENo/n4IkFT5j19TRv4ToOU3AV9cHdoFNslEd4dk5+erUJ8BwaScuZO7
Bgrf7TRKJmJiLXmt3otChel+1+J2+J1ZST4PC14+aTE8MKPJN78jJEPRAMVzV4Ts
jsUkz5qdGCAEkCdLg0g9bpzkr2DJiQ==
=D1rb
-----END PGP SIGNATURE-----

--Sig_/1FXnAUr3DtaEX/uxZ1vwUpQ--
