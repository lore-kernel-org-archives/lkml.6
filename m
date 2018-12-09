Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA12EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 09:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDE320831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 09:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDE320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLIJAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 04:00:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52014 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 04:00:11 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 71E8780845; Sun,  9 Dec 2018 10:00:04 +0100 (CET)
Date:   Sun, 9 Dec 2018 10:00:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
Message-ID: <20181209090007.GD7561@amd>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <5C06124B.5030409@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-12-04 14:36:11, Chanwoo Choi wrote:
> Hi Lukasz,
>=20
> Looks good to me. But, I add the some comments.
> If you will fix it, feel free to add my tag:
> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
>=20
> On 2018=EB=85=84 12=EC=9B=94 03=EC=9D=BC 23:31, Lukasz Luba wrote:
> > The patch prepares devfreq device for handling suspend/resume
> > functionality.  The new fields will store needed information during this
>=20
> nitpick. Remove unneeded space. There are two spaces between '.' and 'The=
 new'.=20

Yes. And that's because two spaces are okay at that place.

https://www.writersdigest.com/online-editor/how-many-spaces-after-a-period

Please don't cause unneeded noise on the list with trivial
comments. If the patch is okay, apply the patch, no need to find
trivial nit everywhere.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwM2ZcACgkQMOfwapXb+vKjzQCcCsUqmaYo8aPuD0m/JrfCBl2z
ZaUAnjMt+1X+vuWarQhgVM/LXGeYdeLw
=2woN
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
