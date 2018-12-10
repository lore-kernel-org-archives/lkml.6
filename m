Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE297C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921D62086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544469015;
	bh=DbAWpKE3+SYjrU5DUVydxyLp3okdkPnWeziU6y4s2QA=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=e1DsCCL0hwxsu37b2/mtoAB9c/EB/hXXgKv01Cz67FrT9yRBzLfklwoLuKxSTIncH
	 zTcLGfdIdc9ATGGHtEiMSV1E7E9jxZthWyOkEiZ2d/z2Bc7SZbNGEyEyNJK/4dNde4
	 oyCVHs+8iOlPVuylrenDlP5eoMsPILT4Obs/bR24=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921D62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeLJTKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeLJTKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:10:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F7042084E;
        Mon, 10 Dec 2018 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544469012;
        bh=DbAWpKE3+SYjrU5DUVydxyLp3okdkPnWeziU6y4s2QA=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=duPlOklCUehDaYI+/zB2WCPFEcEDx96HIUgHA3p16wSBJVEHsn+LsFYwEPdAi9TwQ
         mm/vZrJ9PfPzzObzqAcvy4sqj9NRxB8Rzq9+sPtpGfr4pxdtpjSQi7LE5h8LyYu/zu
         tNVfWBLYusGZdGo/VA9MqhNeDvcica+pSb641OIg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181101015230.27310-2-marcel@ziswiler.com>
Message-ID: <154446901163.17204.6201169407993786107@swboyd.mtv.corp.google.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/3] clk: tegra: get rid of duplicate defines
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181101015230.27310-1-marcel@ziswiler.com> <20181101015230.27310-2-marcel@ziswiler.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 10 Dec 2018 11:10:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marcel Ziswiler (2018-10-31 18:52:28)
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Get rid of 3 duplicate defines.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---

Applied to clk-next

