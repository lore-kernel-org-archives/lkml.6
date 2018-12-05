Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3AFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4362082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4362082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeLEJNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:13:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:8161 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEJNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:13:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 01:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="asc'?scan'208";a="281079696"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2018 01:13:43 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Doug Anderson <dianders@chromium.org>,
        minas.harutyunyan@synopsys.com, Terin Stock <terin@terinstock.com>
Cc:     linux-usb@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc2: host: use hrtimer for NAK retries
In-Reply-To: <CAD=FV=UpPv3fWFjhrRRj1JjLPecbtzVYptVBkRaFHUgEm=isXw@mail.gmail.com>
References: <153655347149.19910.4781444209586693527.stgit@Rincon.localdomain> <CAD=FV=Vau3KL=hqbu-jx19VvGZ5FZug+C-sxxdw2hiAtCXgBtg@mail.gmail.com> <410670D7E743164D87FA6160E7907A56013A7A9610@am04wembxa.internal.synopsys.com> <CAD=FV=UpPv3fWFjhrRRj1JjLPecbtzVYptVBkRaFHUgEm=isXw@mail.gmail.com>
Date:   Wed, 05 Dec 2018 11:13:39 +0200
Message-ID: <87zhtk1gl8.fsf@linux.intel.com>
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

Doug Anderson <dianders@chromium.org> writes:
> >> Signed-off-by: Terin Stock <terin@terinstock.com>
>> >> ---
>> >>   drivers/usb/dwc2/hcd.h       |    2 +-
>> >>   drivers/usb/dwc2/hcd_queue.c |   19 ++++++++++++-------
>> >>   2 files changed, 13 insertions(+), 8 deletions(-)
>> >
>> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> > Cc: stable@vger.kernel.org
>> >
>> Acked-by: Minas Harutyunyan <hminas@synopsys.com>
>
> It looks like Terin missed CCing you on the original patch.  I assume
> you are still picking up dwc2 changes like this?  If so, should he
> resend the patch targeting you (and including Minas and my tags) or do
> you want to pick it up from one of the mailing lists he CCed?

I'm picking it up, thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwHlsMACgkQzL64meEa
mQZJeg//QeVLQOOVLmZgar3UEoYA//JuFe4l11UAqXHYV34PrTuLai3qOzuFLcEH
VfIRS1Ewo1c9xHjBISMYZxrOEqn7aG3qZJnfvG3tmC705xv2HxuLIuVtTMCpfyXX
yO5uRf1N2ScdngSU7gS8jygc4e/FZbQEuNiecNn7MA+r3lirwWHLjT/EfKVbjwCu
RYN+Ib3HKDlL4sAlQGpYyAZjLTJiHuFEdg2cKYa1KGtwt4ZclemcEdaIfB+zK653
0hdbefjqDAdk01cEYKEfmISNbA1cBTEt8mfdzcU6QY0SDHjP1bl3kuDFx4pt/Agv
9APF2qZSooXfgtVSG3i+YqfgpG4Rxu2AKH9gmjA+poBpSj251hA37ybXiYkqNFOX
Y384WBY/+SZEL9Qb+3cYdmfr3WO4zj9KcOfKjZrInxxvJm8DqJZYBiLe4NRXFU96
hommoLh2woIakaCY/7yWKsDSZbpmKSq4cVWg+GsOOqTZDUyplBWdHOINVH7XiUyf
OKOmLcughb2i2a6qjcbVGX5uD0fewr3KwAcn7Gxy0sRzW0ddy6Y2neNkKb2FPem/
qlbQsKVjQjWg3uWQYATJmO21RfmCGVSjKrGYNQdDXdZkuqbey6eY3XuCHEilIkEZ
6Vpts82IPLT1br+wQyeAFk8iDleymAmzRcurvh3uZ7fZ9Vx+bbA=
=lSgH
-----END PGP SIGNATURE-----
--=-=-=--
