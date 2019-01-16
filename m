Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D812C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940E20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547603879;
	bh=gqhKnsgt/5E3ZYbZp4E87iSDK+8ozWlWLKbRcG2O5Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYzwuj6AbrQK19CRkqgqcr4khzjNV7qwg6MyQgokFVnPcOrDBhMr8h6tqZd8GN6mf
	 QtloqgwGW9I7PWxA+Yc9ZSJk8OZoTEyAEKw3fPWrRTx468yNcNad0z+uVPpVL4tO44
	 LcVfURlHRqfDLz6ewqDYK1TeyuLKPqTd4KOXWJpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfAPB55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 20:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfAPB55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 20:57:57 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC212082F;
        Wed, 16 Jan 2019 01:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547603876;
        bh=gqhKnsgt/5E3ZYbZp4E87iSDK+8ozWlWLKbRcG2O5Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/mXkrhgJwmq7biOhBKKwawXpWRIUtL0fjv+/PKtAKMB+SLHjAh5Yh2ihT2EI8Vtr
         RVRN33Hmru9kHC3Bbb/vM7rwR4Jds2QeYF7Qr+/kM++AkuckUlj89bR4zuxZuNFB0c
         RL6fytJ7zR2EzFRH88BSezRNMBzxKeoRGRdeyH5o=
Date:   Wed, 16 Jan 2019 09:57:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: fsl: add imx7ulp system integration
 module binding
Message-ID: <20190116015729.GA15808@dragon>
References: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 06:22:40AM +0000, Anson Huang wrote:
> Add i.MX7ULP system integration module (SIM) binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
