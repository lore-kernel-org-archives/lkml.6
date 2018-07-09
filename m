Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A43C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B146020852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQmxDge1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B146020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeGIQpF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932996AbeGIQpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:45:02 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B8C20878;
        Mon,  9 Jul 2018 16:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531154701;
        bh=G0yJbHgeZ+Z4uTrYa+FCPihmycnyXLtDSQdncesD10I=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TQmxDge1xuvbaQ3jSSBhrzomB61Gbsy9FHDqavN4R1x0U9spEq7oVhKu92+/uszVT
         LRpBrogNE5FrHCXi9Rlw6Ib2xzXTIxvX+tK9h9tQ1I2vIlKZc1+YlzaM+0vk45Kdtc
         PI9Rfi5rVMus4KJm64/aPP1GN6RBedX6OrakinE8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180619123446.694-3-gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        Hua Jing <jinghua@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Ken Ma <make@marvell.com>
References: <20180619123446.694-1-gregory.clement@bootlin.com>
 <20180619123446.694-3-gregory.clement@bootlin.com>
Message-ID: <153115470127.143105.3624204545204931586@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: mvebu: armada-37xx-periph: switch to SPDX license
 identifier
Date:   Mon, 09 Jul 2018 09:45:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-06-19 05:34:46)
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> =

> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Applied to clk-next

