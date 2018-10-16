Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589AAC5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2141B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7IDi9Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2141B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJQCQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeJQCQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:16:03 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C5F20645;
        Tue, 16 Oct 2018 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539714261;
        bh=8royWaTxPPCRyuvn1lo3w7HwV1yRjxcX09ZjNOv3TJQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=r7IDi9VadmmEkciRHrwhpJVqGgHqgTTaXZPvLlJ2xLOziDA6tTXx/SLsEG58JNL/2
         cJPWRmGC1O8sdIKpBU0iNcl8KEtAljowP0vobTKVYZJgCqNy3vfKXjE1eUsYCek6Ry
         T3gXplgSqoxQYYCpMiq6jp6zgiNEg44Lr4ggWw+o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181016072209.1011-1-mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
References: <20181016072209.1011-1-mgautam@codeaurora.org>
Message-ID: <153971426077.5275.18013685889153010181@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/2] phy: qcom-qusb2: Use HSTX_TRIM fused value as is
Date:   Tue, 16 Oct 2018 11:24:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manu Gautam (2018-10-16 00:22:06)
> Fix HSTX_TRIM tuning logic which instead of using fused value
> as HSTX_TRIM, incorrectly performs bitwise OR operation with
> existing default value.
> =

> Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom c=
hips")
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

