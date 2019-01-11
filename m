Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB50C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F6221841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547243830;
	bh=qFfhUIyqFAkkxYE92HIwdCWqVofoa5ERUkhRF6yoQC4=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=X4ESzUtRvuAnmJNqEFsHdfKt9wo4SMiL/SkosSK4nWTrYOTfcYOFiUWLp/zijCgID
	 7cAbVWyOG6Zqk/HJTdNEv5fNUkeE92VTWskQxAYf6dRJk+u94fijxFbVCqMxwlkvo7
	 U9opN3MOcrVV/rU6B9HMwp00S8FMthTdmfH1PT+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfAKV5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:57:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E919620878;
        Fri, 11 Jan 2019 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547243828;
        bh=qFfhUIyqFAkkxYE92HIwdCWqVofoa5ERUkhRF6yoQC4=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=e4N4sXfyXyFR5ybjFr2TsunRXQMgyXu13/qW2n6HdV4fqVYsMwml5l7DXP1xD7c5L
         VE63sLzJ/+QmG4YQhLf5OcLX1+pdDwvMy6MmD21ZUu2Ea+49ISSYxHhkW9IHgEK8QO
         1VkhIQ/hGq9w1Ah+Tcf6ExugQspVkWEmD+h04fo8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 5/6] ARM: dts: qcom: pm8941: add interrupt controller properties
User-Agent: alot/0.8
In-Reply-To: <20190110011258.17227-6-masneyb@onstation.org>
References: <20190110011258.17227-1-masneyb@onstation.org> <20190110011258.17227-6-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154724382723.169631.15887252792256942564@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 13:57:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-09 17:12:57)
> Add interrupt controller properties now that spmi-gpio is a proper
> hierarchical IRQ chip. The interrupts property is no longer needed so
> remove it. Code was tested on the LG Nexus 5 (hammerhead) phone.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

