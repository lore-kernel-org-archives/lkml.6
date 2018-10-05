Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A3C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769422084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769422084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeJETXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:23:03 -0400
Received: from sauhun.de ([88.99.104.3]:38962 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeJETXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:23:03 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id 2DE172C79EA;
        Fri,  5 Oct 2018 14:24:32 +0200 (CEST)
Date:   Fri, 5 Oct 2018 14:24:31 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] i2c: tegra: use core to detect 'no zero length'
 quirk
Message-ID: <20181005122431.GJ5433@kunai>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-9-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-9-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:12PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ping.


--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3V/8ACgkQFA3kzBSg
KbaIMg//VoDVkIgkD3T/QM1hU3m4q/+ParcG3kgHrJNciUf/GlzoZcKhvHIvXdli
PF6F6K8RFXnfNs11r2ihDdICbRGZkd/AX7Vv+f2NUzyEVaXZKQGtEd+cw03k25Cq
BS0nu4b6clpCEHAKEZgnfrSnifwiVYdNIht2K+n4swAktfoPEX8HAeNnMmSmuWf1
whdta6zIIzGt/Kstcx6x59nZ3DQx1NfeDJ3AV4Y4V2Rv8BiY1jEIS6ScnPVeHI/A
zV4QWmIKhHxvCL36rxBhsPjb14kfjPxLdJBLnLFbUTP7S2yZVuvHA4LPIYn7S5PW
LukXgbEPWPJe3ox28HeRDpzhBFiSza7qjjT3wJFg0f/6F0KtMmDf4DRz1SJ3vPmc
LlDv6YaIs6KdGxHMxAjRBiIY1MAqgPpvI7tuxOzaiC/FwW9hZPdtZrRu8Lrazr3w
OVv+uW6pc+FPV4fxn7PMVdlZPV2H/sYbkvPUVSxwerR2OTWBbQM+FELGEOl3ag95
zrqddnG7DpUS8Ogw0x2wuMM8oxQLK7m8K41b3k4NqjwGfm9ntBj6Af+FmHz3Dr27
MeHhQnSJhpsfF8v1PuXaWx8J4mRIin/SMO9/RLzdp9nfV+Bxy/NJaJKVY3gUW9XG
gv3jN3fPYFvSguWlBFKRfVNHEaBcf5qcHz0Wt4N/81bdw0vuJUc=
=Om5z
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
