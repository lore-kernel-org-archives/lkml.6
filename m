Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0469C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC06208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC06208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeIYERs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:17:48 -0400
Received: from sauhun.de ([88.99.104.3]:38918 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeIYERr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:17:47 -0400
Received: from localhost (i577B9B6D.versanet.de [87.123.155.109])
        by pokefinder.org (Postfix) with ESMTPSA id C91822C0599;
        Tue, 25 Sep 2018 00:13:24 +0200 (CEST)
Date:   Tue, 25 Sep 2018 00:13:24 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH v2 2/2] i2c: i2c-qcom-geni: Simplify tx/rx functions
Message-ID: <20180924221324.GG18592@kunai>
References: <20180920180323.217377-1-swboyd@chromium.org>
 <20180920180323.217377-3-swboyd@chromium.org>
 <CAD=FV=U=r0nkT+JO2j4WUHF03ZiJcmaVrzL6dsauDHV=a2m3tQ@mail.gmail.com>
 <153748188889.119890.3818754688788845202@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <153748188889.119890.3818754688788845202@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Sure that's fine. I'll resend this one patch with that squashed in.

Waiting for this resend.


--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlupYYQACgkQFA3kzBSg
KbZUAw/6AjBlbEkPNqwMjLmoFWCYG2iIlf+ba+VcKOfT/msFIMa+UA60q2rzKgJR
q3Qx3PFagto5Vpoaoj0Vm8FYpEL2ePw2n/l4ULrvVdzlTvPVu58PiX80bijy+QN1
H25JOGX/xslcKN07MCMCM38NoumrmMPM7iFK18uooPLqVeGe/49V38aqkiTv6tkG
YE8tsr+WHgxDDvZ5X+eZF0vikupbJsjB6MShThZkQGspv95qwagVO4P4ZvyLpvHn
geWXyby0jCskkUDADpl9eJzKUEgqN18Va3Tli1VzK75Epv28mnjkDGDNr60ujBPd
LEbm/qK0Wrez46S5KrpLR24mMsBGuDGivgdV/puaWQA1NpAIh2koD8ZRqnZMhXD3
39iipVT0304EQi9HU9AW1R9Ye+nF4rzXobc8CHIF/nvVjwVGYu/YrVhOjtIu8Jun
KR3+a+79AxgJsj1epx0NKBvJ6VEVCuWM+gZ5O6d7w/jfE1AVUFTlcCH73Qy5vw3k
0NVaKJmJFFz0rJ8timQnMZGUyPoj+ajp5Bvc2gixYYygGaw0nI+1LYzOXYLB50FO
n+Y/AYMiWxKdBDWhMQiRMI1BSkoD+cKYycqjz2gRWkIsix6ktvBnjHE2ViKWUZ6Z
32lAym2dYG2GizHGLFf8nTFTLkRfdXm6qU0eG8bbPMLdYauDgJA=
=KsAr
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
