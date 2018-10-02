Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D614920878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D614920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJBOW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:22:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:38340 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeJBOW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:22:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 00:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="asc'?scan'208";a="91356847"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2018 00:41:00 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     linux-usb-owner@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc:     pengbo.mu@nxp.com, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v6 3/4] arm64: dts: dwc3: description of incr burst type
In-Reply-To: <CADRPPNQQE1ESJ5WkMxySstxpaQir-w5XOdiwDe3qTTQ_cim5Xw@mail.gmail.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com> <1532341959-3478-3-git-send-email-pengbo.mu@nxp.com> <20180724232018.GA16709@rob-hp-laptop> <CADRPPNQQE1ESJ5WkMxySstxpaQir-w5XOdiwDe3qTTQ_cim5Xw@mail.gmail.com>
Date:   Tue, 02 Oct 2018 10:40:56 +0300
Message-ID: <877ej0aj93.fsf@linux.intel.com>
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

linux-usb-owner@vger.kernel.org writes:

> On Tue, Jul 24, 2018 at 6:23 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Mon, Jul 23, 2018 at 06:32:38PM +0800, Pengbo Mu wrote:
>> > Add description of 'snps,incr-burst-type-adjustment' to binding
>> > so that configuring devicetree.
>> >
>> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
>> > Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
>> > ---
>> >  Documentation/devicetree/bindings/usb/dwc3.txt | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Hi Felipe,
>
> What do you think about this patch?  The patch title prefix should be
> updated from "arm64: dts: dwc3" to "dt-bindings: usb: dwc3" though.

Can you resend the series so I can apply?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAluzIQgACgkQzL64meEa
mQbSEhAAvdDwFI5j5rxxGGRDAllP9Ha9nEOuuG84KjiEX6bBTQGhHX4aDoPwQ4to
AT7dX97D2359hVXnkPzhHDV2f5jKSfkrFhiufUft2zREYX+J7aPeQcGsX79oXKQo
ivoumKniaKjowRJy7easI++FKmDFKID9WBvDQ7nedDrwO5jxw+I9WqNO1vdfRGOe
yWIgtCMIWYGvDV3WacRBSi3tPOunehQ4RKm+sQYIpLU309eg858YK2ACJi3uFGOL
+pKHC2GpGguUHDufMLJeGjF97y5lSUXRjUlfA8aebr3/i6Sl1KFb3X2zZ7KsS6fk
HTW7YYNjm1+jWVRGe72Sd/sAzAG1UOQJNnJ80Aj/PGjk9Q1dz5tVE8TA//CPHRFQ
M+JBobt4HxI0XVwumUrsOEODwbzjmgoK+J5J99tTb4Qb+nMhfFsBPa2OfSPGIyIu
J/jSheTa8LWSHF6W9lDa9iEqS9vHGzdlRmLvdx6OTw52x6SZXkrm4ZS9IpBLF95p
yMZmQDcXF/mHp2WfyUEDWbkenpDyj27svwcNW66vtX3eYiEtzAXeqKTS8XK1AMFY
NZP1AnDtjNg2K2i+kgFQspvnxM2TxpB17aEgv9vJmQS7pLLxGwk1yYszbL7/iW3F
iGs1kyGJLvHQHhgUIIRozuhaytLts61tnJUR093dLQOsSHgDNe4=
=m67N
-----END PGP SIGNATURE-----
--=-=-=--
