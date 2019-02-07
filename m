Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D34C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5082C2080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBGVk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:40:27 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34345 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGVk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:40:26 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4165560002;
        Thu,  7 Feb 2019 21:40:23 +0000 (UTC)
Date:   Thu, 7 Feb 2019 22:40:22 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/wait: use freezable_schedule when possible
Message-ID: <20190207214022.GA7289@behemoth.owl.eu.com.local>
References: <cover.1548998323.git.hle@owl.eu.com>
 <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
 <20190202183743.GA229953@google.com>
 <20190206233050.GB2092@behemoth.owl.eu.com.local>
 <20190207150537.GA180446@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20190207150537.GA180446@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Sure, add these test results to the patch as well showing reduced wakeups.
>=20
> I would say submit the freezable_schedule as a single separate patch
> independent of the vsoc series since it can go in separately, and also
> benefits other things than vsoc.
>=20
> Also CC Rafael (power maintainer) on it.

Thanks, I have splitted the patch set[0][1] and submitted the
freezable_schedule patch separately (only cc-ing people responsible
for the wait api + Rafael).

regards,
 Hugo

[0] https://lkml.org/lkml/2019/2/7/802
[1] https://lkml.org/lkml/2019/2/7/870

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxcpbAACgkQZYVUZx9w
0DSNowf/d7SSIvcMfnBd2BaJGvHp5g7yCzIRPOSeN78ItsxI+gtirnIqJRlpui+j
bhQB/STFjy6SytGPit+IZoQ7sJ0LW2PLhswFpyHI4/y5M0bHW+eiIojKX66MFQgn
Nz/4RBGDAEuS0R/YtYkPQ6a/yKcGM1f3BMuAPAkbhb5Pa8r9iSgZbLyzG+hU0qel
6gidzuNx+VbwCzyrK3Ukrto0XpC9uH6Io370o/2QoiEXnP2lZN1CS7qYJcHZz5sA
xOOsKnUGLhp+aw80ct+JU8nhHv2Cge7v5JymUPRMhyWIu7HDSTFfsRaXPMt9MOsC
mI+voU9V/ihHHdM7yWU665X6kQIU6A==
=XoPj
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
