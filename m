Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E603C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27E820818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1o+w5DEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27E820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeKPNdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:33:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeKPNdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:33:12 -0500
Received: from localhost (unknown [106.223.241.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F2020818;
        Fri, 16 Nov 2018 03:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542338554;
        bh=XTM3GZ9ukFARIDN9PB1r+9ZbIOUNWKn09f/iM/FTAPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1o+w5DEPjOB2tcZiUyrc4hlMA+7l5/HAvoMLkZXd+DmHuOGEWVQz8EteHatcA9AfW
         vbR1fFiTlm6WnlMZnZT+/g1aw8JoLmXOXNwCC6+U97SFZn8T/qkl4P83GtFd2elRwe
         qUlaGP45ghDX46Se48dierED4zFXww+kLqeG+lP4=
Date:   Fri, 16 Nov 2018 08:52:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v6 0/2] arm64: dts: add prng-ee nodes
Message-ID: <20181116032226.GJ3060@vkoul-mobl>
References: <20181001062151.27607-1-vkoul@kernel.org>
 <20181115034518.GG3060@vkoul-mobl>
 <20181115192009.GB17484@hector>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115192009.GB17484@hector>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-11-18, 11:20, Andy Gross wrote:
> On Thu, Nov 15, 2018 at 09:15:18AM +0530, Vinod Koul wrote:
> > On 01-10-18, 11:51, Vinod Koul wrote:
> > > This adds prng-ee nodes for msm8996 and sdm845
> > 
> > Ping Andy, would appreciate if you can pick these up.
> 
> Done.  I did have to massage the location in dts for both of these patches to
> keep the address order correct.

Thank you Andy, appreciate it.

I have two more series in queue, QCS404 DTS series https://patchwork.kernel.org/project/linux-arm-msm/list/?series=40841
and QCS404 defconfigs https://patchwork.kernel.org/project/linux-arm-msm/list/?series=40853

Would be great if you can review these as well

Regards
-- 
~Vinod
