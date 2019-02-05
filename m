Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3795E217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549402189;
	bh=ZP5E8jQJR9FhiqPbHYxquvqdcJKLTBhGOgfWvKEmLhs=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=KzoPPrk82O1/I30X6vfC4rc2ur6ZkLNt4D5Qs6l9rygCrTTgXRYGMQ/v/xB8mYkup
	 F2WiZvTCmB301XYDH2tSUBzuVcYMvkQu348vCXbHY2AfqWERUKD6EBzcwFSSxFVqNy
	 YR0vrIS/RPMzC8S7xUIbSNrK+6MUon4dZWHg+m7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfBEV3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBEV3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:29:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D66217D6;
        Tue,  5 Feb 2019 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549402186;
        bh=ZP5E8jQJR9FhiqPbHYxquvqdcJKLTBhGOgfWvKEmLhs=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=lYQE+qUz/rKFTC9mVVeAtBT1xgNb5wLVX75NuQEqnKHjB5ZInJIBx1V2C4PDr57Pn
         B+clZedrndeDjic0I2swbLemlXwxHzw+GJV/XaCcudJ6iTIObiEJgjCj2TQZMf2snQ
         gzTOMgD+U9Sh2otxEnw5PxHffGDB4RvbyWLaaFTE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [resend PATCH v1 1/2] dt-bindings: clock: add clock for MT2712
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940218591.169292.1772059946021644625@swboyd.mtv.corp.google.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com> <20181214020417.2871-3-weiyi.lu@mediatek.com>
User-Agent: alot/0.8
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
In-Reply-To: <20181214020417.2871-3-weiyi.lu@mediatek.com>
Date:   Tue, 05 Feb 2019 13:29:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-12-13 18:04:16)
> Add new clock according to 3rd ECO design change.
> It's the parent clock of audio clock mux.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next

