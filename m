Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA50C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED33C21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGWwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:52:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:47041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfBGWwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:52:33 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1gnjn50CK9-004hfV; Thu, 07
 Feb 2019 23:52:14 +0100
Date:   Thu, 7 Feb 2019 23:52:11 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is
 disabled
Message-ID: <20190207225211.GA17552@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:O80fzMqBwkceOe0HK0EW/J6FY/8R7YsENOH36pmH8//tggwlOoU
 /5ovsi39O5cCN+RihCe/jW89IXnBRyqJOIXO3B+DJdIwdm0hob8NAhG7etXo6r9zSOX2zO2
 ydC0IxqzHYV5WSXKz3eXuu36UdLaFIOkxoDoCjA6CtLfO0rlkSUxfLosdpMmb/6lSuQXYkd
 tXgxTNmLmvDksqMG/Wd2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FaDy3Aqasjk=:kFRF3ob9Ft9IDdvCXKSGO8
 OX5FPyXh4T1f9ZM+b3wM0kO1QVlAnmNbMEWXuBQKSU+ol4679nMBMrNNM92Vz9NSQVgIhpW2M
 CV7ZTmJ/NitEpgIl0Ruqjtznrt1c+ehWYIQBuYFSi9bKxXHDX0TTVOdQYiuJUx20YGtyPKJXJ
 uMs54OUsYjjtbv/kZrChpch9Tmy4wem38WRQSyLJHuXt4n6fyrbloxV+1wV1UPPjSohIotUVA
 Aq+a6pWGGL2Zrfn4ptd9LAkbgK0aUN7QK2T6ppv9TM1/tVBbyxcFaox0pd4Vx0BSJIOnMHowE
 nvTwaW3HNmER3kJ3Ur/g/ChsvJx2ipUtYM06FB575bw/t1n1oYePya7Mt9Tu/lCIV6uBurZ9v
 Wg4DcEL+zHvIknckjraf1+blVM+eFHLP3MnDgEyC075ZULItmWWSC+kb/BkSxwqiX9jlxz5RD
 WRjq6ydnOAEJm2Y0i3dXLBpr10ixqWt0/idd8WNz/u7pcrKfX8pGWAnTnjIpvnLfSiZsZcSs6
 hi/4zhFx9EgSuVv9JmlBDemx3LJhnuytSg4FqwyPVALLA37bCccgVS25gkBO2hwZYmXW5OoBS
 kGChxUfl0QMOryrQq2HN6hmbusEAz6Zb91om+FuOZWJhhbQJVkVw8h3+BRyCuGFyxtCzd4ijG
 Re88XHUsJOqjr5KKRi5rD3rugR+YwqF0XEigqGuKYeNkyvwbmOiUbEFw4tGSdLXXby38fonOq
 bhNmavIs5dEv6U5ZdHGi3JexEGbIWyoTWpfiHCV95jMXIQzT8rlYc7Ru5uW9tNUlF2/DI4ACl
 42emqYAbmQYWuACMDnQzrYjLKiTCFMTXK02W7RQJsU26nYG8Gxk8ldhEk0nKQACC6VFV6BJj+
 EDgA6vDRTmmh7dildX/jaMGbZCkIGUcgP4Is4jlQFn4h34ux8m4V+UdUiqbaIe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently porting mainline Linux to an i.MX507-based board
(preliminary DT here[1]). Recently I've enabled esdhc1 in the
devicetree.

However, as soon as the mmc driver (sdhci-esdhc-imx.c) disables clk_per
in sdhci_esdhc_runtime_suspend[2], the whole system locks up in some way.
Booting with CONFIG_PM=3Dn "fixes" the problem; commenting out the
offending line in sdhci_esdhc_runtime_suspend lets the system survive,
but leaves the MMC controller in an unusable state (of course it's not a
proper solution anyway).

I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
unfortunately, the i.MX50 reference manual doesn't have the table called
"Output clocks from CCM".

Does anyone have any ideas or patches that I could try in order to
narrow the problem further down?


Thanks,
Jonathan Neusch=C3=A4fer

[1]: https://gist.github.com/neuschaefer/27cacf0acf5411219be9372d728d1163
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/mmc/host/sdhci-esdhc-imx.c?h=3Dv5.0-rc5#n1412

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxctpQACgkQCDBEmo7z
X9sCRhAAw9ITjTQEEXDivDeMdj/6i8kc+QsJ8gfnBBBykbRlr3Y9bgb1wLrJNKwv
+Ge6OSrQ3tlx3rSVrw2BQaLg6iCxjEuYdmklvOtJ/g58oNVGqi+ZHXz6g0I/2S87
K7TQY+OTbbEd5RU69wRwe5XUYc+sGGovHxDORRghMGfulVz5a9LpHbClqEnNF/GV
VeIkASq3D4xsRrMEoAHhqDWATLyBHxNvMp00BdXoAnswuxmVrNqFtkUOVF/D0F3I
Ex8iBvVuGPbM05zQUXEc7EcBPh+pYYZAhbtfwZxLDgnG+ua18gVJcD3JVvxI8Fys
4kK9Jf5yv45GPRwm0YmkA3edxqQBZEL+HyOCFnWVINzEd7+q4vS4PL7+zdPWuJnV
cxul84iPn0AuO8yFOrFdsG1K6ETU2l+jnc95kJcTV4Wh2R041ZO64RkZkaExznLm
alEL1eMHEZ9mQPdRmvXZsAIdE6OvBBOhsJnwnXShrGB5+CO6/QIl+clwaqTR5Prl
mns8K60gBXA1B2NS6p0QgjeD9DGhTUTANlMA3X3dw5KHxaxnk1Y/tr2JxvdqE6Yo
uliAwEFxFZUWFvUh6yi5oqunEY0bBUQmch5HPHWP2uXc4yuk4a05JjfhUjbczL2y
42kPZzU8rCBLkowsLewstnxgoXcHUTwBkIootFGocsJpjckvlXo=
=ajnv
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
