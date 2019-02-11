Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7725DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8FB218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfBKNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:21:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:41533 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfBKNUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:20:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 05:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="asc'?scan'208";a="132677991"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Feb 2019 05:20:12 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede\@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus\@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko\@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3 driver.
In-Reply-To: <BYAPR07MB4709A40204EF528F8A04E1EDDD640@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com> <1548935553-452-3-git-send-email-pawell@cadence.com> <20190204114502.GA28608@kroah.com> <87y36vmyeb.fsf@linux.intel.com> <BYAPR07MB4709A40204EF528F8A04E1EDDD640@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 11 Feb 2019 15:20:04 +0200
Message-ID: <87sgwu5unv.fsf@linux.intel.com>
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


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
>>>> +/**
>>>> + * usb_decode_ctrl - Returns human readable representation of control=
 request.
>>>> + * @str: buffer to return a human-readable representation of control =
request.
>>>> + *       This buffer should have about 200 bytes.
>>>
>>> "about 200 bytes" is not very specific.
>>>
>>> Pass in the length so we know we don't overflow it.
>>
>>agree.
> I also agree and I will add such parameter.=20

https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h=3Dn=
ext&id=3D7790b3556fccc555ae422f1576e97bf34c8ab8b6

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxhdoQACgkQzL64meEa
mQb5xg/+L1jMjt8wc4bizrfHHLF4BcSWh3E63cm3aukB/l/O8A+eCOkarrfXNeG5
4fSJJmUo6HHFPbVqXUa5sQDY/8TOunHtrUIeJLAVBwXsYcJgld5ii6y/F8q3Ehdv
X+bw1bg3USH1nkfj/xIOAEbD0z5IyrHKr7HiJNF2wWC4TPwyUS/yinQIMUDiEg+k
Xj4x/fT3ddVqvWVysHd/QoEqWFk5K3Neltv6aPLG2aByh2MU7+TrRDv1mzcqlVpD
SZjxGSjF05mFhT8Hs3YZMH41CBBwzlta5foNIF0CYFDEjjbn369z4ihAN3UeK0Ae
Dmvh2UzDkZUPSAmp06zKRW1Hrm87pep9OsFBecr0I5HEVVlXxNSCCtiRTm72RCEz
pvxz0sMepbI03SSYbJ/jJQJeKuZ00FrgaAeW+X2PIz9TxtiW9vDRsPLLKvezBIes
1m/Zs7u2vaTsulSMQWnRsN7gFtDv7w2aEonOtarysTlNZy5ZQjCp0G8XwgnDPPkH
uRMmIn4JwsEPpsrocvrFTrCSHQy7c6WfnY7ExCAM3svGf90DjRZPzCLZCm30tQKB
27Qt6AU68Yl762ZoVpFI9LgN/QzYMN8T9/v9VFgDDzo4IUxoEEsHYvgfKvJz+2hq
jD2KcIGwRoD2gkCFe4b+lOWcSdj3fctFXk3yx5XQCFV0KU7dmIU=
=rSxT
-----END PGP SIGNATURE-----
--=-=-=--
