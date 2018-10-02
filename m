Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731F0C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382472089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsXGVLa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382472089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJBOAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeJBOAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:00:19 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C0652089A;
        Tue,  2 Oct 2018 07:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538464711;
        bh=gv8XA+Oh9Czgq+uiOsbl9jkuVzFTFtx2fdGGtyrtULQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tsXGVLa5q5QJY19wSGB+nxU1gFWqPNRAUK2vTRU9xQIowE5PMmO/7zfPJ0+qWxaBM
         8mfg99R6WVul2+HM2cZakfx243ji+LWsph6gK8wEpASSS7CcVc4NQ/8gCdn7sELsor
         gAyL5IOC7uiQiPSWF1EWa6Rbpu/gHjSXeMCPTfQc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180910112654.42061-5-lkundrak@v3.sk>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Lubomir Rintel <lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
 <20180910112654.42061-5-lkundrak@v3.sk>
Message-ID: <153846471096.119890.948010578540326036@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 4/8] clk: mmp2: add SP clock
Date:   Tue, 02 Oct 2018 00:18:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2018-09-10 04:26:50)
> The "security processor", sometimes referred to as "wireless trusted
> module" or "generic encrypt unit" is a low-power core present on MMP2,
> that has nothing to do with security, wireless, trust or encryption.
> =

> On an OLPC machine it runs CForth and serves as a keyboard controller:
> http://dev.laptop.org/git/users/wmb/cforth/tree/src/app/arm-xo-1.75/ps2.f=
th
> =

> The register address was obtained from the OLPC kernel, since the
> datasheet seems to be the Marvell's most important business secret.
> =

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

