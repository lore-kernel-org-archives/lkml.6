Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC88C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D885E208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFuaDvru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D885E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeH1BGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeH1BG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:06:29 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED407208B4;
        Mon, 27 Aug 2018 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535404688;
        bh=QxhufeUXFnGbHG1DMHBYHYay24r75CCGCF83hGhCKek=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=rFuaDvruTK1aOz3MgvPUmyb3oFbVLwKJ2ZfpJLeSJ7iQXMXnPJsIRIkP/4GsN9Vew
         bJmlUAmN6v3yQ3qoyPojpcLBZF7Hm+IZRehHCIvZJVzrRwqPiccCvUytWg/xbeHYK0
         Fpk5/kJ7iMZ23sMdlgaV9437pn3Z1wCCFh6kWxTs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20180807161713.28073-1-krzk@kernel.org>
 <20180807161713.28073-3-krzk@kernel.org>
In-Reply-To: <20180807161713.28073-3-krzk@kernel.org>
Message-ID: <153540468738.129321.10833887031441726352@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 3/3] clk: s2mps11: Use existing defines from bindings for clock
 IDs
Date:   Mon, 27 Aug 2018 14:18:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2018-08-07 09:17:13)
> The clock IDs must match between DeviceTree bindings and the driver.
> There is already a header file used by DeviceTree sources so include it
> in the driver to remove duplicated symbols.
> =

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next

