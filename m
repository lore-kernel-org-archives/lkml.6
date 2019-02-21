Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C85FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3706520842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550787341;
	bh=cZM8IweXgr/lTlRnpft76/JL+a4vIqjALaKRw7SakvU=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=Hff/Rr/iB3MMsKbuT7Xm9wLRitcGPxvbZIqAaIdx2lOCU1GwcWuy/ZePdP09Aneh6
	 V0YWgLFUPB5iPHXAXaXrKSMB69fOyNEOeYwvDRD1vFbje9ErxGTSV+qHqyAeI4q6L5
	 xAQJeuD8cFQgX6kdSO8Xu11Per0ACOvlRBlqcS4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBUWPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBUWPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:15:38 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6927E20818;
        Thu, 21 Feb 2019 22:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550787338;
        bh=cZM8IweXgr/lTlRnpft76/JL+a4vIqjALaKRw7SakvU=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=zVVdKTHU5ilKZj/B1KICdKpur5cGz0ZcMYVgXw73g+bYe3Ac76dHiESXNvs0UHX9A
         PlQyDbFkcUMYYJUGaKSGTj+9B1ekQwhzASAAdCip34tfQlN/UI2HRa5gdufGkWxMJG
         2idNt+d3v3Jb5igb4UPiw3apaqfOhAbP/e15Mrqk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/7] clk: stm32mp1: parent clocks update
Message-ID: <155078733765.77512.16328978141066310610@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com> <20190214104047.1173-2-gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-2-gabriel.fernandez@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Date:   Thu, 21 Feb 2019 14:15:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:41)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> Fixes parent clock for axi, fdcan, sai and adc12 clocks.
>=20
> Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

