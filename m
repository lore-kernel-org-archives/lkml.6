Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6703FC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D94208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5Cx2Yq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D94208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJPIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeJPIkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:40:35 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD59A208B3;
        Tue, 16 Oct 2018 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539651170;
        bh=9j4H0fAozzbTKMiZ0QMSDLN08Eo5JCE6VTcyo5b4TYo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=n5Cx2Yq/ryOqYskf6VL7qtsAJycpWejR+Dw4FZbzd78IwbOLPf4H6JWmW2ky/vRvN
         bMewyeulOZ8x84z89OLdmrcIS5cMepzvM/8Npw85a6U/C90kGYUq5HTAGeds8ujXPX
         TS/wG1WDD9P+tpa370c5fLb71KB7wIIqUyx0ITjg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-soc@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, thierry.reding@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180926235112.25710-1-masneyb@onstation.org>
Cc:     masneyb@onstation.org, jonathan@marek.ca, ctatlor97@gmail.com
References: <20180926235112.25710-1-masneyb@onstation.org>
Message-ID: <153965116919.5275.18169434559839796065@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/3] treewide: add vibrator support for various MSM SOCs
Date:   Mon, 15 Oct 2018 17:52:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2018-09-26 16:51:09)
> This patch set adds support for the vibrator found on various Qualcomm
> MSM SOCs. This is based on work from:

Can you please stop adding 'treewide:' to your cover letters? It is very
confusing while reading over subject summaries to see something that
isn't actually treewide end up being qcom specific.

