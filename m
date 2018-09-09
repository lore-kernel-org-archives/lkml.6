Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E517C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 02:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535C420873
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 02:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPYqZ4xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535C420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeIIG7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 02:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbeIIG7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 02:59:19 -0400
Received: from dragon (unknown [104.237.86.92])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB552086B;
        Sun,  9 Sep 2018 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536459087;
        bh=V9Yrxj1RBDKA1s76+vIy0EAl2CKF4rOA/abm6OAPRhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPYqZ4xGoi4kmkL8xPj0Ufa6Fa+U8AKp3a9YFnxcvCHuxvZhZJAlXMW2pZ5g0NPT+
         k6vwOkVeSg68KgLakQBsmqFgzVtQpf9KY+DWj8oJhieOFy3STaO1PulpvdLv0RM6db
         y8bVol4TL9Beg7nzOqXGQbiZmtcdq9SUSZ1QKEMo=
Date:   Sun, 9 Sep 2018 10:10:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6ull: update iomux header
Message-ID: <20180909021001.GB18838@dragon>
References: <1535606405-8099-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535606405-8099-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:20:05PM +0800, Anson Huang wrote:
> Update i.MX6ULL iomux header according to latest reference
> manual Rev.1, 11/2017.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
