Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67435C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7F3208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGBygiFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7F3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeFQHJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932075AbeFQHJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:09:13 -0400
Received: from dragon (unknown [45.56.152.75])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB2520864;
        Sun, 17 Jun 2018 07:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529219353;
        bh=jfZCPUU1x0mkIu2SwMgwY0wbUUdJfqjNk5wkbYLq4O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGBygiFS7S+0nQkJv/xydzG5qNaqRlBf4yvRqul00YnG7cDfC++ihZ0VGcnnB1jht
         calBJjpph12Qfui1hfrrdM46Hm1NgCNPPZmOhB0dlYOG07rPIMDh/j8KU8zemo9FAL
         E9HQbGWcxYHNnxnliZuKBGRYC7yabfymmDhX7CCc=
Date:   Sun, 17 Jun 2018 15:08:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marco Franchi <marcofrk@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
Message-ID: <20180617070819.GM16091@dragon>
References: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:19:23PM +0300, Nikita Yushchenko wrote:
> This adds rave-sp powerbutton and backlight devices to RDU1 device tree.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Applied, thanks.
