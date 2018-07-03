Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836BBC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331E824E26
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9VlmiYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331E824E26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeGCHQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeGCHQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:16:00 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE87024DF1;
        Tue,  3 Jul 2018 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530602159;
        bh=w5bnOkCpmh54+YDhTx+hyfU9HpAemzBKVHVw7uPZbZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9VlmiYhobk8QKihp7dXfrld72++iZXJaxSsaJD8OwULksUBW3NOEfImQTo8SWLQ0
         aS5UouV6SutiMErobWpRoebYiAc9l+6gRUEMVIVopGV+m1o7La12vbtygVramQejLG
         LWNzcFANtwLOM7SQkRHOodIyoxum7/ILTO057U+8=
Date:   Tue, 3 Jul 2018 15:15:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, tj@kernel.org, hongxing.zhu@nxp.com,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: enable bus auto clock gating function for
 i.mx6sll
Message-ID: <20180703071542.GN4348@dragon>
References: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
 <20180701085111.GK4348@dragon>
 <20180703062014.GB4242@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703062014.GB4242@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 07:20:14AM +0100, Lee Jones wrote:
> On Sun, 01 Jul 2018, Shawn Guo wrote:
> 
> > On Fri, Jun 22, 2018 at 01:32:48PM +0800, Anson Huang wrote:
> > > i.MX6SLL has HW bus auto clock gating function, enable
> > > it by default to save VDD_SOC_IN power, about 5% ~ 20%
> > > saved depends on different use cases.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > Applied, thanks.
> 
> Since this touches MFD, please apply my Ack to the patch.
> 
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Done.  Thanks for reminding, Lee.

> 
> -- 
> Lee Jones [李琼斯]

Nice Chinese name, BTW ;)

Shawn
