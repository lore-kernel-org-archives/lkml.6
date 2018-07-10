Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBA1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB516208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwWM3OOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB516208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934575AbeGJQUF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934326AbeGJQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:20:04 -0400
Received: from mail.kernel.org (host-091-097-077-058.ewe-ip-backbone.de [91.97.77.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B336E208EB;
        Tue, 10 Jul 2018 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531239604;
        bh=qrdCxxznwAdgUd6NVOxRvYyvS/EMmoU/W39/khvewNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwWM3OOWBhtzaOaXNKPgkddhBy5KL2UV+NtKQkChFIl8bNsf4haLTHtGSQ5Rs81aK
         G9ZsV95GtJiuFskfQfiHqhFMQ4LIU8FRWK5tEhHYnCfvYr8n667vISMkQ7r8H0N+Dm
         JGnSRJ/XnlFL9Z7c5oOfWBBU4pGIt5rrkWlcFPXM=
Date:   Tue, 10 Jul 2018 18:20:01 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Peter Senna Tschudin <peter.senna@gmail.com>
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        martin.donnelly@ge.com, martyn.welch@collabora.co.uk
Subject: Re: [PATCH] MAINTAINERS: Update E-mail address
Message-ID: <20180710162001.3f7w75u7uxqdbdjl@earth.universe>
References: <20180710144702.1308-1-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vha43ytjlgktw3nn"
Content-Disposition: inline
In-Reply-To: <20180710144702.1308-1-peter.senna@gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vha43ytjlgktw3nn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, Jul 10, 2018 at 04:47:02PM +0200, Peter Senna Tschudin wrote:
> Update my E-mail address on MAINTAINERS file.
>=20
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a29d10f25e27..3204ea8c2a8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9133,7 +9133,7 @@ S:	Maintained
>  F:	drivers/usb/mtu3/
> =20
>  MEGACHIPS STDPXXXX-GE-B850V3-FW LVDS/DP++ BRIDGES
> -M:	Peter Senna Tschudin <peter.senna@collabora.com>
> +M:	Peter Senna Tschudin <peter.senna@gmail.com>
>  M:	Martin Donnelly <martin.donnelly@ge.com>
>  M:	Martyn Welch <martyn.welch@collabora.co.uk>
>  S:	Maintained
> --=20
> 2.17.1
>=20

--vha43ytjlgktw3nn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltE3LEACgkQ2O7X88g7
+potIg//TCOku765plrLIeX76G6LgxhYwRxwwdi9eS/LZC4glmJBMnTueKPNuPx6
ezHdI90aKjJF4dqwn0ep3l8L0NB0O0HXOAeTqkIHEfrTklWhucdN1nYke/5pXS4d
lF/AbLwhHLVexdVD1mop2hTEeWWbIs50TAoJTRos0bZO+54GYyt0aeYMDMaYGxFD
wrAGG6MAEim4NFtxdWn6ELN1HsvMbvmr3n0RHenVrSjHIBmxMEfTHCG3CC/NpShf
Kye4DO2ZSb9X+b6HtkdeiKC6toXrSnSl+0cizm/1RT0dPlaRY0zp9N5d6TNomc8i
v2by44lJc9mwJmNCeyqfoLK0kDZJB/o2AEikDMb68dpK/M8gDBctC5hS6W/M0O8s
eKHlsYm9BrqkOL6T5KOG4GV4wu+W4zJpkIigQLM+B5vA/wK/0A0i6Rt5i9oAeenC
IXEbgAd1cXFTbMveSOO41k02bzj4KWjOVjrcZLRR51v+WKJGosIfksQUiZTZ3PX+
vauxe2P1kpQCgNTeKKtl7XCxWmZj+WHoiiokxIxF9eHkQjOVUDGEiNDg1ynhb1sG
8xKMdQUNz31Zb7W4Jbqfh4h5fQGwOxo+MVwBhhdVKZaV4+8ZWsW9QAYTiGM5Zogy
ZPMs+JE02lMVw0M6IFJ5kBrqF7g6jKVg6gFDeiz4gNCZSH0U1mU=
=86Uf
-----END PGP SIGNATURE-----

--vha43ytjlgktw3nn--
