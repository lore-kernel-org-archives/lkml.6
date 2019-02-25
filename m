Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E65C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75AF213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551076909;
	bh=0Lj7alQCbcVaB9ZuMOL7NmTb5vFNjLGig6zSljjsx0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PpQIBIIIPMe0h9ZZIvVDQLocWbk7SeYoWrJlFSnHozxPuuTqsQ2lN1JviF3dS89bB
	 54IpTuAxiYk1VBtU5UObBpSGU/vvEzwOBJcximDBZpWWAViShVPtbPkvjwh/TQ8V2H
	 uUt3qYE0tUjaf/2eYtuz4MhKuFTQczYgLPsE5pUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfBYGlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBYGlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:41:47 -0500
Received: from localhost (unknown [122.167.64.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD612087C;
        Mon, 25 Feb 2019 06:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551076906;
        bh=0Lj7alQCbcVaB9ZuMOL7NmTb5vFNjLGig6zSljjsx0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itE0iRg8Sy9SUs5nb9doXvyn3BnGHMl9tdBc7TcEVYasw4c8qmal6cYyEFVaD4941
         mnRpO8uPKNFciFCLjG1WX8pQZ5WOHnrHZGoMbARwtDq9oIxjiktxx7rUD/guaIBhFX
         NRonfpolyQxB+oTmSHXUpMm7Xt0C1C/I9wOjTgAw=
Date:   Mon, 25 Feb 2019 12:11:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        eric.long@unisoc.com, broonie@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dmaengine: sprd: Change channel id
 to slave id for DMA cell specifier
Message-ID: <20190225064140.GD31146@vkoul-mobl>
References: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-19, 13:34, Baolin Wang wrote:
> For Spreadtrum DMA engine, all channels are equal, which means slave can
> request any channels with setting a unique slave id to trigger this channel.
> 
> Thus we can remove the channel id from device tree to assign the channel
> dynamically, moreover we should add the slave id in device tree.

Applied, thanks

-- 
~Vinod
