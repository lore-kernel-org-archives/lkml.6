Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3720C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA3720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJIMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:52:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:2251 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIMwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:52:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 22:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,359,1534834800"; 
   d="asc'?scan'208";a="79883251"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga008.jf.intel.com with ESMTP; 08 Oct 2018 22:36:51 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Anurag Kumar Vulisha <anuragku@xilinx.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen\@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
In-Reply-To: <BL0PR02MB563373F068BC275BCB14DBE3A7E60@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <BL0PR02MB563373F068BC275BCB14DBE3A7E60@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Tue, 09 Oct 2018 08:36:47 +0300
Message-ID: <871s8zptow.fsf@linux.intel.com>
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


(no top-posting, please)

Hi,


Anurag Kumar Vulisha <anuragku@xilinx.com> writes:

> Hi Felipe,
>
> Please let us know if you have any suggestions / comments on this patch s=
eries.
> If you feel this patch series are okay, can we proceed with them?

I really don't like this dwc3-specific timer. The best way here would be
to add a timer on udc/core.c which can be reused by any udc. This would
mean, of course, teaching udc/core about streams and lettting it do part
of the handling.

Best

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlu8Pm8ACgkQzL64meEa
mQaqhA//ckgUXIdmIfoE4VgRkjG2wdD4R8YiV/7hWue04nGbuDF/hTaZ5R24xQDf
4vCfl0kHlj2HyQ2HaxvpniVLi2OY4Fpdxg9Bq+E9EgB81kEJATa7H7O+ieQzOG9x
A0Dznj9Fa6VfHGJQHwI/fndujxwzUtTd0aWcz7KnGlMjiHCd6e2lkFYgjtsfbcFu
ifuUcVHwLhiro4NuQStH3VjnrtgIYRP+N3s+kMC7UpS1JvKy7IsMZV8hpP8JO7dn
lB780TpweqAkODPWZ1AAvmfGouiJuc+6QYKI+S90tNzuQyOWmOn5g2Afkn9WQX9D
slXQO15Jxr/7mTnugkcXnF2dU+NswOwVEhtnEYjQlGH3ajSehrJJz6GvUgj8yUpx
XKlhhMwDXLxM/INrVXh6jIRQ3mMPXvLUvRfumX7FA6bTkrWdPXlEPlKtHsjWWJAh
Bz+09yrZIuJkakZ5QJMRWnVycR3+HEgT6dTySJtjT9VVxa/Iu/m0LFb59YkvdU8e
f4cCjpkQ7BIIR6VViAVtjErZ9UUgQO+Zi1vEVGMmQ6Ayx0xbmcPq7MIYSbZDcB6E
LOAGLd5vABZI12BiapPKnB0nIaqMrWdhZ2VlAun2lBtT16rWDjr588m3fK+lR1U/
l1Ye0mRUDpnoMgaxDizCwokPrA+oeHJk4O//b0iyV5RvPsBhnlw=
=g7TO
-----END PGP SIGNATURE-----
--=-=-=--
