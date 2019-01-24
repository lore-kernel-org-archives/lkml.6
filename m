Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AABC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1612218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfAXM0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:26:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40000 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAXM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:26:36 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4A9E5805A2; Thu, 24 Jan 2019 13:26:28 +0100 (CET)
Date:   Thu, 24 Jan 2019 13:26:33 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / wakeup: fix comment of pm_wakeup_dev_event()
Message-ID: <20190124122633.GA24847@amd>
References: <20190123162201.26366-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20190123162201.26366-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-23 11:22:01, Yangtao Li wrote:
> This brings the kernel doc in line with the function signature.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -783,7 +783,7 @@ void pm_wakeup_ws_event(struct wakeup_source *ws, uns=
igned int msec, bool hard)
>  EXPORT_SYMBOL_GPL(pm_wakeup_ws_event);
> =20
>  /**
> - * pm_wakeup_event - Notify the PM core of a wakeup event.
> + * pm_wakeup_dev_event - Notify the PM core of a wakeup event.
>   * @dev: Device the wakeup event is related to.
>   * @msec: Anticipated event processing time (in milliseconds).
>   * @hard: If set, abort suspends in progress and wake up from suspend-to=
-idle.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxJrvkACgkQMOfwapXb+vJA9wCaAlwptI3DbN0d7LGOmjY8d3aM
2EoAn3N/XMDMdrC+7D96VjzY5un9RApl
=187Q
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
