Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B2C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE8D2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q63abNI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE8D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJLIKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbeJLIKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:10:40 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2DA205C9;
        Fri, 12 Oct 2018 00:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539304855;
        bh=OILkLuQiwfylT05gdbigEbX8hBLgTtmZLYgc7ClgyCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q63abNI+1LjrI+QhiMV9p3UgpOiOMkzPYpSNtsD6aBykPc4XbjorrQRGQddcE2iw/
         IvIjTsfncbDv0iXFelcxs5VObOhP6MWAXmBru+0kvC/Bz6k2fLj26d3BrMAnIgzgIX
         lr1lcYIvj5KeaxnIMNG008nusCWlmzyfwl2P8iBA=
Date:   Fri, 12 Oct 2018 08:40:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device
 (vf610 based)
Message-ID: <20181012004027.GB3587@dragon>
References: <20180921152726.31742-1-lukma@denx.de>
 <20181009105028.17971-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009105028.17971-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:50:28PM +0200, Lukasz Majewski wrote:
> This commit adds DTS support for BK4 device from Liebherr. It
> uses vf610 SoC from NXP.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

As v3 just incorporates a few minor improvements over v2, Stefan's
review tag should really be carried.  I applied the patch with Stefan
and Fabio's review tag added. 

Shawn
