Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B6EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAD82082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hClat++6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAD82082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLDTYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDTYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:24:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E00206B7;
        Tue,  4 Dec 2018 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543951475;
        bh=7ZRISUIyYeKFqbHSBd1n18AQDpcLgw+ynQeVDHrM5Vk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=hClat++6TfI6qRpD4OIMm3TIV3S2Uxxt5k5UtDvLFZJPtMQs8GoAp5A2NbP0HtPOP
         sbC9JVEgkWb/GNdTj3PH0UaSkf7IXAWwF/Z0nwxOUXiAZYX00eBqENb5Kl+7y/0VcV
         nrbZby8GlKXsTiIXBH5+5M6HYTwTmCLRPB4Lqlx8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
Cc:     David Dai <daidavid1@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        tdas@codeaurora.org, elder@linaro.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
Message-ID: <154395147467.88331.11245098345794342948@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] Add IPA clock support for clk-rpmh
Date:   Tue, 04 Dec 2018 11:24:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Dai (2018-12-03 19:50:12)
> This patch extends the existing clk-rpmh driver to support a different
> type of RPMh resource known as Bus Clock Manager(BCM) in order to scale
> performance for the Qualcomm IP Accelerator(IPA) core clock.

Please don't send cover letters for single patches.

