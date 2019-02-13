Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A9DC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B159218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550091727;
	bh=9X+gzRmSf+BHmR3RUa0gPVqj5qvtMZulGLtfrswIXdM=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=SHsTKTniDpsUx6tHgrQw4EZNoTOZxRhhPbZW+NDcYN5Uct+d80CfA3vll3bfnyCa0
	 kDXjNNkBXAsH5tbdafRsxmSYaO8k33gVwTuOUk/h6JNdPnyVk2P6+hDZhN2N1K1CcE
	 H/Bm+Y/OH+flUWA5Ji+u1W1meVXdEKGWlaxufsM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394692AbfBMVCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfBMVCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:02:05 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD231207E0;
        Wed, 13 Feb 2019 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550091724;
        bh=9X+gzRmSf+BHmR3RUa0gPVqj5qvtMZulGLtfrswIXdM=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=ZNIeVIBzr8EiPpXNY5PGNvn/Ol+yuvol4uG3W30OpuRiVRq1T7vGEIlSjC2gzHiBw
         actim0hMjCjgFR6nYobCG2zo5SA3TIPFus75V9GQyJbyaVmsZMWwrXrz6O1+nHCaKB
         sxhwO/NcQTp3v91yEA8tQncsHvyoMHgJANIxtB3w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20190213100714.15622-1-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH] dt-bindings: clock: remove unused definition for stm32mp1
Message-ID: <155009172384.115909.11842128085275839689@swboyd.mtv.corp.google.com>
References: <20190213100714.15622-1-gabriel.fernandez@st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 13:02:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-13 02:07:14)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> LTDC_K and ETHMAC_K are not used.

Ok, but do they exist? It's part of the binding so I don't see how it
hurts anything to describe what is there.

Also, please send patches to the linux-clk mailing list so patch
tracking can work.

