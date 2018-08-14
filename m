Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A9C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E862172F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E862172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbeHNT6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:58:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52646 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732943AbeHNT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:57:59 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3A21513E0CE3B;
        Tue, 14 Aug 2018 10:09:58 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:09:57 -0700 (PDT)
Message-Id: <20180814.100957.1728722828479885181.davem@davemloft.net>
To:     fabrizio.castro@bp.renesas.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        sergei.shtylyov@cogentembedded.com, geert+renesas@glider.be,
        horms+renesas@verge.net.au, biju.das@bp.renesas.com,
        yoshihiro.shimoda.uh@renesas.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@verge.net.au,
        Chris.Paterson2@renesas.com
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774a1 SoC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Aug 2018 10:09:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Tue, 14 Aug 2018 13:33:37 +0100

> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Which tree is this targetting?

Thanks.
