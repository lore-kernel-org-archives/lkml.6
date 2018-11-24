Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF31C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84C920874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiXPtNeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84C920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeKYBE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeKYBE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:04:56 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58BD12086B;
        Sat, 24 Nov 2018 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543068985;
        bh=KBfNrKexadVDd/66OC09vmI482sa1+p3BSiCco60v3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiXPtNeHVX1YxDaqlkeN7I0Ex45hmQ2YAKD3LPNgxQ4SyFErF/nz52IFmVGqq7lmE
         MlDYqbM5QcahUJx3JppS+JmLFcjzMyoVEJXLEO4ulahkBFXTLY/Rpil+fWtSNEBEdV
         wTIo5Unr5RSB+8BnP43ZKoUQjOWDREl1wPAqAz5w=
Date:   Sat, 24 Nov 2018 19:46:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dmaengine@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
Message-ID: <20181124141616.GH3175@vkoul-mobl.Dlink>
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-18, 01:41, Masahiro Yamada wrote:
> 1/2: DT-binding
> 2/2: driver

Applied this series, thanks

While building I noticed that we get few warns when compiling with
C=1, I would prefer you fix them. Please send fixes on top of the
applied patches.

Thanks
-- 
~Vinod
