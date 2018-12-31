Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12776C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6F20652
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeLaR05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:26:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60453 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeLaR04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:26:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1C729808B9; Mon, 31 Dec 2018 18:26:50 +0100 (CET)
Date:   Mon, 31 Dec 2018 18:26:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Wang <davidwang@zhaoxin.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, len.brown@intel.com,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
        linux-pm@kernel.org, linux-kernel@vger.kernel.org,
        brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, timguo@zhaoxin.com
Subject: Re: [PATCH v3] Optimize C3 entry on Centaur CPUs
Message-ID: <20181231172654.GB14092@amd>
References: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-12-27 16:41:50, David Wang wrote:
> For new Centaur CPUs the ucode will take care of the preservation of cach=
e coherence
> between CPU cores in C-states regardless of how deep the C-states are. So=
, it is not
> necessary to flush the caches in software befor entering C3. And this use=
less operation
> will cause performance drop for the cores which share some caches with th=
e idling core. =20
>=20
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwqUV4ACgkQMOfwapXb+vIUAACgjrtljk2juAmf4OAYGo1GtH4P
OpEAnAsXfd1wmlwcy7QcgyijpvZGT5vz
=JuLQ
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
