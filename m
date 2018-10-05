Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C2EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1026C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1026C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeJETNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:13:49 -0400
Received: from sauhun.de ([88.99.104.3]:38846 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbeJETNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:13:48 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id AE5602C7EC3;
        Fri,  5 Oct 2018 14:15:19 +0200 (CEST)
Date:   Fri, 5 Oct 2018 14:15:19 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] i2c: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20181005121519.GF5433@kunai>
References: <20180928224947.19058-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20180928224947.19058-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 05:49:47PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-next (with Peter's tag from v1), thanks!


--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3Vc8ACgkQFA3kzBSg
KbZbGA//TSsle8Y0hbsCLheqkV1zbEMBpC5F5/eaqcwxg20jF/6pD+9q5L2xPbCW
PcaAC9SB5ftn/C9gJKk6wB5jKxoDU57rczj0csUN/tb0b066FkJVqx08vPQtNbXZ
X9fr/rhwr/K88d384wFxailAR41r88BmIJoaNYmcbUcsBBYQC3USOQKmzd0lup+i
1MeKAanXqQnCeEXJkf3in1u/dLEI+yI1e6/EEzo/glFw1l8tBFQJ4D6/VAnSX2He
SfL4LRkJkw06PKRWuRMvox2nNuT6rUVqa81qlNLhrrfE/VzRAM9I5U6l5LbgZYdg
LSzLPQNOyuLBkdxsxNjpoEV4HHvtM4ultHy+SBQzevJ9BsiZ78FyxugB4hg+1hxf
qHlHAT1gCvzNfvGHPekYbP7c0iDa2N9JlznW5oNmT4tNt/gNAUGJr6rr64FO2rVI
DIaYKIScjKAMAIixr3fIDr5sxmaxb8ewdva9Jro23QnNUjOAuVSwzmlZBa16Nn48
t02PycWUlhXp4y3KFXVdPHZjXpcQCf2UaF6nkVXuZ9U9KRRo8C9mc/Q96XErM7vl
oFxuZpWaiBXTWQzp3lER7aFY5AI91MxdlkcPVklq/9J5W/HXuJBSe+sOUi5DxH6d
74p4Ki5FzP7HguGw+x5EcuIvKUPkr3RvBI5DNIOh7SVMuBhUvN4=
=tLIh
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
