Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238CC20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="asuugWON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238CC20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeHaFL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbeHaFL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:11:57 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11B720837;
        Fri, 31 Aug 2018 01:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535677625;
        bh=uheOuzGmV2gm7eATI1Ad/TvxYynx0IYQj/xN/1m1jNQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=asuugWONnvkE1zIV0gF3/6G72R/wbShEDOQewM//KZLWk9Xj/VLjRCMcR7nhLA5ja
         XfFHKV9tQcEsvJZz5+VC+R9UDk/J5ZjfWfxv/98LS2+s9abQBeK+p8meqBbQQ+GG2b
         v4IDLrLXN0cgJYVGytmqeLXsR51bvrude+X6HTlE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180829231505.22660-4-bjorn.andersson@linaro.org>
Cc:     Sricharan R <sricharan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Craig Tatlor <ctatlor97@gmail.com>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
 <20180829231505.22660-4-bjorn.andersson@linaro.org>
Message-ID: <153567762437.93865.16776417479004124963@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/3] dt-bindings: firmware: scm: Add MSM8998 and SDM845
Date:   Thu, 30 Aug 2018 18:07:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-08-29 16:15:05)
> Now that the compatible/clock handling is reworked add compatibles for
> MSM8998 and SDM845 to the SCM binding.
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

