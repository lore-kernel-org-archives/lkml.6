Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E907AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DCE21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwYq1s+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DCE21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeIZIf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeIZIf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:35:27 -0400
Received: from dragon (unknown [104.237.86.64])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9811320895;
        Wed, 26 Sep 2018 02:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537928693;
        bh=BYS81BwEENQWAKRXRNz2FBqRTXvPV+wVOD6p4VgZaOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwYq1s+1FOqCH80kVLpjYySsxkHXdW9FR5ZbEeQ+5Cu1SZzndUyoZ+rqdc3Es09Od
         J1aTgacls7l7aHg8b9mZCISjx+T3WAGSdN9YetibauffumUi39FjRPrE9Y+7bjo3y5
         M1ApSADcZidPDCijHvPC1izpIrn84RJhuItCYVfI=
Date:   Wed, 26 Sep 2018 10:24:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v2 07/11] arm: dts: imx7: Update coresight binding for
 hardware ports
Message-ID: <20180926022440.GC22238@dragon>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-8-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912135352.19722-8-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:53:48PM +0100, Suzuki K Poulose wrote:
> Switch to the updated coresight bindings.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied, thanks.
