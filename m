Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABEDC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2553322440
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NViJLwkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2553322440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934450AbeF2SFh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752544AbeF2SFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:05:35 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403F12152F;
        Fri, 29 Jun 2018 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530295535;
        bh=GlR76WZJ6Qroa6lS6a7kmyCC442bMSav6k06NZ0PH7A=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=NViJLwkZJ2u5TEGJVsgnapm5Ki2F6/TGGdTmEl68ZYR3/sFPQMJaB3j0O+/8npjLP
         236BMkrH4sAIHeDtbgiUC6oIEqlGCNxOHP9l21GegjmNMgm+db5dWV3kpBKvgmv7d3
         iP+iIAWFPzcvHMwm9mxNwrDKXrr4PDPBqihcxEUg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180605062046.31437-1-nm@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180605062046.31437-1-nm@ti.com>
Message-ID: <153029553467.143105.13657696052641478062@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
Date:   Fri, 29 Jun 2018 11:05:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nishanth Menon (2018-06-04 23:20:46)
> K3_ARCH uses TISCI for clocks as well. Enable the same
> for the driver support.
> =

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> =

> Hi,
> =

> This patch depends on https://marc.info/?l=3Dlinux-arm-kernel&m=3D1528178=
66312732&w=3D2
> and is an RFC based off next-20180604 and will post formally once
> v4.18-rc1 is available.
> =


Did you plan on sending it again soon? Otherwise I can just merge this
patch now.

