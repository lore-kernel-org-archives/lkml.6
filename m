Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03EAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705FC20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705FC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbeG0IlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:41:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:25070 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeG0IlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:41:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 00:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="asc'?scan'208";a="75959899"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2018 00:20:41 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        gregkh@linuxfoundation.org
Cc:     v.anuragkumar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH v3] usb: dwc3: core: Add quirk for enabling AutoRetry feature in the controller
In-Reply-To: <1532610528-7290-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532610528-7290-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Date:   Fri, 27 Jul 2018 10:17:22 +0300
Message-ID: <87k1phywot.fsf@linux.intel.com>
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


Hi,

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
> By default when core sees any transaction error(CRC or overflow)
> it replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
> Enabling this Auto Retry feature in controller, on seeing any
> transaction errors makes the core to send a non-terminating ACK
> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
> Doing so will give controller a chance to recover from the error
> condition.
>
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---

subject line is misleading, at best. You're not adding any quirks.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltaxwIACgkQzL64meEa
mQYB7RAA2zqNJ0igY/47+trUhOfwGvIPRMr5Tuub9wA5YvVjYmn5ZQYdYRwc0Bgp
JSZPHHQqOijJi6vYseeAf6UbbJuYbX9fXdeRbO5IoM1web8dDSC/uPj4UWsw1r+z
Eeg50yvbT7hrHFNVOl6Nn/krTEcLyq9PUk1284w+OkKOhtYh6q8g61ygjkYJn+yv
PqIvfS2cnQbGGyrKFL2UrAtU/stiX7YSXQvMKQe9efSjtJ0WW2Wln3etuQefdGds
aFraOIKQfsDA/Hb52kh/g71M+sHkye02FCkg+7bYuCJPbwzbw6dbjSCj6Ox2xbLR
udLZbEqkCjpw15i5JkTVW0JkXL3xl+tYYtH4rcp9o5cb3lA1HZD2HNGKr2nRrHZI
5dlU+MWxdsjzic7cptdYrUKtUUQ0yb7ux4Slas2O0vUp/w0pOIrTJcA+yHQrnC1Z
QChmvemw//MxR7247KjwEiWMRq7KmOHEjr9z+oIFyw1aEVuAKYc0WBqb1ota12QF
E/VU+JYkH8E80QEFlGvDrximpeCpKSnQg4nvFOoZ20CBO1C+jH0g3jQecmQyQQd/
iyMFgpIRoNovaa8PaNKxpvAVaUxJFo063f0rde1wkSb5adNtO6zLznkrouqbH/A0
/gWjQ+2tb/zuWz+HyyClJnfYxqqrHD4pfKhf1gW/+LMOxCLggp8=
=hmZv
-----END PGP SIGNATURE-----
--=-=-=--
