Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F38C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8289E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8289E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeK0W7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:59:39 -0500
Received: from sauhun.de ([88.99.104.3]:58238 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeK0W7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:59:39 -0500
Received: from localhost (p54B33299.dip0.t-ipconnect.de [84.179.50.153])
        by pokefinder.org (Postfix) with ESMTPSA id 4F22E2E3542;
        Tue, 27 Nov 2018 13:01:57 +0100 (CET)
Date:   Tue, 27 Nov 2018 13:01:56 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, peda@axentia.se
Subject: Re: [5/6] drivers/i2c: Remove caller signal_pending branch
 predictions
Message-ID: <20181127120156.GH1107@kunai>
References: <20181116002713.8474-6-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <20181116002713.8474-6-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 04:27:12PM -0800, Davidlohr Bueso wrote:
> This is already done for us internally by the signal machinery.
>=20
> Cc: linux-i2c@vger.kernel.org
> Cc: peda@axentia.se
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to for-next, thanks!

Would have been nice if the cover letter was also sent to the
i2c-mailing list.


--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9MjAACgkQFA3kzBSg
Kbb8QhAAqwKxOKbj5GfXU8eW52HTh3H7K799qQAfEhc4Qn/1kUUIuvX6et29lEy5
6bJWcPjCORAMJ5qxHHSR0jGqkZq+z8Fl8cp98U8v2R0PZiGgB2+n6mOQsMH879SW
IyrgK/NBfFiEeI/FvCdxN8Z+I/vFa5LugyNhV9UKIUbz26tHdZVHcrRvvZd1OVNq
bdR+mJXxfr4Ik8NeppKUypjpxbU6nh1azIoY2/JSjq4GXt2/pZiaEyEUQDipcvet
Bre7p+O1s9qnT+6avsWq90zlXVFZq9gq2VdwJ0kevezjWi/Xqv8xgPQNcZKNjC2g
+kWQK1kC5S9HLRor+6Xek5jucj9wuXtoe1rCKCbCxn2pTrNYI+BaRLYzcw6Q8jTm
T8BsgqkyynSP8HxCm2lc5zMH5TpsTvR87gRiRh9lgtayGCc9cHUqnrHJTB+rtFSK
g1cCE7R97QWK3ct6AGrVbBAt6B/26ZMPYHP+jUFfHGtf01jQYnRtve6pITnOg2wl
wWbj5Ow5dRpcbOoSfQNZwkHzEiV99D466bWbfur6JTYmiHc5uXcMI3kaW5m8htmx
x0dretQVFR5FT5nTfDh5j3ONpJJzXaVvDyLtiPdkqunc0FSk07kAF0n4/ko7NQFe
2t9wVLIGMGhOhXBupysxBjN2fGQ8lsnwsIsbc7v8Wzs7ht9y/os=
=cYZ+
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
