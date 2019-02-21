Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E76C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB342083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550787417;
	bh=lkdR7iOTNdzrZJ/MCEMysfvGwqPVUOqZA7F9Zbi2jGE=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=mCcfha2aiYnAajVLgGHgsFpD11MNIx1md/RjQF9FjVsTlcOtSyEN54+jzUO4P7ZcA
	 0lmwQwKCqySSAZg5zWDybr4OBD8Zw0uYxfK/dJTX6rNOF5Gf5NzZFmxiINbdUG4duT
	 EVt0wHLLZzBHHxCzsID/K4cfCzuXP+Uae+3DHXis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBUWQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfBUWQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:16:55 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D5020818;
        Thu, 21 Feb 2019 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550787415;
        bh=lkdR7iOTNdzrZJ/MCEMysfvGwqPVUOqZA7F9Zbi2jGE=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=BCWorGNectwZh+YdGIk3tTL9teMKJKqKVMbjyoYpK23ZJo+WGtHPayPYpFROrn89f
         UtSFzlq+yrTkJGJy8oI66/UDQfyExwtnecVrXp0AJik6OAuj7I/dBVXSsS5Jo3Fl9X
         uKglMpJFTrnxWxQkgIIalbSd7RGy3C0ZLfhKNFSg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: clock: remove unused definition for stm32mp1
Message-ID: <155078741430.77512.14260216742704556101@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104242.1491-1-gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104242.1491-1-gabriel.fernandez@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 21 Feb 2019 14:16:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:42:42)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> A copy of LTDC_PX and ETHCK_K (LTDC_K and ETHMAC_K) was introduced in
> stm32mp1 dt-bindings file by mistake.
> These bindings are not used and shouldn't be use to be conform with
> convention name of the stm32mp1 clock IP.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

