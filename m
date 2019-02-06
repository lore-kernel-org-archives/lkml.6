Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02BBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B159F218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549435929;
	bh=VX+Dvp+yU3I5Pb/WBaEoJuRvTu+BDJjoYUNN76KcxDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=YwwsDqz/LMV6HqEFtH7VJmXR/EemLm5fQM6OaKp8fb4hUX59DtQV2wnJMHbrFB8H3
	 d/KfcaaNJjcWWpFnKfR021Bb10CffzumSyPA4CMiMyzxE28Mg6XbHAVTw469r51Nht
	 Gayl+Mp9tK8lZe5TX3plsryivEcIE3DrlWykkD9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfBFGwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:52:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:3243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFGwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:52:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 22:52:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; 
   d="asc'?scan'208";a="316702156"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2019 22:52:02 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     liangshengjun <liangshengjun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Jiangheng <jiangheng@hisilicon.com>,
        Caizhiyong <caizhiyong@hisilicon.com>
Subject: Re: [PATCH] usb: gadget: function: f_uac1 add interface assoc desc
In-Reply-To: <84923CA334DF85428B9ADCEC0F3CE864055B6976@dggemm510-mbs.china.huawei.com>
References: <84923CA334DF85428B9ADCEC0F3CE864055B6976@dggemm510-mbs.china.huawei.com>
Date:   Wed, 06 Feb 2019 08:51:58 +0200
Message-ID: <87d0o5mmsx.fsf@linux.intel.com>
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

liangshengjun <liangshengjun@hisilicon.com> writes:

> Add f_uac1 interface association descriptor, make f_uac1 link other funct=
ion(like f_uvc) is possible.
>
> Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>

doesn't apply. Also, remember to break commit log lines at 72 columns

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxahA4ACgkQzL64meEa
mQZ6xBAAgk4KFcyrbvLL5rRdGIM0xV907+eFYfkeS1gu54KaHZJtnQ09Pw0edtPW
3NPdIzVQjAU5ao0/9PuHZYG0AYguRRFWrTArdjKfTRBUu2Y1cnP+MBTpvQF7DNrQ
83Hv/NKz+8EfZVpDxSLNRBlV1lRX3b8jG0/AuSlT3VIVOLkHHpzXJYiagTDQ2kf6
1clj2O0GHZUX8oA9rIXgUsKeexQi2QSetbGvuC5MNYfIrOnJCxOYjR9AWXCO7XjG
GQmNYWtlXHsDC/0SLFlEbitRiTdpzfYRKZnnA38jAhOAQjlh4GnztyBhedtnOwhu
9XPis36h+D0AO1RauoxWQxW/Hv3/VHlUJnYM4wFx04xLJUKivy4sE3Rxj4+4M8BO
XLzUkUSEadSr5Tc/MNMZCFN+XxKGCImRdWtA27deTiJPgWtQbMtP8OF53jIElFbm
+c48ewxLv4dMmfl+IHiUN/2CkudmWJor/A3lEbw4QFjAYejNQ1t3Ja5oLnfw6k80
KvIVGohlU2/BuUpI5+XUrLnGinEYx1xbb3CQj/2PtCWskCocqYUeHAQGIl8vNlM4
rF2VdhFJ2XUs0OwIaiDdfvQrL2QP5rIPxvV3cGqYIneWOLnFJN3zLVPsLtpJI4My
peDzip3usK0KywgyirHVEOXC2pQNIfLw7EKLzPRJReoW+b0iHy4=
=tUY7
-----END PGP SIGNATURE-----
--=-=-=--
