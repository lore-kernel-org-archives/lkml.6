Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A601C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0371B20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0371B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeGZM3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:29:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:18010 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbeGZM3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:29:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 04:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="asc'?scan'208";a="67687797"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2018 04:13:25 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Pengbo Mu <pengbo.mu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ran.wang_1@nxp.com, pengbo.mu@nxp.com
Subject: Re: [PATCH v6 4/4] arm: arm64: dts: add property snps incr burst type adjustment
In-Reply-To: <1532341959-3478-4-git-send-email-pengbo.mu@nxp.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com> <1532341959-3478-4-git-send-email-pengbo.mu@nxp.com>
Date:   Thu, 26 Jul 2018 14:10:07 +0300
Message-ID: <87a7qe1cds.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Pengbo Mu <pengbo.mu@nxp.com> writes:

> Property "snps,incr-burst-type-adjustment =3D <x>, <y>..." for USB3.0
> DWC3.When only one value means INCRx mode with fix burst type.
> When more than one value, means undefined length burst mode, USB
> controller can use the length less than or equal to the largest
> enabled burst length.
>
> While enabling undefined length INCR burst type and INCR16 burst type,
> get better write performance on NXP Layerscape platforms: around 3%
> improvement (from 364MB/s to 375MB/s).
>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>

will this go through arm64 tree or do you need me to pick it up?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltZrA8ACgkQzL64meEa
mQbNthAA1avK609b6EdzdZ55k811FE+py4ljrSxVofYnM+xASfnzI/N336dAgcF6
M34NdWJh1oHF0ZKFC/O9lCm5XdKraqfUK8q4etyvDWRmhSoijDJ2QgqNkPSEpuSH
6XU9wMJSZZECww4LK+Ov9F948+BOcN2qTk1TC9eC40cExVlYRZ2RLkjfj6uARsCf
STiN4dtKTpfWha+AzCzRfnY4gQLzKUtHHm9Fr1/ws8Wgq9PXe5BsO64bVnoNa1Kd
FW4c6bckJOKxk7pa7aCaHzpihm205XN8WyOz4XUUJIpgpnK0pKJoBbNZhAXdNKJS
hGZ6pQsFNKHABKLSl9iDMnJopH7QFP6TD3I/zREOfIRLoxPg7oPwHl790x4RPskn
SEpSWi7GlJ6+C1F/K6yGvVUM7bVSNu5/JXLrlzGEM+QUVm/q2rWJj1G2aQt4urwe
M7qZRQ6kJv1RXWjJbpm2vRLCO6Z+OO2bN9Qh03F3dZd6NUWDY7DoE/t1xEW6Ws6n
eZKEohFY6FeV/B7olq/YxhhH6JvuW+oSy1ZHp2g0FUZqstVF+coMQCo0Uk8bZ1kQ
NkX7iGw2JXMjdjtDMwUfCac00Pg/oOlSwNiNJ8hXXIDR504aTRPa1wUTtkDbC3sn
0fJ2reU5N646NpaUL7gchjJbVZRuFqiOqM8ML2ji6P1H42sfTN4=
=ESN9
-----END PGP SIGNATURE-----
--=-=-=--
