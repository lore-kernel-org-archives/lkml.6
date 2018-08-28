Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D48C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0932087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSYVvC0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0932087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeH2Cdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH2Cdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:33:35 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFFB2087B;
        Tue, 28 Aug 2018 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535495988;
        bh=Z8aoeJitO5+RKRAHbp1Tv8rOw0vL93Hjb07SIPgDiNc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=JSYVvC0PQAQIuw/Kx+QF1biI0YuS/BhvsjLq5Dv/FU3nAkMkfMpb++LJu0g+YnX2G
         uKlIjXemrzVdLkPfjr5VeTWZRyDTXue7HMGzsYctkLH0AaXoeznJGU4Dt80tbwYNBc
         3iACSN5fQ8Sopx6PAbwAEjj009m+c2HpXE+KatRs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vabhav Sharma <vabhav.sharma@nxp.com>, arnd@arndb.de,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mark.rutland@arm.com, mturquette@baylibre.com, rjw@rjwysocki.net,
        robh+dt@kernel.org, viresh.kumar@linaro.org, will.deacon@arm.com,
        yamada.masahiro@socionext.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Tang Yuantian <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153549598745.129321.12633089552143824401@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Date:   Tue, 28 Aug 2018 15:39:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vabhav Sharma (2018-08-19 23:47:14)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> As LX2160A is 16 core, so modified value for NUM_CMUX
> =

> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

