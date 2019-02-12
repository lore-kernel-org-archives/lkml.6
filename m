Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CADC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F32217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549987719;
	bh=wTZTaNQI1b6/3peS3ScLUDrfb1Xv49RlStm2+Y6OQFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wKaL3LcjVMmdxuRufvzkhPM52TV3QqHLag5Pdb9ZfILeL//AjM/h60V2aOB/zY87C
	 bqtW05sTckZqVx9ZnKKVtFy1iapsXBIUBYJ1a2iswIAWievRw7ZsSI7g/E95AQq/Jm
	 ISg8bejpvb3sbyreXkrEeDwwoxHJ5sTK2VEIqGc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfBLQIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:08:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfBLQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e5Ysopm6RAAm7P4Paqdgkju+qWQ6Z9nWYapNmCq4qDA=; b=Jr0JYVW0VRYyz3eB5J7zPUiw6
        8iIAZrFjGE6hinV2/S7KEJ+xRbP7HspC3scCRvdwpf4qCKEuT19+voOldM0iHl/OPWsvHm3GGCNR/
        w34MP4ywfKrDHetlS+mKja60vgAk6Z7Cn29ps/ZJOpvqnOAFHh5nM86hmVQJke3S2A8I4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtabo-0005Vp-AI; Tue, 12 Feb 2019 16:08:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B0BDC1128113; Tue, 12 Feb 2019 16:08:31 +0000 (GMT)
Date:   Tue, 12 Feb 2019 16:08:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [RFC PATCH v1 3/3] regulator: bd718x7: Support SNVS low power
 state
Message-ID: <20190212160831.GF20635@sirena.org.uk>
References: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
 <06c2f2f730b07caeb1f2fb86be60c02b21d7bea9.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <06c2f2f730b07caeb1f2fb86be60c02b21d7bea9.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: tax office, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 04:19:38PM +0200, Matti Vaittinen wrote:
> read ROHM BD71837 / BD71847 specific device tree bindings for
> controlling the PMIC shutdown/reset states and voltages for
> different HW states. The PMIC was designed to be used with NXP
> i.MX8 SoC and it supports SNVS low power state which seems to
> be typical for NXP i.MX SoCs. However, when SNVS is used we must
> not allow SW to control enabling/disabling those regulators which
> are crucial for system to boot as there is a HW limitation which
> causes SW controlled regulators to be kept shut down after SNVS
> reset.
>=20
> Allow setting the SNVS to be used as reset target state and allow
> marking those regulators which are critical for boot.

The general idea seems fine but I'm wondering if we should use the
existing bindings and just prevent any change with fixed configurations
- that *should* just be a case of picking appropriate constraints I
think.  Why does this need completely new properties other than
preventing the user from shooting themselves in the foot?

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxi734ACgkQJNaLcl1U
h9BE0wf+IsU3kjTSY5iiT3YXDg+KundiTwhux+oTM9c75jAnup5dtcw/KsU3HNCy
eomCAcL6wQQNqAque3hAuDPATOIiecZCru1zun0BMRypT5/LLwUZGgu/rSRRPR0M
/RaZcIM07939e4T453bJNR0iutqKAwsHWxto02PhO3Wf5AfzlWnlUQiV+lv9VOsH
P/SovBL/8lDwZTr/hOQDBQf7q3ax/fbt0Vvxvk7pLoHUEzHtABUx1/ab+2pKpaaq
7yqPtGPWia0HPuryC70Pi3fF+/hW2VmEa7ZqPEjIqQQ8OxgRsX2UeW1d1kxeU7Fd
ahsE765BWOzkmUvNaJxlCnu4TA+QiA==
=KLTb
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
