Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D220836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550786024;
	bh=ND3Yust0p46AhKEUeZZwAwnRXIxVKbnPb8OYswZ2bOk=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=rgwMpsEGCMBxU62Cd/9yMGH+94Ckk8Zgkj1yLV5+4fqjHMQePdNiEcFFOCoK1LkDJ
	 dBYr4Kmx9n8wh8iIbtbaZTEKUC8pPNoICqCe+jOdVRXx/J5Sh1+EmCRDyTJGN99g3M
	 O5Cw4GXs5w3bdFy2fIHd81d+TihtnjfrbbUBo2ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBUVxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfBUVxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:53:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BD42080F;
        Thu, 21 Feb 2019 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550786022;
        bh=ND3Yust0p46AhKEUeZZwAwnRXIxVKbnPb8OYswZ2bOk=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=QkcLV2UtasqCEFC+X01t0nkkpL0LhyJr8ZKea03x3BhpIOWn8oq5Mt2u4WxdRc6fG
         DhDum8rs9FjCWXRK26Kll4Olrm3PdZS77n16IsdYqLKn9izKdNqY1UY7IQ+Zlw6l4e
         D5J01dZajebQ2WKe+CfQSMP6W3C+3fsdVhObk8fo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: marvell,mmp2: Add clock id for the LCDC clock
Message-ID: <155078602184.77512.6860842537619686021@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190121063129.552580-1-lkundrak@v3.sk> <20190121063129.552580-2-lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190121063129.552580-2-lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Date:   Thu, 21 Feb 2019 13:53:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:31:28)
> The peripheral clock is required for access the the LCDC registers. It
> is in fact separate from the "AXI clock" that is optionally used to
> generate the pixel clock and as such requires a separate clock id.
>=20
> Link: https://lists.freedesktop.org/archives/dri-devel/2019-January/20397=
5.html
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next

