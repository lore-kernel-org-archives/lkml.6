Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C0821924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550212492;
	bh=Koq/By03Fqo70AQJabU0pv/6l1f3avPpuI7nt1i27+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=q6D2iU+372eSsdyq4AF/Zy+ouZaqWDvHNbkMJqxLsCpqq9vuLy5lhIgd1zAVAvd7V
	 cu45ZptZNUZT3v/10DYse+3GnOtaw3PumOg3+MENDTQlI0vMAw+gl2e3gorzqOuWvh
	 9XxxcRj6xWWTqb670vIU0lwEvQKNWi2G7i0bTfcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbfBOGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:34:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:14746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfBOGet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:34:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 22:34:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,371,1544515200"; 
   d="asc'?scan'208";a="118117026"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2019 22:34:45 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kees Cook <keescook@chromium.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc\@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: add support for r8a774c0
In-Reply-To: <TY1PR01MB1770317703AABF9DBAFD2FC5C0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732635-7367-1-git-send-email-fabrizio.castro@bp.renesas.com> <TY1PR01MB1770317703AABF9DBAFD2FC5C0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Date:   Fri, 15 Feb 2019 08:34:41 +0200
Message-ID: <8736op4l1a.fsf@linux.intel.com>
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

(no top-posting, please)

Fabrizio Castro <fabrizio.castro@bp.renesas.com> writes:

> Hello Felipe,
>
> Who is the best person for taking patches for renesas_usb3.c?

they're already in my 'next' branch. I'll send pull request to Greg shortly

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxmXYEACgkQzL64meEa
mQZGcxAAvQlccQ1au/kz+gm2fxQO3IaSTvcAf/P63MhN9LzxgDI2RC82lV/Jxmry
LQ8mGyj37lWV1bqWxOXaT/bANhbroDjBAWQq7x1MxMeK1+H+fnmoWPCdOqdI1fzX
OIUk4hRiLCNFOJOvcUoxtHUsMWOnRtW8Xs9r+lcXgw7bGsfSg8x6kxDkqF/cq3q5
TACuLB42l4zbr6Ztc/px0d0N8ie3EAW+4fyX5ZDf0hwrz187U6dhXODOEQrljJNg
8Y7iwfZ5R7Ntl69Dghuj0zuBLuvKQK6ek1YBcTzczGsb26dDAGxo5/AuZY1UFd5V
/A/rn34zI4KkTc7glhWUyJ/FKwKSC6ztTxUkZOBUZJnKDEXtMSwdDx++hGdAUoEw
KAHKUxYosEkAPBznFriLhkshh36FywZ+zmtDWyvTZf/J5jIcMXWVbJ1lMPcc6Acq
gvCuUc/Oa6vu4WR6rcwQtLzMQgV5k3IXIPZZiS7+L1FUKEKZcWcBRUFjBskpTwxz
UxHTbz+fqg9eGVRLFX8mmnf4Rqx/iCuZlDB391w7reipxLh0rky7AB1PEi2AnsMR
7CT2CIR0O07tXgR8bx/EIl4sDhYF9WC3yIuGXksxsmOaUyYAPTJLZvKQq+9xEwEZ
a7xkMsSBZMEuTxmcTBGqUVibULqTfP28iSQiQqM4M/MYMCBv5v0=
=ursq
-----END PGP SIGNATURE-----
--=-=-=--
