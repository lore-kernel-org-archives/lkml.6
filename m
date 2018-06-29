Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAC427B71
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0xqE7d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAC427B71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935917AbeF2Smz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934834AbeF2Smx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:42:53 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 866F427B6E;
        Fri, 29 Jun 2018 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530297772;
        bh=f52RGmJyMuA7dSyYpZacHgabzQJrSMaqtxIbescFNmw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=E0xqE7d/5ba/X4S4aSwrIlBugCgpoxrEPNMFGUt8Zuv9+y+Fdfo0PK+qxfULF3dEq
         1oykTH68jgASjnisbIeD/8Jdxy1PBYhI0SNjduZXfRWChjA3c1++e5E00dKseYjg0y
         KFGk+LKme74nIIFw9Pq4wd7uNLcO00TqqSP1QTzM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anson Huang <Anson.Huang@nxp.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, mark.rutland@arm.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        mturquette@baylibre.com, robh+dt@kernel.org, shawnguo@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153029777187.143105.15648614335130166075@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 1/2] clk: imx6ul: add GPIO clock gates
Date:   Fri, 29 Jun 2018 11:42:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-06-02 18:44:04)
> i.MX6UL has GPIO clock gates in CCM CCGR,
> add them into clock tree for clock management.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

