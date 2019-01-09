Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9264C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A315E214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547060361;
	bh=lQoy1q6T9b64AKDWyBsaOr40kTReQ2/8gTUf/A/C4fQ=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=D2Oqg0AHXnP2FMOglcTj9mBXr1qH8WgyBcD/rEBeVoZEtj6xQEylxQ0eweBVIsWzs
	 IJtmevVhkU/wUCy8z6QgKsNcToE6oTG34FVK+tZm4/Tgb9udKFS30JDFfdghv2Ljbw
	 BmmgYuKsWHFpaxjZTxGpDw3kCI5kqAJj5Q7weQgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfAIS7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfAIS7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:59:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0C820859;
        Wed,  9 Jan 2019 18:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547060358;
        bh=lQoy1q6T9b64AKDWyBsaOr40kTReQ2/8gTUf/A/C4fQ=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=y0Lldjy2gEN1r71aYAN7kvpfLmCBIy6SQByBEgJVohoel+2dxH7DRKbXjL5GBa6RT
         8gp+XRGGxjNJZJvm1t1St/+xk9WZycAXbDZaEiUQ265J0TkEU+neAQVGY+HdB7u+mR
         tNDbjJ04vq2RYUhtim+vs9Pkb5LxIi3NEnYE/9ME=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] clk: qcom: Add missing freq for usb30_master_clk on 8998
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>, mturquette@baylibre.com
In-Reply-To: <1546620586-2352-1-git-send-email-jhugo@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1546620586-2352-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154706035805.15366.6771584987166910977@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 10:59:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-01-04 08:49:46)
> The usb30_master_clk supports a 60Mhz frequency, but that is missing from
> the table of supported frequencies.  Add it.
>=20
> Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GCC) dr=
iver)
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---

Applied to clk-next

