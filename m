Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35681C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EBB218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546638119;
	bh=LztnY2qaiDP88JkN1oCLUEPd1IqtY9sxD3nse74VJ2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1GdGknpX5TY3VUEBsq187/q/bj6loGQ17Q0adCVZHNQWhV1PALNznmc/B/64fsbK0
	 8U65WLyLnoYqBoeweL/gAVT+Edt93UYdaCjRSdq9iXcWopnii4ZHYgnPZ5JUZKNUAw
	 sZb1qh8e5+Xm9riL9HiP6F/+gWhndf2O2Xmw2aBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfADVl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:41:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfADVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bUFIOpkaPhj/lM0IunD6gd2bp13FnGJa9twvsCIq78Q=; b=D0CQLG6+tWW95WKpZIQMFYhpv
        I5vg6LtePfMo28u9cexa6LpFbxE4C1ryCisUd8kgSOwb893spaBA2hf75gnD6hhdyMzDQkrfWkbLf
        xk55stnqNIb9Av93R0D10aDEdA1fPwfhnQUtlS2SSDNqBzUsT2dIZ/56+1Iq/aEf+5xMo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gfXDr-0002tE-B0; Fri, 04 Jan 2019 21:41:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 58661440082; Fri,  4 Jan 2019 21:41:42 +0000 (GMT)
Date:   Fri, 4 Jan 2019 21:41:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Hsinyu Chao <hychao@chromium.org>
Subject: Re: [PATCH] ASoC: rt5677: use more of the volume range from DACs
Message-ID: <20190104214142.GA2410@sirena.org.uk>
References: <20181220232555.90030-1-zwisler@google.com>
 <20190104205132.GA106594@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190104205132.GA106594@google.com>
X-Cookie: Dyslexics have more fnu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 01:51:32PM -0700, Ross Zwisler wrote:

> Ping on this patch.

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

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwv0xMACgkQJNaLcl1U
h9Ciigf/agQi1BddVaEe/9avDU1HhJQEyE77MZ4jJF8YbD8qrWrX/f5ehl2n/XrM
HSrs2jxL1nqtS9h33HkfOZBoUJM6IN+MT+rhEWvircmI+iRtBcKVSWA1DhDbgpG2
Rru4FReoN1B7cilVvI6YJoeT+Ey28wu9z6/eG43tLUwh3zlYEGQWMYaaC1anfB6o
VTOeXSwNLoFQMbpNNXlDfJK5eKqPZV6M1lr4Gj/uSyWwdozfWZnk5EYLiETinCKr
wzTcyFrZKTP+BkZ99037bIc6mtqBL+ljVDZPV7ROICuU6lc0YnsYgns1dWHmElGS
e++y8JRkhaQ2oCd/MT0FYO0ephhLVg==
=aebp
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
