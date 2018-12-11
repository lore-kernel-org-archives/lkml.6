Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E69C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4EF20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4EF20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLKTNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:13:37 -0500
Received: from sauhun.de ([88.99.104.3]:44834 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbeLKTNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:13:36 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id EFC324C0E8F;
        Tue, 11 Dec 2018 20:13:32 +0100 (CET)
Date:   Tue, 11 Dec 2018 20:13:16 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Message-ID: <20181211191316.asshpucnnhkd43mc@ninjato>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rlh4qplpe7ewwylv"
Content-Disposition: inline
In-Reply-To: <20181211190953.13626-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rlh4qplpe7ewwylv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:09:52PM +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Great, thanks!

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--rlh4qplpe7ewwylv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQDEgACgkQFA3kzBSg
Kbbujw//Rmg6CpKq42FYw7tg/uyJ56KZ1p403nkc1fz9EFCBV3sN2AoGGKBPp23Q
dXwKE41n7jE8IJLMTBC5AcNWZ2YeZL53V38cnaQEn4wiKxuh8H5V51QyBlhAwa9B
/C4Ch3fwmEpI1gkIm11EaV/1jpSeTVPZh86bVlk2iC1gwChpIai2eU5kqu4jl0oo
sNeU3eBS6zYvP9Af7FIstAWSfiXX23dAdI9rYq3flE/UdjGYuJnN8/HrrRyvhXWt
Hv+LYeY3MATPs7nBbu6z6ujqc+RGu8Jku+SAzK9fHk9mWn1RB6y5nI07flEuHs2U
Hzhqa5ohTZpdb0Jda0hhBW8+IEo9WYPTAWf8ATFx7KlCt4Xdbk05kb6l8javuwS1
+k5vAiIglMgJqEnFcnW0uUqukcmvJrtF9bKet5LvTN0mIAjP6/FGmAU78tJuT1bd
CwBcV+HmUjry9XIE/jQC0aAgse5/2x4uY5MN6veISFPBj06AMvb9sIk0zK7d+P/g
KV6dJbxYhkNBXYYunx80ThNT6WPSxsL0+xNJutwmPefpoD5+T+N6G8O66kC6qCrF
aulUu2E2He4Ed7D55XUMBibD4ykKyI7L43b1aZbQi8iXf+T7rW3Hwcd7709pLGB/
l4ekPPCzAHZjf9lbbcyX7ltwHuJ/fTjHESO2DTPDRUdZT/Jy6cQ=
=A/iL
-----END PGP SIGNATURE-----

--rlh4qplpe7ewwylv--
