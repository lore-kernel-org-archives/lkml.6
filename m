Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE93DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC99120818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550787353;
	bh=dhrddHJJqn6H8vogNQlBr5NUA3ksCIPNKy6AbvB3PCw=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=sq6nEQ5QBMCxbJdHTuMDxQDAZp9ADjRUw4XPdX5ZRNAC/nvhElZ6XCp4QNtcyIOk4
	 Mwgh6/ayuc1OmoLPUsX2OlDarK/YqEucW3kxO5fRBltYH4xDmlHnC+stj6JEVncwZB
	 cwJgVpLzej2TDxzfRwAPyR4ocAgPUqNBKKXpPqzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfBUWPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfBUWPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:15:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C392083B;
        Thu, 21 Feb 2019 22:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550787350;
        bh=dhrddHJJqn6H8vogNQlBr5NUA3ksCIPNKy6AbvB3PCw=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=BTe2GNuy1DBucTsckNyByFG6kH7XNx6very7PiHGqJXaVySWaEA8Syh0VLVfwKBEB
         iB5dO15w9dwH9idmUCadjh9eMNLnl9nZIVkJg/GHYRpcGVtztaKaVZAsrkbIor/JqD
         gdMpE4FJINvIy9luZZe1ToKv/KvVh7yvCZHcNdWU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] clk: stm32mp1: fix mcu divider table
Message-ID: <155078734994.77512.14950285507470486130@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com> <20190214104047.1173-5-gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-5-gabriel.fernandez@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Date:   Thu, 21 Feb 2019 14:15:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:44)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> index 8: ck_mcu is divided by 256 (not 512)
>=20
> Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

