Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFBD2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbfAHTmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:42:02 -0500
Received: from sauhun.de ([88.99.104.3]:44176 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbfAHTly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:41:54 -0500
Received: from localhost (p54B337DA.dip0.t-ipconnect.de [84.179.55.218])
        by pokefinder.org (Postfix) with ESMTPSA id 4534A3E48B8;
        Tue,  8 Jan 2019 20:41:52 +0100 (CET)
Date:   Tue, 8 Jan 2019 20:41:51 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V4] i2c: tegra: Fix Maximum transfer size
Message-ID: <20190108194151.pdkmxp3m34k5crpf@ninjato>
References: <1546560767-9559-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ta4ucdpp3gpb63o"
Content-Disposition: inline
In-Reply-To: <1546560767-9559-1-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ta4ucdpp3gpb63o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 04:12:47PM -0800, Sowjanya Komatineni wrote:
> Tegra194 supports maximum 64K Bytes transfer per packet.
> Tegra186 and prior supports maximum 4K Bytes transfer per packet.
>=20
> This patch fixes this payload difference between Tegra194 and prior
> tegra chipsets using separate i2c_adapter_quirks.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Looks good, but doesn't apply. Can you rebase to 5.0-rc1?


--3ta4ucdpp3gpb63o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw0/P8ACgkQFA3kzBSg
KbbIww/+I/rnCg+P7ofEkUHAUoVDMlqgJnUoxTyyIK9Oq1QAShIbDH7mfFDXm5Yx
iPjZwK/rpxUGNu2qUCSi8KI2WCVfZgZvfZv6tFVj20Yc92E4PVd1ztHcoqXgCYDD
OOhNyTMjdWJGZXOv1te9N5UMfLGnD5H/3u509AbHC7Rdu+/k3yrN8sNmZZ2bbmZM
r2Wy5RgRcGAV+5TSdmgPDM67iKrt8mhxFe/3n2FiUThSsXZjQqS/TN57hDNFLwkW
cTAKojJ8CthHkcXdp3+x0DFkW0CO/bmho2VBCur6ASG9xm7yePPLQ/m5nXw8hWWk
fcolqKORMmaRY89yLWPUIXpDjFRpOw1gL1mRJL8/MkBwRXnTARYOqQhgSJBMa1iS
Gnve28vS3jInDy/usyD6qRBcJyxvE9D/wJXkTC9UcUrcm5eeu76+3QB2TUwwG2Hc
fvi8ehvmg29m9ylSQWWakhvBYKKCSVJs6JV0lmwa1hpaQ0bJukARfwHBGHh1d6Qp
xE5Jcll4yr208A5HxJqjaWIi9fbZF8u/2k+JJR3MB0zrGX1M7ULmG8bsiJ77eUCb
r8hFOk0kiRQkKIOwAhirpnE8UKOvEvyQIvKCKzFE8/c4nIqAoVhGXr26zbrI3Cyl
4b0PN64nQ/Kq+wA+RSm8DpjY24haVcH9gSfAEvEMyrvOhZDAHoE=
=pV27
-----END PGP SIGNATURE-----

--3ta4ucdpp3gpb63o--
