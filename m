Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAABC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00659206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544054234;
	bh=iH76gZ7C3IbZ4gNQxSlk26AzYVY8Ulr90eHhPwpzXDg=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=y7mYz5R8pwFKslNGS5mnGC/t+g5bQ+fnMVa9XnlZ8CpwNBXvQwSAd0OLbGS7j1YEw
	 PK529WyAyJ6SSTWx7V/H4fepDNI/7FzmcPTYx6rlZu04qj2vUnOYHR7HLtlYCTqRJO
	 +I42nw8ozVjPf1ajEUjrOQCtk4ZAqM3gUxRZvM08=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00659206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeLEX5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbeLEX5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:57:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2879206B7;
        Wed,  5 Dec 2018 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544054231;
        bh=iH76gZ7C3IbZ4gNQxSlk26AzYVY8Ulr90eHhPwpzXDg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Tr3B2SB6VRW2GXSzP5bhezLIJgugulSvd+2HcbROMDUWuVXT571mVvOv4rUd49wEs
         KU/56nsU3LS3VLqRD2VNLC5bg1ooyvmUitZc0sAZd5yeBr5U3kSoIQkVOgLH8snEjR
         62tXF9/ifxZoy7cymm9o3Dl2PGh6aNq/Bsg/FbP8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543936402-7075-1-git-send-email-jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <1543936402-7075-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154405423096.88331.16497795566744190777@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Enumerate remaining msm8998 resets
Date:   Wed, 05 Dec 2018 15:57:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-04 07:13:22)
> The current list of defined resets is incomplete compared to what the
> hardware implements.  Enumerate the remaining resets according to the
> hardware documentation.
> =

> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---

Applied to clk-next

