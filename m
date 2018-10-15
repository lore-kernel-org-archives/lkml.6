Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE2FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8F62064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Z4fD1ff9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8F62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeJOSJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:09:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54368 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nrj+W0Mi6FpvxRGZ/zF9Dk5Sun48zVUP4hpf1kRkCnY=; b=Z4fD1ff9t/mqRNfFm2t1GKgo8
        tauTONJ6Hd+s7j79eoRbvKevWYWieVB4W1zor6m7q0LAErKfmQD9BF/AcHZbmkL0umeKCjOeVAXme
        XMu1YLz9XjCdxt5X2U9p3TqudR19yzbPphe/dtRUOKPPAym3beespXNyZdGsPws4ToGZ0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gC039-0002zd-0a; Mon, 15 Oct 2018 10:24:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B4A9611224A9; Mon, 15 Oct 2018 11:24:34 +0100 (BST)
Date:   Mon, 15 Oct 2018 11:24:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: bk4: Add device tree binding for
 Liebherr's BK4 SPI bus
Message-ID: <20181015102434.GC6277@sirena.org.uk>
References: <20180927222655.24482-1-lukma@denx.de>
 <20181008144350.GS3587@dragon>
 <20181009122114.39ff3553@jawa>
 <20181015121716.2362d286@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20181015121716.2362d286@jawa>
X-Cookie: Call for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:17:16PM +0200, Lukasz Majewski wrote:

> Gentle ping on this patch (as corresponding DTS file has been already
> pulled by Shawn).

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvEauEACgkQJNaLcl1U
h9B2xQf9Gd/mUcN0Qee3PMMvp0q31F78mAEZGVZwkDuKstj5VgRZ6Cx9f48jjArX
ZvbPnHfdkfTmgmGvCzLDBZ6hzI/cR/cqWbaKCgLJyTKOv8TD79psM+UQZKwjiIGq
LncZ97JhomURxaHrskcG8nms1bl/bOJhoD0GwpO2zwM75L3crOZuMZN8vVJzQedb
GShEh7Q0uPWq1Ix9dHjYhYz8jjYxPp8za1Yoxq2dBClrSzU/9F77Flm+8hzxLs8C
tizlPjpPWydJ7kVxd67D6POPrEed6uw6SD0JopF2/llWsVMtmkb+bXkWRNmExivj
80ji5VB9pfrB5rn+YdPNzkeYpINPiw==
=uwsY
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
