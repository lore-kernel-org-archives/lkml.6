Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B8C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38ED20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38ED20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbeGSPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:17:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40269 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730053AbeGSPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:17:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4E47320732; Thu, 19 Jul 2018 16:33:48 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2427920717;
        Thu, 19 Jul 2018 16:33:48 +0200 (CEST)
Date:   Thu, 19 Jul 2018 16:33:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/5] ARM: dts: sunxi: Remove unused
 address-cells/size-cells of dwmac-sun8i
Message-ID: <20180719143348.5kx24tr6k7ytywsk@flea>
References: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xlzdgzogir4l24dp"
Content-Disposition: inline
In-Reply-To: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xlzdgzogir4l24dp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 11:40:36AM +0000, Corentin Labbe wrote:
> address-cells/size-cells is unnecessary for dwmac-sun8i node.
> It was in early days, but since a mdio node is used, it could be
> removed.
>
> This patch fix the following DT warning:
> Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary=
 #address-cells/#size-cells without "ranges" or child "reg" property

Applied, thanks

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--xlzdgzogir4l24dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltQoUsACgkQ0rTAlCFN
r3SbIw/6A/x+smpcVPm5xdm3afFClWJjdZAiAA97UtseDsOj18uNkUwqY72mIj+M
AdT5H/pznCWjGMl1GvSI8QsB7Mx4HTRiZvZ28GFN7Ll0E9GZK9Cnv137qz9xB35d
JnXgRsKMcjwe7Bx1juOCgKWgyzZMAgUZ5N7R1wdSFhzSVExCdcfAOnmng7TgBRgd
5GMV8nO/UIULTmQW5+mq62Rrrv3++J+CzQ7XWZhrGB56G75UAqo0xiJYsRpQ46m/
8oZrXhosbBlSM2BwgV1WQzj0A2p/F5TXyboCnG5AQ4emAsFeycFztb+udW922Q0W
E+q2XjHTrD9+drUxVBRj9kHdrQQtMGHbyvS53I/UM/vIaKvJ/NCwtucRIZfBjNR2
5hEXVwEIPsXycGEs3G6eax/OCIQAiL7jKrqduMUH8uZViQS+hX7ENEU6UsM9kwcD
YBjLvhh0znWQj+BpYt7tlSiW6cjnSaC07O4c52LJqbO0Fwfr+K/CeL6/8Q7GygkD
bPEnvMHFSqVa9ZrmHQ2c8djnJ/mZB4YL30vOZjgoarjAH+BBJ282HHvttWPKui99
NY9rfx7pgPHQ86RC22vcuf3TXF7JdCQZlp33QBUFKsf31BRsu+KJPslrkFs297Nw
E596cDgSHLQKXVHcBwldKSHzQt6m2zN6o0MrEPF3YqUu1uSM1Ac=
=ICOH
-----END PGP SIGNATURE-----

--xlzdgzogir4l24dp--
