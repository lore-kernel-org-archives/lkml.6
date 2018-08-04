Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1263FC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EA1217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EA1217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeHDX3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:29:07 -0400
Received: from sauhun.de ([88.99.104.3]:59126 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeHDX3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:29:07 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id DCE83684EB3;
        Sat,  4 Aug 2018 23:27:05 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:27:05 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] i2c: pmcmsp: use core to detect 'no zero length'
 quirk
Message-ID: <20180804212705.ke3jxsu6igxl52ea@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j5tdcwpncxafj2qj"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-6-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j5tdcwpncxafj2qj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:09PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--j5tdcwpncxafj2qj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGikACgkQFA3kzBSg
KbYm/A/+I6/yOj90WDXcP2waOnoN1Vu2LhlQkOVflZV5ousCq6sRSOt4RFQa68iy
0bgEruv1Hy3vvyVCyBHQQ+dzUX6LYaFglab/aX2NBeo+saKryOIdYLXdIx21OyDV
6Z3tlb7tSzA21vpSBi2gFPHU1uC/lq9v0olhu0aCfQ3d50TD4bainHYIe8YYQ3NS
E6ghoqMBB634ZbYxIzAYHhG2B1w/Ywd9cO6ye9EmmiD1ozn8Y/vUpfBTzNys7Rad
AF2fCHmF7d/X/DsOT9TaPboejFqTsZKtMFtZxJ69g+064IYZrdehX2EUvMKSTzop
Ea+2wxhc5ZpUrptuNRJcxBOOhoZWcElf2JFEa31k35LQD4bCjWPKYJNgcNkAZE3c
CG++Ncsp/em6D9qHT+k6bnvWilYFmXdJtXPp9G3z23v6tfSNjMTKnkhM3Wda2Msz
SK8wYOomucprAZ8Rf3p0Q7vEPt5bxcPMmmnS5Y4+ITz2accH4vFzJBdcpfZF/JWz
LTUEWjLQyWLVfyF9xmTPSP2ggprjPE7ccOBpRVvkf67B9vFZvLSFKBl6It71OnDY
75r+At/gJFYZUa35c8ahZin8e8l1tYdLGga0k9KHhvaKyjBuj/b64YnnG1iRi8bS
rw46d/6xh6kL+G9A3elOxk/zPjvmXCk7p98/oiiAzvB4dMQbdwI=
=2KBD
-----END PGP SIGNATURE-----

--j5tdcwpncxafj2qj--
