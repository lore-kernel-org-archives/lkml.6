Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCUCnW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:43:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53642 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeCUCnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:43:21 -0400
Date: Wed, 21 Mar 2018 10:43:11 +0800
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: regulator: add QCOM RPMh regulator
 bindings
Message-ID: <20180321024311.GW2186@sirena.org.uk>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rK7ir9GIO0YQrgt+"
Content-Disposition: inline
In-Reply-To: <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rK7ir9GIO0YQrgt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2018 at 06:09:11PM -0700, David Collins wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

> +=========================================
> +Second Level Nodes - Regulators
> +=========================================
> +
> +- regulator-name

This document appears to be reproducing the standard regulator bindings;
there is no need to do that, just reference them.

--rK7ir9GIO0YQrgt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqxxr4ACgkQJNaLcl1U
h9DLiQf/Q8ERePDXGrWJlqwYQG9rsHnVP1PRk0PKR9znv+BLDavwr6/eTzv07Bpg
q/b3baaG5X1X2tgGHSf8mBvMTjYb0di2kkHrt3JqWOFuzBOZXmvfN4+puzFlKNH6
urygn7u3wn9KNpavzNpdrhVVDyn5JMujEU0O7i1ob6vZcnLvqatF/QGb9x835igR
LGeakmDERXCEE6ZelPLQeXqfvpTIXL8/6szJHSLMNLjdLzClfOuf8+wlc4Sa8l1E
rxrUFczZe/1qx5en6BqOomthCF6vmTTODsTKwFvtaQTZzA1q/ZP75S2AM/7y07vk
wGgEKIqv/cc4pm0ysYgrMrWq4bLw8g==
=nBpg
-----END PGP SIGNATURE-----

--rK7ir9GIO0YQrgt+--
