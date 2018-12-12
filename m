Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD97DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FB520849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544603676;
	bh=+zYlX5hybM4j6WZXWXc+7E9TCzG+0cw0hnkpwAcj7Bs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ms6ka+6TA7IjFTA2EGzB+zv3cUX5i+MoiohvS6Au9ZqSS1Ah/U44zntNIIQ0VnHFQ
	 TmCbZsN2z08z4Drbf7maE8WOUFTLmpOSBF60yfmGYwQ7j3AQWP/QCXQHTiCD+vrWT0
	 4IBaQI1y9aX2o19vmJmraM/wSFrCo42D6CMQjAzw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FB520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeLLIef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:34:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:32155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeLLIee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:34:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 00:34:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="asc'?scan'208";a="282933478"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2018 00:34:28 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>,
        Peter Chen <hzpeterchen@gmail.com>,
        "pawell\@cadence.com" <pawell@cadence.com>
Cc:     "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "adouglas\@cadence.com" <adouglas@cadence.com>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        "sureshp\@cadence.com" <sureshp@cadence.com>,
        "pjez\@cadence.com" <pjez@cadence.com>,
        "kurahul\@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <VI1PR04MB5327B1CB6C6BC7D293701F1D8BA70@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com> <1544445555-17325-3-git-send-email-pawell@cadence.com> <87h8fkmfar.fsf@linux.intel.com> <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com> <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com> <877egfmdxk.fsf@linux.intel.com> <VI1PR04MB5327B1CB6C6BC7D293701F1D8BA70@VI1PR04MB5327.eurprd04.prod.outlook.com>
Date:   Wed, 12 Dec 2018 10:34:24 +0200
Message-ID: <871s6nm9db.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Chen <peter.chen@nxp.com> writes:
>> >> >> +    irqreturn_t ret =3D IRQ_NONE;
>> >> >> +    unsigned long flags;
>> >> >> +    u32 reg;
>> >> >> +
>> >> >> +    priv_dev =3D cdns->gadget_dev;
>> >> >> +    spin_lock_irqsave(&priv_dev->lock, flags);
>> >> >
>> >> >you're already running in hardirq context. Why do you need this lock
>> >> >at all? I would be better to use the hardirq handler to mask your
>> >> >interrupts, so they don't fire again, then used the top-half
>> >> >(softirq) handler to actually handle the interrupts.
>> >>
>> >
>> > This controller may be ran at SMP environment, register and flag
>> > access needs to be protected among CPUs running.
>>=20
>> in hardirq context? When interrupts are already disabled?
>
> Interrupt handler (hardirq context) at CPU0, and process at CPU1, eg
> role switch, unload module, etc.

the process at CPU1 would need to disable interrupts (spin_lock_irq() or
spin_lock_irqsave()), not the hardirq on CPU0 as that already runs with
interrrupts disabled.

https://www.kernel.org/doc/html/latest/kernel-hacking/locking.html#table-of=
-minimum-requirements

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwQyBAACgkQzL64meEa
mQZ8CxAAvjH18/fOPM8pCR/Wu8JM3pC2RH0ACJcypp+6QdyCQrRBCrDHetCXgIBH
INpwQzkJGW8+d4zkFAUgVtuWkKCkNyoMFw9jR1cQSVGyem+S9HN6AR78ufEeXJ61
pCna4GCRwEFdzHLUnEaPEh+q3TUSO1n0zE/afibTkpW+Jh6u7wgtLdOL1m8HaG7R
l5taWIvb/RL+pH2Gbbv/7SebacbpK/cf6gSGBbR6LgAvweCDUWdeJJluzY+m9uDp
uhwZ3mXvgV0MiQbTRk9j1QclyGNBJrXOOzBW84v8Tnu4P9kCbXVJpwuPAsJZQS7T
H8q9s3NUwDKHcAjExzuUdtOwmbdBgbd0IPkwSstuIsKvav3TwtNae0o39eAE5y8S
Bx1ulfD9XRaQiWSHo6UTH7wOJNtkQCvcAIirEMnlomKSwwAQTQ6Tmrdh5/hd/OI/
qY7LsmZfN8yZ+1KhKWlJyZJgabw9WIEaesmPwwFfS1dskDMAwoEegrK4azDprALC
6IxDj6oQ05irTwEu8ICFvYkzuBZ5tGEwmNKtnVJxzvbmUQBgoGGlPppVLexBSXdP
fRDLzuI4hX0g4vifRo4qcJS4U3yOuJpoIybY4ZSsOPefwA4DqHxG0M8Iqi1Qe84y
+e20v5AQnLxxUrC+XnwcW37JoGA6uukzyYijQrvPfngpllTr+fc=
=spIR
-----END PGP SIGNATURE-----
--=-=-=--
