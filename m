Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C405C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072B223C27
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072B223C27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:45:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54697 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752381AbeGDPpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:45:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E9F5C207F4; Wed,  4 Jul 2018 17:44:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 28F39208F8;
        Wed,  4 Jul 2018 17:44:36 +0200 (CEST)
Date:   Wed, 4 Jul 2018 17:44:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Remove VLA usage
Message-ID: <20180704154437.dcjsghcsxikry2xn@flea>
References: <20180629184740.GA37415@beast>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6cnkb6ttbdrggde4"
Content-Disposition: inline
In-Reply-To: <20180629184740.GA37415@beast>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6cnkb6ttbdrggde4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 11:47:40AM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a kmalloc allocation and moves all the size calculations
> to the start to do an allocation. If an upper bounds on the mode timing
> calculations could be determined, a fixed stack size could be used instea=
d.
>=20
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXyd=
AacU1RqZWA@mail.gmail.com
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6cnkb6ttbdrggde4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls862QACgkQ0rTAlCFN
r3TsfA/9GVSjD5IaV2dVYCweQVZcLHr69ItGsCpSK7tgEl5rlvclq4pPnZP880UN
Z0iV8Y7sjQQxZ5ytIVLkF6JQ5OJ58K8hMJ1EAaeg4lHpMUJ3+yWbkQSSYNgDJzV0
bCUKkoXD/FdtbuSH0EBad9A/HLke10Li+Pta7oY3rv2DPIpdd5kXqEFP3MydwaWq
uEUmZ3FGDCI4Sb10ggsCAZdSNl6a6KwpPLeDouudVlGbkQ2IPn4qfFn63nIAzdq2
GeyOoAQCfln6pzei8MkYPpWmGDEivO0sPfnuy0BiKc6VdQNjNpfcBbxI5Nktmh6F
w4YZhPR76JgUYufZxmrkAte6s0e6fheoNZ/7wrneqCQtReEjzdGdTrIKyurQyZ8f
6RG+dIal3zo2U2mAFNpBUdZ0fI8VDLEUilTUDVk69sd04dEwK0+0TCFKdDpANCIs
ZtF3lYWOhLAjntPUT+O6l4yUQjaVCAOPZ0BVlD5DWPw8+Et626iu1Z/VxXgs+0bw
wTRDZ7GwUwQNe4UxQekLskm7POIU9LIqqR3ZCSDD68eWc5LHRUJDpEvqFcVgok59
oNbnpdtto8duNak/8a+61nDn7AKvYOSFij1jYf0NAuqjBpOKRjmX+4EsQf2/1Ujk
DlF+43vt/w0msnoW5u4s55SKfmWCFO/IM7XWPqaKK/a/reDljdQ=
=g9vE
-----END PGP SIGNATURE-----

--6cnkb6ttbdrggde4--
