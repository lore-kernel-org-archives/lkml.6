Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8402083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550787349;
	bh=T3x5sfa4C4klR9s+/ZwWTr2ikAsOsEso0k3F4YSs/CA=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=isuIX4auLJihnr4F1v4HCYcToMnWSLDoCZT9oOilAk5m7W/8Moyx/pL8rW4klhiQ9
	 8ZyM8rw3A9Vqk00rUq0TzGnJJpOi7BGND6dm0MnLJDA5pFEHEGb3iCaGF/nCjlwTOw
	 pa6HTQbw2lUXAI/G8oTiSgRaRUqZwcsvQpo/ALrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBUWPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfBUWPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:15:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0A120818;
        Thu, 21 Feb 2019 22:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550787346;
        bh=T3x5sfa4C4klR9s+/ZwWTr2ikAsOsEso0k3F4YSs/CA=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=iazhFoM+LU2/JuO2EaR6AJJafIatALx9xLQjaKMVbg762wOFCTfL8RdYm0hOPFeZV
         4ZaCI23Tuv94eA9D3eL+B+KqRjmJDVOrwLWD0OzCZIqchKKGhSbD2dqH9O9I5mSyCi
         irtT66dSaMO3llc41zmY2+AO5rDTM91GDCTLCc3M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/7] clk: stm32mp1: set ck_csi as critical clock
Message-ID: <155078734599.77512.16179396772771352435@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com> <20190214104047.1173-4-gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-4-gabriel.fernandez@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Date:   Thu, 21 Feb 2019 14:15:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:43)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> ck_csi is used for IO compensation so it should be
> considered as "always-on" and kept on.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

