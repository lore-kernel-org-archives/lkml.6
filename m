Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD9C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B54C24065
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w4yTvm+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B54C24065
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeGEPKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753922AbeGEPKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:10:45 -0400
Received: from mail.kernel.org (dyndsl-178-142-077-060.ewe-ip-backbone.de [178.142.77.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F25D24065;
        Thu,  5 Jul 2018 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530803445;
        bh=iagVHfu8EHfVWdVULkfA2daJ0hXGq5hG2WY2oS5+yis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w4yTvm+kGo1o93qNLSQQK9WL1MbSNk146hDD0hrmx6tzNh/IAWuaLiKBxSNXqTphM
         nfNr79CAPBu4nZtGTeEcUmmc/fS+vyJAvF4I6FrxiBecBhTEp9Qewjzu8VRPrikx5P
         aH0whxe2AQ2cl5lX9CVb3Fj/p5VoixPmxDktb3tc=
Date:   Thu, 5 Jul 2018 17:10:42 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
Subject: Re: [GIT PULL] Immutable branch between MFD and Power? due for the
 v4.19 merge window
Message-ID: <20180705151042.lqka7abyipmhrae2@earth.universe>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180704061246.GV20176@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3f45jqao6s5vw5i"
Content-Disposition: inline
In-Reply-To: <20180704061246.GV20176@dell>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e3f45jqao6s5vw5i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 04, 2018 at 07:12:46AM +0100, Lee Jones wrote:
> Apologies for the delay -- these two patches dropped from my radar.

Thanks, merged.

-- Sebastian

>=20
> Enjoy!
>=20
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab=
40:
>=20
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-v4.19
>=20
> for you to fetch changes up to 3144dce72b7c53a0ca9f054c8187925c40381caa:
>=20
>   mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice. (2=
018-07-04 07:10:05 +0100)
>=20
> ----------------------------------------------------------------
> Immutable branch between MFD and Power? due for the v4.19 merge window
>=20
> ----------------------------------------------------------------
> Enric Balletbo i Serra (1):
>       mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.
>=20
> Sameer Nanda (1):
>       mfd: cros_ec: Add USBPD charger commands and struct definitions.
>=20
>  drivers/mfd/cros_ec_dev.c            |  16 +++++
>  include/linux/mfd/cros_ec_commands.h | 132 +++++++++++++++++++++++++++++=
++++--
>  2 files changed, 144 insertions(+), 4 deletions(-)
> =20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--e3f45jqao6s5vw5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls+NO4ACgkQ2O7X88g7
+poldQ//YlpEvyzyTs0mEXWejiIY0SNS9vzhql/LyIXvHsPywH3LSbV4plrs/pBY
PgeHkW8VrtmgHMtaULV0KKG2Lqlpxh026WQaUpShWDsHE/UlxID8iJFvqCM71tG4
Bn73CHSnnsOMluf9kJzdpBmdwtGu7jEXYRWD4d3Z9PIqn7PvnL1u/qXRg2skzeLk
RWuUuBkoyNR+qF8kVoGjkhp9w8EbZ422jeBP3NxUgHLIoEvl7e6utPOxWnP3uV7i
Wf1XiNjW9hD17/vic+/92aln7PjfrN1zrPe+mLoyerqe0/KSSSCmtbUXAGa01+ld
LdVkUp8/g4+C4yH64E7oTifr3GzrfBoBHmAZjRqBkL0jaPKhZq/TYb7J0PAJBwGf
4CZyjGhVoAT1ErqVb9WrXtsQFQeJDlWlHC1sirO6ByduHrPOSQRHiH/SCuSaPgBu
Ukl33GbQmeKHex3X9w5Fbmnywslo9otMuy/K645ozJJ4yHdsJdvsVTmKZaNqaCEj
Rn25Q5YQWDMoL/Q86DVObcg0jWEya3iaxUkZtFrCZsaT+GMy3ubz9vvd0Y2Mcc03
XyAGrl3+mNrYeRWRev3sfmnx62eDpl9LcITtZyU/1fBk95FYGxii+a4FOqTXtfCg
3X9qroW1zVIvoWDPKpVmULugXWndu8FiCPwf/4bsYYVGMjQaIeg=
=kAc9
-----END PGP SIGNATURE-----

--e3f45jqao6s5vw5i--
