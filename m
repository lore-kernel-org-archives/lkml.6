Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0005C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9408520578
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeLOVFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:05:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55592 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLOVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:05:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DCA1414E8DB9B;
        Sat, 15 Dec 2018 13:05:12 -0800 (PST)
Date:   Sat, 15 Dec 2018 13:05:09 -0800 (PST)
Message-Id: <20181215.130509.170699144609598328.davem@davemloft.net>
To:     fabrizio.castro@bp.renesas.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        sergei.shtylyov@cogentembedded.com, horms+renesas@verge.net.au,
        biju.das@bp.renesas.com, geert+renesas@glider.be,
        jacopo+renesas@jmondi.org, yoshihiro.shimoda.uh@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@verge.net.au, Chris.Paterson2@renesas.com
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774c0 SoC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 13:05:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Thu, 13 Dec 2018 20:18:34 +0000

> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Applied to net-next.
