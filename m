Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6D2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214F2214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zIphHID8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214F2214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeIZPcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbeIZPcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:32:32 -0400
Received: from dragon (unknown [45.56.155.164])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E96D21480;
        Wed, 26 Sep 2018 09:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537953632;
        bh=AuH7QEDQo0puUOG2nzl6ZyDEaMZeAvapK13iNLMoP20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zIphHID8BOI/gc8IeO1gZ8PjSg3fFFjRnD6mGFK2qFxqVBwc1xwFIxM3GrN+i14ui
         JvkhQIDrUz9cMMQZCWvn2+hjQu/B56lG5qBrSKymEnTC0lzuMLkyez7rkKukbiKbWm
         2b6Wke5ywxmFHHpJSHi21ikNtbf8TWpLGM88nq+U=
Date:   Wed, 26 Sep 2018 17:20:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed
 grading
Message-ID: <20180926092004.GE26692@dragon>
References: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 11:17:43AM +0800, Anson Huang wrote:
> On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first, so use the nvmem-cells binding instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no change since V1.

Okay, I just applied v1 of this patch.

Shawn
