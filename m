Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64191C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5CE20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5CE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbeG0JMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:12:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:31574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbeG0JMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:12:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 00:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="asc'?scan'208";a="75966100"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2018 00:51:41 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        gregkh@linuxfoundation.org
Cc:     v.anuragkumar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH v4] usb: dwc3: core: Enable AutoRetry feature in the controller
In-Reply-To: <1532677280-30945-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532677280-30945-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Date:   Fri, 27 Jul 2018 10:48:23 +0300
Message-ID: <87h8klyv94.fsf@linux.intel.com>
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

now applied. I've slightly modified commit log to make it read a bit
better.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltazkcACgkQzL64meEa
mQYfAw/+MRkM/SA1S8e/iGhPG6Vaf9RX5vl+/s4u1mnga6Q0+yudNlUoJL0JXlHc
xlvKVsy+IFvgqRzAwFcu6OaZp7YsR/vLl58P7O+UHk7wqaWVVocpNRc+y3DV5Te4
1AvI4WOpexanGYb9B/yLekMKNMLpMdw/Mjlu7NYoEekZrONEP0Bbvx7OsSI54Q8g
u1AScayVpiaAmVZpjUYKgRNFldBSm7X8X8rJMq5vh6QikiatkC98ewavINnurFXQ
ajrbcM/p5J2HD8HhOlHZIDj8YCevSe1d0lBO1mxGak4sZEaDt2+dAPmZsmdlfrt0
V1SvBUT+IHQYkafNnLhpiRP9M22DgP7e7niz2s4af8frV8c38J1ErN5fLpy4DEJt
qlKkakiGasKly/dnjM8TlCc/4oXQdquOuWRcNn7tL/mRfAAX+foYLWuZLdakgIpE
sB8aDuBziaPrgWSaOKDXp5/nWWNValyqn8dnmVVr1osjdxn5yYWLMt414qLHl96f
LxEOPYykpO3iersaoyWhlja0zseB+xLDgoyWptbVy0BfpWvPD5b1xShAwcdPzpY5
EfZU2fMBTQx6viP1OUbgqJ6CWAb4xE7dmwhDZ3KxqzLXXYtI4XJtJvoOaFk5s9DK
fLnkS+XLNUtB2zVk8ylyoNGL+6KoHAK9GfCbYRNjF4LA3jbFgwE=
=Jni9
-----END PGP SIGNATURE-----
--=-=-=--
