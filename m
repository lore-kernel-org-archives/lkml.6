Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A665C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EEA24FC5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVZj5Ed2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EEA24FC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeGAIvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeGAIvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:51:24 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8501223C8C;
        Sun,  1 Jul 2018 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530435083;
        bh=DbgDOCOjIzL8VfKLvuNV+QVsl4fEwnhhyt44oYUr6Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVZj5Ed2ynroMHIz2UI6gqd55YCdGH6n9jYsERgORUK8PSBkNOiNLj/NXi5J7eYMf
         KJdLkJmrrrx3HZTRSuWAiheHj9AenjzmWRTFb0xJlq4yCg1EoS4E1IVO3EwAnGZlhy
         54C15rKnG6pgR4bFhSUdqtyZ/WigkjvyU3hQKLD8=
Date:   Sun, 1 Jul 2018 16:51:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk, lee.jones@linaro.org,
        tj@kernel.org, hongxing.zhu@nxp.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: enable bus auto clock gating function for
 i.mx6sll
Message-ID: <20180701085111.GK4348@dragon>
References: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:32:48PM +0800, Anson Huang wrote:
> i.MX6SLL has HW bus auto clock gating function, enable
> it by default to save VDD_SOC_IN power, about 5% ~ 20%
> saved depends on different use cases.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
