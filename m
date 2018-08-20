Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764DFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A6208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3A6208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeHTUIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:08:17 -0400
Received: from sauhun.de ([88.99.104.3]:60638 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTUIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:17 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id 21B9D2D5441;
        Mon, 20 Aug 2018 18:51:52 +0200 (CEST)
Date:   Mon, 20 Aug 2018 18:51:51 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: Add r8a774a1 support
Message-ID: <20180820165151.3y4lvkmrqmxvvac5@ninjato>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nfcgs3n53von3wrt"
Content-Disposition: inline
In-Reply-To: <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nfcgs3n53von3wrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 01:34:34PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nfcgs3n53von3wrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt68acACgkQFA3kzBSg
KbZ35g//UOlA9RJRNyNuI9nn+G62ljoELZqoJIYjrOjbmUWGDg3Xs2nK+L/6op8H
hQ2wUjkhAKQft8lBHXrrKaHRj7fYdWa/G0qsBpg5CNkc07YJ6Uf+eXIi/4SxhtCn
uaNVgJvj1RPumLDTJJF/5XEIOqyl+InUigFWqarHTVk3IVez3+CufiPTjWxWEY+3
xaf4HgjyDfapvVedlBts8pQTLCOX2ezJcf2yw8YYZOs7a8M1YAIl1KIxhXzQxllB
BtFYcbShUGqp3j0Gd7ENZkEFzYJimChJYkBjACnElfDkHS4HmlQDJd8+ww2j8E/I
GHjQR0RfaZO3aVrFAGMAPYLqdRtFbYcv5dcvrSplUPm9X3GXkGRn9fjQIBC+vyvy
BtqK8fRxoJQP2k4N/lgCyv6ZeAT+4zsl39jcg31W1A1HVrdSo9vnI3bFYiS4Toxu
1ZuFADKcjNLA36MnUTgpYLIij9nip0jua4uwPTOCWFBtU46V7bK0nu6sFz6u799B
eb5X3/1DX4qN8EbrzXhYcnsu2MO3rzpbUZrwEBd6qPy/zDVphBFiz8oC/z491L1i
/snQ0FcZ+PcMwzBVeZRDe/zOkBQdM1ywTT8kngW0vDKFswRtnIJwNcmlYbUWOdMc
Qv9ABeIYKAukUTp0mmONhe9iRf3JCRQh0PuLuupAe4JSxiBgfmQ=
=iZ8f
-----END PGP SIGNATURE-----

--nfcgs3n53von3wrt--
