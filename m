Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764CDC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1328E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xjXIGHZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1328E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeGIO6p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932824AbeGIO6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:58:43 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C275120875;
        Mon,  9 Jul 2018 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531148322;
        bh=bpsQM6IqhU9HNrf1kOhm+ebotxotzMKXU1/4Td1dKtI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=xjXIGHZi2K/oX+MlsVmvBlV+5iyGccjMu9vP9Wi0/poTYv6ZJ36tYBP/hneqCeuDQ
         xqko3KBOI22lWc19zg2/93aRgv8TGkuejcB7dcFbE/hmrjthV+9O801Nhlp4Fi+v3r
         kyYir6o9djygKGzruWgU0t3Ua6jhpxcN8J6dqUrI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
Cc:     "Qianggui, song" <qianggui.song@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-kernel@vger.kernel.org, "Bo.yang" <bo.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        "Sunny.luo" <sunny.luo@amlogic.com>, linux-clk@vger.kernel.org,
        "Xingyu.chen" <xingyu.chen@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
Message-ID: <153114832204.143105.10370402875563713577@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
Date:   Mon, 09 Jul 2018 07:58:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian Hu (2018-07-09 04:12:47)
> Add a Clock driver for the Everyting-Else part

Everything instead of Everyting?

> of the Amlogic Meson-G12A SoC.
> =

> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
