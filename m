Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AC6C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BD5217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551205071;
	bh=1Ahvvy76fZ873Gs7wVuak7Fk+CXJ9JPrUMEngzbucqU=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=VRfaxdNa4f7roSO9TBW6cjsTzfllZj1mIAHgg4GQnrQQgJOdmu6WmSq0PLlGOxUIP
	 OMenhoxKRiz+6WGJ+oMOFjaPAvhQ6Ukd/MqTZa7rubkjiPp6S30bhr3n4W4/MZmRUk
	 a0/GRf4p2fgr4fJYocA0TG1s0ZiEED/siQCME6m8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfBZSRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:17:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfBZSRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:17:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6EC217F5;
        Tue, 26 Feb 2019 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551205070;
        bh=1Ahvvy76fZ873Gs7wVuak7Fk+CXJ9JPrUMEngzbucqU=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=FMnBNpRli1ZAocpc18jGV/F0TD9WdhcMAnWsmRgd0B6SCyjN04Zw6Lt3r06LnhIaz
         idDhycl3N+td6ZPh57spEpHjN8jdST+Mlp/a9ZtUBDa17bk57j84SoK8nXQznjYaT1
         kUCwoTOKSWAXY6Kqi+NF6eh+Vg4ZzO9WLPJ0ZKto=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>
References: <20190225065112.3400-1-seiya.wang@mediatek.com> <20190225065112.3400-2-seiya.wang@mediatek.com>
Message-ID: <155120506909.260864.5536692295521525636@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: correct cpu clock name for MT8173 SoC
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190225065112.3400-2-seiya.wang@mediatek.com>
Date:   Tue, 26 Feb 2019 10:17:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Seiya Wang (2019-02-24 22:51:12)
> Correct cpu clock name from ca57 to ca72 since MT8173 does use cortex-a72.
>=20
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

