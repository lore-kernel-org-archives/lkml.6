Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA83BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76E620989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544030716;
	bh=ueS0tTmeDL37FA7NympmogG0iag8ve9D805oTp+gr2g=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=w6RPl1wnYzWcfD+d859R4/+tkcaNSamCXoYFqNusBEy4ASJO3ZympT4FVQeC5nDyX
	 TphWUAjvTX78frqTo10FRC1XT5GmQl+aFZr1BuRfKOuN/oCtRIQHwIqyc0q1ETiL7i
	 K3JljERyuZkMayLya6lT8I2AeBgDwTtsKx0+j3Hs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76E620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeLERZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbeLERZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:25:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF8A20892;
        Wed,  5 Dec 2018 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544030713;
        bh=ueS0tTmeDL37FA7NympmogG0iag8ve9D805oTp+gr2g=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Luhl4YVXaP9CqOJiZFA5imcvVafySIZDM+F10h99TbaIfwvSXh+h3BS3wVnKYGNy4
         zwMTeaeBemJUANe1+dmQYk+AMfJyWNhj03QUapaXQA0q7borXG8O8OBMRrRZZf4tXE
         +KalqxZNdOOAadY7bnK2F4BXLY4cModHdr5hukNc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <d515dafab5f22e24f3c6dd9606993e3e1255045a.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <d515dafab5f22e24f3c6dd9606993e3e1255045a.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154403071306.88331.17259048442768615722@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 07/10] clk: rk808: use managed version of of_provider
 registration
Date:   Wed, 05 Dec 2018 09:25:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-04 03:38:03)
> Simplify clean-up for rk808 by using managed version of of_provider
> registration.
> =

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next

