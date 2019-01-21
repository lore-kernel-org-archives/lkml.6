Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D062FC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CC02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfAUI4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:56:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:9797 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfAUIz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:55:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 00:55:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,502,1539673200"; 
   d="asc'?scan'208";a="109803547"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2019 00:55:55 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     "Zengtao \(B\)" <prime.zeng@hisilicon.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC endpoint
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED24E4CEE3@dggemm526-mbx.china.huawei.com>
References: <1548064976-30196-1-git-send-email-prime.zeng@hisilicon.com> <87tvi2juh4.fsf@linux.intel.com> <678F3D1BB717D949B966B68EAEB446ED24E4CEE3@dggemm526-mbx.china.huawei.com>
Date:   Mon, 21 Jan 2019 10:55:50 +0200
Message-ID: <87o98ajso9.fsf@linux.intel.com>
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

"Zengtao (B)" <prime.zeng@hisilicon.com> writes:
>>-----Original Message-----
>>From: Felipe Balbi [mailto:felipe.balbi@linux.intel.com]
>>Sent: Monday, January 21, 2019 4:17 PM
>>To: Zengtao (B) <prime.zeng@hisilicon.com>
>>Cc: Zengtao (B) <prime.zeng@hisilicon.com>; Greg Kroah-Hartman
>><gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org;
>>linux-kernel@vger.kernel.org
>>Subject: Re: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC
>>endpoint
>>
>>* PGP Signed by an unknown key
>>
>>
>>Hi,
>>
>>Zeng Tao <prime.zeng@hisilicon.com> writes:
>>> For ISOC transfers, if there is no available data for a period, we
>>> need to stop the transfer by issue a stop command, otherwise, all the
>>> upcoming transfers will started by update transfer command, and will
>>> be dropped with MISS ISOC errors.
>>
>>We, actually, have code to handle missed isoc errors now. Have you tested
>>with that applied? Which kernel are you using? Can you share tracepoints
>>captured with v5.0-rc3?
>>
>
> Not v5.0-rc3, but I tested it based on 4.9 with backported dwc3 driver. A=
nd with
> UVC application, it's very easy to reproduce it.

Ok, so it could be that you missed patches while backporting, right? How
can I reproduce this? What do I need? Care to give detailed
instructions?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxFiRcACgkQzL64meEa
mQaEBg//SpfB3qvZP3GQIQfPIzacEOeZfvB/iZiCyYHnHHnRgJUwUR/tL3MXyHOf
PCLpu/dqevyTJzq+na+wdhNL3MRuIhsVCd202w4Sa7CdTrYt1UHMoRA2DJH9aTtV
eVHODV891i8Xmo30vcTFUnmoxS0De1mJabIQInuiWnYD5LR0J6tf1RMz1bVL0g1z
esz4pSlf48JGbvTJ8zgr385ykoigReWeG9383rfqKK8WVzpB04EV7YTxTU0ieBbJ
s20B/DBNYLZNp9w2XCMaGU1RYTGKSd5LIcU7EBVnTEzRaGw4bRI35j6kn1+q7B2Q
N889zimCYxlaOoXJrjH7Pu9iw0CzK6nDIPlcZPSxjtYzH7V2dcoLCF998nLN/nZQ
O00DnYut0HpGKIYlTTlxCvffBgAU2uK7QbmjNIOPzG8hB8IYWSUNttAwfkXoyitJ
hJkXud754+IZJZV7LVAB97zHGDRKusQKv/WrJObEqjw9vjf01WizmLz1X2ZaRmQo
BzIc1CiGXkCNauSDt/akiU8njhXUkSEnPRYJA5w/bDZeSQC8AwB69X4reXJJ+rh3
KD0wZTUcuyXUya9yVbsAEunly21PEgtH17LbiZJNBdUQGNCQGgSbvExahy1IVEPt
nrdRgJTSdmE6oVCsB0ubL4SFlOjyZM/spHtwjpGtES1+BLGReoE=
=3nby
-----END PGP SIGNATURE-----
--=-=-=--
