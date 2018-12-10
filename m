Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D8520865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D8520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeLJIaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:30:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49018 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:30:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3655820D17; Mon, 10 Dec 2018 09:30:03 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id E546220CEB;
        Mon, 10 Dec 2018 09:29:52 +0100 (CET)
Date:   Mon, 10 Dec 2018 09:29:52 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210082952.llwrrm5gxpxghtvi@qschulz>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
 <20181207192237.GK26661@dell>
 <20181208150526.uceviwfwqskfwovm@qschulz>
 <20181210062718.GO26661@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2vjrlgfvleyxcdo"
Content-Disposition: inline
In-Reply-To: <20181210062718.GO26661@dell>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x2vjrlgfvleyxcdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, Dec 10, 2018 at 06:27:18AM +0000, Lee Jones wrote:
> On Sat, 08 Dec 2018, Quentin Schulz wrote:
>=20
> > Hi Lee,
> >=20
> > On Fri, Dec 07, 2018 at 07:22:37PM +0000, Lee Jones wrote:
> > > On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:
> > >=20
> > > > On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wro=
te:
> > > >=20
> > > > > My OCD-dar is going crazy.
> > > > >
> > > > > Why haven't you used the same alignment as is already there?
> > > > >
> > > > > If it starts to run over 80-chars then bring the others back.
> > > > >
> > > > > Also why is there a single liner shoved in the middle of the
> > > > > multi-line entries?  Please move the singles to the top or the
> > > > > bottom.
> > > >=20
> > > > Hi Lee,
> > > >=20
> > > > Could you please reformat it in the way that makes your OCD-dar hap=
py?
> > > > It would be really nice to get
> > >=20
> > > I'm afraid not, for a multitude of reasons.
> > >=20
> > > The most important of which surround testing.
> > >=20
> > > > AC and battery support for APX8x3 merged -- it'll make Pinebook and
> > > > Teres-I pretty well supported by mainline kernel.
> > >=20
> > > That's great.  A worthy cause indeed.  So I'm sure you guys will want
> > > to turn the patch around in short order so that it's applied in time
> > > for the next merge window.
> > >=20
> >=20
> > Aren't the MFD cells probed in order?
> >=20
> > In that case, it makes little sense to short order them for this
> > particular device (X-Powers PMICs in general). It will just make the
> > system boot slower because of probe deferring.
> >=20
> > Why? As explained by Chen-Yu in v3[1], axp-gpios can be muxed as
> > regulators, thus should be probed before axp-regulators. axp-adc is
> > often used by axp-battery, axp-usb-power, axp-ac-power, thus should be
> > probed beforehand as well.
>=20
> If there are inter-dependencies between the devices, it makes sense to
> keep them in the most efficient order.
>=20
> > For the alignment that also triggered your OCD, I can send you a patch
> > the day you merge this one if it can help. I sent a few patches for this
> > driver that didn't respect the alignment so I'm fine fixing the mfd
> > cells (and eventually re-order them as I saw a few axp-gpio cells being
> > declared after axp-regulators).
>=20
> That's fine.  Please send the patch (based on this set) right away.
>=20

Since Oskari sent a new version with an alignment fix patch and you
merged that version, I assume I do not have any work to do anymore on
this matter.

Thank you all for the patches,

Quentin

--x2vjrlgfvleyxcdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlwOJAAACgkQhLiadT7g
8aO/9g//XbaEfLywwIVvqMBV+QwKVC63R6Q3c7r15PIUDU7l76N7J/ifmFhHuSF7
RAYFpvf07y3REQrB91krRRfXyJ08CmyLkYAlqDqiU03b7weuMrN3fnbnzQdKaFl8
CgWbAJ629B6HG2mVyIvMXLq1Yunf30cjFKmZg8P1oMQL2H6Ibaxvct92U1yBl9eS
NE5Wsq+YCYHNCOnN6slIvpOG+lYmja5vHA4Ln7PFeh324AOsyT1ezw9R9ZHuO+Mi
PJ6i4z2PCZvE0kd+0aD0ke7UN4PqAJ8CflCAjrxw8dCOYjxFHmXsodt3buJAueIN
ZicpPoAxlmMxd32TAPSngqON5FCgnfha3W4GRwUb8SiACSluS8nG8Z8cf+hQnHYx
Iu0LsF9DjIjxfpbnjueCeR775jWWKF7Y/ynVp9/5JPcGxbstwabJYUlax9HTSRdT
8a8a/DxIPMjB7WBXQmvF1ONMT/Y9d0Tjv0Pts6IEMic+g84s1P+hnhzZwCwj5rtS
lqggCQC8OiZ1wJBqhi9pxeC7UEgr2wlqe7GefuvP9CeruptZAs5PqMXPb5ArTEGk
KIG/jLaveLpQo1preLiTXfPDYvn1XeXscv0uZ1sXG4Xkp6kEVkrxp80d8gc4xSFE
1nTnNYyLMOYhkoBl+0zw7t0KmqAl1tCccBabFo245ptjDwo5ZXc=
=3euG
-----END PGP SIGNATURE-----

--x2vjrlgfvleyxcdo--
