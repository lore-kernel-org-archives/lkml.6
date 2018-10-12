Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_SPAM autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446B0C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A73D20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=plantwatercooperation.cf header.i=@plantwatercooperation.cf header.b="01RNs/xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A73D20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatercooperation.cf
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeJMUDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:03:06 -0400
Received: from [185.230.160.198] ([185.230.160.198]:47916 "EHLO
        vps.plantwatercooperation.cf" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbeJMUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:03:06 -0400
X-Greylist: delayed 18107 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Oct 2018 16:03:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=plantwatercooperation.cf; s=default; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1tFrE/2FdmQimDNJ6BLgtdFkgN1XYvLtZ+xuNsU92hA=; b=01RNs/xc+Hx3BL65GZa1Irf1B
        lu428H3TnA3rLE+9JqlrYNu2WqQbQ8b36OyvTongRqZQrSfsxq5myT56uBoHnlkjn3yEAoUkkLCiU
        Sw87YBsyz0ejqNazRIXKS/npUO3sicJIlMjLWdZid8WRVOm1HTv2W81XrepT2BJ9lHCr9oL+Tg+Wf
        EQw4Z9jyqOxFqEN5Ev0oS9uA+Qo3zT0XXQaFO5DBDCb3nVmzUO1bPosofi6jsdbkfj3EJujb39r7D
        9LQ1rOgafDjDYHEUA/LqnzPbbmnr+nmxuC6nYcZVqqaqI1CjEZ0vEuJbymLdy/g5nzSDaZF4UB9Ji
        XBZlvSOrw==;
Received: from [185.29.9.94] (port=63289 helo=plantwatercooperation.cf)
        by vps.plantwatercooperation.cf with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <postmasterinfo@plantwatercooperation.cf>)
        id 1gB5Bv-00059N-Po
        for linux-kernel@vger.kernel.org; Fri, 12 Oct 2018 17:41:51 -0400
Reply-To: peter.wong@p-wong.com
From:   Peter Wong <postmasterinfo@plantwatercooperation.cf>
To:     linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?7Jes67O07IS47JqU?=
Date:   12 Oct 2018 23:42:16 +0200
Message-ID: <20181012224846.97323ADE43FCCBED@plantwatercooperation.cf>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps.plantwatercooperation.cf
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - plantwatercooperation.cf
X-Get-Message-Sender-Via: vps.plantwatercooperation.cf: authenticated_id: postmaster@plantwatercooperation.cf
X-Authenticated-Sender: vps.plantwatercooperation.cf: postmaster@plantwatercooperation.cf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 =EC=97=AC=EB=B3=B4=EC=84=B8=EC=9A=94

=EC=97=B0=EB=9D=BD=EC=A3=BC=EC=8B=9C=EA=B8=B0=EB=B0=94=EB=9E=8D=ED=94=BC=ED=
=84=B0=EC=9B=A1=EC=9D=B4=EB=A9=94=EC=9D=BC: peter.wong@p-wong.com=EC=97=90=
=EB=8C=80=ED=95=9C=EC=9E=90=EC=84=B8=ED=95=9C=EC=A0=95=EB=B3=B4=EB=8A=94=EC=
=86=A1=EA=B8=88=EC=9D=84=EA=B8=B0=EB=B0=98=EC=9C=BC=EB=A1=9C=EC=84=B1=EC=9D=
=84=EC=9E=AC=EC=A0=95=EC=9D=B8=EC=A0=84=EC=B2=B4=EC=9D=B4=EB=A6=84=EC=9E=85=
=EB=8B=88=EB=8B=A4.
