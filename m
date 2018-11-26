Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D8820862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j72+3nLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D8820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeK0EUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeK0EUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:20:08 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333FD20663;
        Mon, 26 Nov 2018 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543253121;
        bh=u8zfcCNMkHvf6kR0leURK1WeYlk4HfWUJ8uj0A38qVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j72+3nLVP/gb+Nd5ttEruOH08Ku7G8SoPs5sqSUqfWV+2v+f3CjANBCIQDNHKma1f
         mctN7HqsCNnPuVFFnEzy0QZppCSTmSKBOnOep8yYjhqpW1RDN0RuGc+5UCTHzjuiT4
         vVau5biLo2d9f2IFlv2nWmP8SaK3Y4j2ipNbZJ+4=
Date:   Mon, 26 Nov 2018 22:55:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device
 node
Message-ID: <20181126172512.GW3175@vkoul-mobl.Dlink>
References: <20181126142133.16966-1-govinds@codeaurora.org>
 <20181126144422.GU3175@vkoul-mobl.Dlink>
 <bcda9f6ffc58c8457e8822226b751132@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcda9f6ffc58c8457e8822226b751132@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Govind,

On 26-11-18, 22:28, Govind Singh wrote:
> On 2018-11-26 20:14, Vinod Koul wrote:
> > On 26-11-18, 19:51, Govind Singh wrote:

> > Lastly, I am not sure, but should the wifi node be always enabled?
> > Should it not be enabled in the board dts file? Bjorn..?
> > 
> 
> yes, i some how missed this.
> I will mark the status disabled by default and enable from qcs404 evb dts.

No issues, also we have two DTS EVB-1000 and EVB-4000, please choose
accordingly and if common please use qcs404-evb.dtsi

-- 
~Vinod
