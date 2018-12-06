Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD3C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEDB2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544081780;
	bh=zwfc/xaKj2F/WN5VahWfQreYqn/sl1p0p7HNdSXHssk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mHXc9cmxYNmPYdWyff04xlZRBrBUKEoOw0NKguGAuY4c6h9jIO5fMppjd6yJEMre8
	 L1zZsXd+xb2efG+PgJ71t/5Egg6zF0JLLE6fuk2Lzjp2vTWKQDzc5kP3If+UvePsSE
	 EPkJe81/q3wh0KgVU9LGcmvKzuQU+CMrSbZwuY7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEDB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeLFHgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbeLFHgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:36:19 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A1120878;
        Thu,  6 Dec 2018 07:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544081778;
        bh=zwfc/xaKj2F/WN5VahWfQreYqn/sl1p0p7HNdSXHssk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=07K9NisujIYMHhro9h9Nf46h/RGfPoT5ENfCQej+F21vyajcBhYjbp48n3X3src4f
         CvFG8mAvHoKUu/m1k+dr1Bfdld69sgI/2gjQja5jPb66eYewKw0xzzT17H6e9IkhEq
         AwnzBHXlrYkXGiWevJW7dzEwB8xSzgmqFVaA9pgs=
Date:   Thu, 6 Dec 2018 15:35:37 +0800
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
Subject: Re: [PATCH V2] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
Message-ID: <20181206073536.GH3987@dragon>
References: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:14:25AM +0000, Anson Huang wrote:
> Add egalax touch screen support on i2c2 bus, it is connected
> to LVDS0, while the existing one on i2c3 bus is connected to
> LVDS1.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
