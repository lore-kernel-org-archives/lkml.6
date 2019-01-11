Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEAEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A00F20836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547212062;
	bh=hLi/R39njkSAjVFz3/guqidEbB0n43nz53A5B8IykrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qpuo/s5bnXwQzuNRD4ml2Dh/TR/z+Ed5SbbcG8G9JyB3V6dqzZ41oRN+c1cM+krTj
	 uQY7AH5rc+raXHi+mueSUhz9Km1nxr8eV4ckJ7hyAPPJQsWW8cn81vr/ZXj1y1LxxK
	 xCi6DPQA+4FT5QqwRcqrHFAnJOLNpRp/czesLImA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbfAKNHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732567AbfAKNHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:07:35 -0500
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F8020836;
        Fri, 11 Jan 2019 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547212054;
        bh=hLi/R39njkSAjVFz3/guqidEbB0n43nz53A5B8IykrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7CZVshAA6KmMzMOYNDK/3XFOo70rtSlhm9aup0KczSxppM3SU/tQ+q59+7EPDB2Q
         o4T0dvPH71LcWxb5Ny5vJ3Ty/fXwo4WwJh4+Js3H9FC4sDhGs2wYexVe/A1tYr5RF7
         v0dlk65Z44BlV34ZEizieWAXAoFl66iy0ncRed84=
Date:   Fri, 11 Jan 2019 21:07:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Message-ID: <20190111130714.GB3599@dragon>
References: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 05:41:31AM +0000, Anson Huang wrote:
> From i.MX6SL Reference Manual, the PWMx's ipg clock
> for registers access is from perclk, correct them.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
