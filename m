Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9052080D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="a/kMSdFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfBALeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:34:11 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:45720 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfBALeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5QEjsZ7bp0bCsQ7mzRBgqkroPUTqexM9yWImyGsPDtg=; b=a/kMSdFnP2dda1J11imYpdJGx
        sPKvAPAYeMPkP3cOwwkzrXzDm5QYYanFYdKUzzJmBabkGAbMazTa1fv1EUVKE9jS9G6sptiUnyr/V
        AFEs0e6V/dcWsdT2OSAhYoyzYUT3WIKg7g5zF3bvpk7YqqZhxmsu1RVjIxTcMeJ+YUtaI=;
Received: from [46.183.103.8] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpX54-0006wZ-RR; Fri, 01 Feb 2019 12:34:02 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpX4u-0004e1-TP; Fri, 01 Feb 2019 12:33:49 +0100
Date:   Fri, 1 Feb 2019 12:33:40 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH 0/2] drm/omap: panel-tpo-td028ttec1: add backlight
 support
Message-ID: <20190201123340.05cd385c@kemnade.info>
In-Reply-To: <20190119182131.9341-1-andreas@kemnade.info>
References: <20190119182131.9341-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TK.FMOv4Uh3fx1=dIZnmILX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TK.FMOv4Uh3fx1=dIZnmILX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

ping

On Sat, 19 Jan 2019 19:21:29 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> This panel has a backlight, so add a property describing that and
> add the code to use that.
> This makes things like xset dpms force off
> also turn off the backlight, so we do not need to rely on additional
> userspace programs to do that.
>=20
> Andreas Kemnade (2):
>   drm/omap: panel-tpo-td028ttec1: add backlight support
>   dt-bindings: panel: td028ttec1: add backlight property
>=20
>  .../bindings/display/panel/tpo,td028ttec1.txt          |  2 ++
>  .../gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c    | 18 ++++++++++++=
+++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.11.0
>=20
>=20

--Sig_/TK.FMOv4Uh3fx1=dIZnmILX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxULpQACgkQl4jFM1s/
ye+p3Q/+KX4oNY/BOMP8qZPMRZNNpS0XMyxHBLEsippvX+FHxArZyNUNoddq6L9K
2RMLFkZfSKUwjZprXh2U/6H+qqkmyvrZPR74XMx5ZzEN/h8MQPHko9aYXAYYg6Oe
hxkMNhSKHlFRowOk4h4rd65JCjYxDIQwrfDyHcDxeushjgsRFFugGsly1zXnAXCj
LttvHwFpKe8tECx5DkwVEGH0tXUhBG78xH/GNK77/Wyqm000U9qZbnRkp/hBg8d+
Iz3BvA838TpfPPEW99eoTqjJjkHDZeiGejFX2979vgGvF+o1F44Atk5PMqAeXbAz
sP7sbxhHYbZqJNqbBwBuFqREQjLzBDXATNjY71iyYFbR9j3N5hqFxeV+KaWPqC64
fpe44CEiO0jEwCleDyrpHA6YzYx0FjphNlFW7LymfoY8sMfOwg5LCXesMtpvXNFk
ny9JnR7GvTtvpMlMO5vvSO9p3jv/p+AQuSUbZuQ9R0fNfbukM79u5x4BBo8MmtOW
fpy/ags2TSLnr8hxBWLAMuAVb3G/qL16QwMwKYdw0RLsopQTSoSxspzvU9H6OWHs
wLsMoVrU5JP9NmVTc6hde7cjih1nW6wEZ1nT7wPbVvDcS0m214Fz97LKmkIFHIdA
oP85NiQrvwb62gxumGpaTZdk4UssesUoDVb7KSiaW6+xsdmZ/vw=
=duFK
-----END PGP SIGNATURE-----

--Sig_/TK.FMOv4Uh3fx1=dIZnmILX--
