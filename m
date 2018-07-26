Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8503C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADCB2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADCB2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeGZMNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:13:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:26618 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbeGZMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:13:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 03:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="asc'?scan'208";a="243482752"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2018 03:56:48 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v4 1/3] usb: gadget: ccid: add support for USB CCID Gadget Device
In-Reply-To: <20180626081422.19237-1-marcus.folkesson@gmail.com>
References: <20180626081422.19237-1-marcus.folkesson@gmail.com>
Date:   Thu, 26 Jul 2018 13:53:30 +0300
Message-ID: <87woti1d5h.fsf@linux.intel.com>
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

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> Chip Card Interface Device (CCID) protocol is a USB protocol that
> allows a smartcard device to be connected to a computer via a card
> reader using a standard USB interface, without the need for each manufact=
urer
> of smartcards to provide its own reader or protocol.
>
> This gadget driver makes Linux show up as a CCID device to the host and l=
et a
> userspace daemon act as the smartcard.
>
> This is useful when the Linux gadget itself should act as a cryptographic
> device or forward APDUs to an embedded smartcard device.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

I still don't see the benefit of having this in the kernel when
functionfs would do just fine.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltZqCoACgkQzL64meEa
mQZz8xAA2b1nuzvzDA/qKsjrHCHNpVqFsA2h/LEQyb6jEaQL3E7Ycw1SQTqT28iB
TE8VglTkgvVDNFEPiy49uqBwO3Ey50PESaBSeERlXqubdVndv/wMH0CdglwzMc9n
K/LOnVlLNg18vF3BJoU5dyGnjPlBH5ry1umwJ0HxCgd0VdBmmiy0TH1OdGabuo4u
ywEH6iYqBKaBzSSeRO0kn1nWGLThSVCuWQGb+Ilejr2n1bDoykJA+OPQ/1sr/o72
gfmQkp9xcZ1ixTaZQCsTswAZKLntdkpb/f2YgmCrLfsXbtRedQQO4RNdR5E2br1r
vMXrJsHKd/EJI7E+wHIZ1YSvgYFnWhPZf9MbAjK81tTIuPPx6lBr/MWJuFMULsDf
dZmDpOpYUW7BTy2vFuwdPRzM+zoo8gg7CKwJJd41paE4UD+tL3i8KumsI3EFxoFz
X2WcCB23fJ9Vb23AP8qFSPYqmqyWshHWFD9gi67tJqMbIVy7h84zgKTYhtDAx48x
Tn7pegO71A3HyXLwJpMroBLPhQ90K01SIsOrGuxNdUQzZdUJxTzpE4VASqiOQzKT
FvAPhgY8EYWkJRwATs+fDGH7ghMtpwEUeuZMrTQ/v95nSlAFfF6WqZA/iMIE23hs
drfYLwCU708gpl5W/F5AixyHAZjxwaF8Yybfzeqi+hIW3nfl+qA=
=PHQA
-----END PGP SIGNATURE-----
--=-=-=--
