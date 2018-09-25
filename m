Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74B3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564AF20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL5xXd/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564AF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeIYVmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbeIYVmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:42:11 -0400
Received: from dragon (unknown [104.237.86.234])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4174E2086E;
        Tue, 25 Sep 2018 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537889649;
        bh=EyBiXh0Rvp5ugqDjPWWgxI5jFn/k1uHXUewGRKI6QpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oL5xXd/rcLxKm9cdaHFgSgOkhE92BgwpIc3XfAwf34csWRbSAiie7HwPBOvW6x2Hk
         AhdvxbWdppGh1X6ClxWzqzAm7bC7bAmM24NzbjBx6fziq8PqqfhmEoeoGEz5j0xKTg
         9mjrOgrPoWG7d+7l4FD0cM2O6+rTJPjDhEpY1f14=
Date:   Tue, 25 Sep 2018 23:33:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
Message-ID: <20180925153345.GA22238@dragon>
References: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:13:29PM +0800, Anson Huang wrote:
> Update VDD_SOC voltage to 1.25V for 900MHz operating point
> according to datasheet Rev. 1.3, 08/2018, 25mV is added to
> the minimum allowed values to cover power supply ripple.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
