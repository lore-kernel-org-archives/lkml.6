Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C426C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B61208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSKz2DdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B61208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeH1BGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeH1BGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:06:22 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C753208B8;
        Mon, 27 Aug 2018 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535404680;
        bh=s5qY/mdaTHdmatDCWIJXcyC8hYXAipzVCBkp8i9RbsE=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=sSKz2DdOxACNdToJT5+XROvqLx7hRhNa/VS2m8LiPpeEE979rH0rR68pUCqHO5x8T
         8V+Zp7IWkWzweE4s+XGJboOcfjZIIkwq6I32XvkZ8tFuJ/QLMJreB8lb9dtP20VGI3
         UYYn2sRhBLFDmpfufwCouOzdpRIvH8i4tFqxg2tw=
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
 <20180807161713.28073-2-krzk@kernel.org>
In-Reply-To: <20180807161713.28073-2-krzk@kernel.org>
Message-ID: <153540467962.129321.2485269464896438396@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 2/3] clk: s2mps11,s3c64xx: Add SPDX license identifiers
Date:   Mon, 27 Aug 2018 14:17:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2018-08-07 09:17:12)
> Replace GPL v2.0 and v2.0+ license statements with SPDX license
> identifiers.
> =

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next

