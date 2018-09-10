Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6FFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786532075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786532075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeIJKhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:37:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:29409 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeIJKhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:37:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2018 22:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,354,1531810800"; 
   d="asc'?scan'208";a="231554382"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga004.jf.intel.com with ESMTP; 09 Sep 2018 22:45:09 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>, yinbo.zhu@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     xiaobo.xie@nxp.com, Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com
Subject: Re: [PATCH v1] arm64: dts: dwc3: Add description of 'configure-gfladj'
In-Reply-To: <20180829073324.36866-1-yinbo.zhu@nxp.com>
References: <20180829073324.36866-1-yinbo.zhu@nxp.com>
Date:   Mon, 10 Sep 2018 08:45:05 +0300
Message-ID: <87y3c929em.fsf@linux.intel.com>
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

Yinbo Zhu <yinbo.zhu@nxp.com> writes:

> This patch is to add description of 'configure-gfladj' to binding
> so that configuring devicetree

commit log looks incomplete.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAluWBOEACgkQzL64meEa
mQbtGQ/+LNUqsxjOaN53sIMMZIQNLmzoCyQgsnOYLeurdEelmb0LRwQpsW3YE39u
qlGfxZ7a2hFMN8JZwtWAm5iox8tSCwIULOTKC3Ic6maAcjpuoqgZByLxFVTBS6ez
TQLy4a820xCQnAGTQjIB2KtyPMAfhp9AvrqKXNdCOFfB6AGdUMvbEqUFp4zKPFTz
aPFM6Q/4mja0kvwsrG+vJGE2OGyF6uxydXMP3PMolHcewD0GXGc2t1eSI90Gj76x
/iGEBzrh7+WITxAgase3PgEBc4F7uObhtFOBW6FMcB01Nb/U1aH0U3JA1gUXSKHO
r1OBeOHNJbVq++bVOZY+QAoGOsC/x6vIpTjMtbEgUnXKvbWJWmho8w+ncUz6h8ug
r1l7dXDURtlbfgli6fX81arTDPdjLFsNaBl/opoeWxct/1wjt00ynX4Q7XnsP6YW
VtcS/Ke1cffwgo7kaPMlry5Fh1faAuofCRd/1t2igJxcNS8N44C56y5KOhkYXN2x
qt/9onpKVIIaDS2TsUVHP4zgLeB5NEBWH1pu8yM42p0JgSlRn3Hrga/S+m5L9+gD
Ub3hpyYWLtDCK3Hx4J+LsJmOQr8H2g9IFEJTWarBuBM0pS2G3Au9Q42opinG2aXu
a8b+OZ6XiptN7JnUpbiWtNPF1ENkpSYE0l+wHAmKekkvdK/9Wz4=
=a+vo
-----END PGP SIGNATURE-----
--=-=-=--
