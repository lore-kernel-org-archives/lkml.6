Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7EFFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D733020894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAgvIOtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D733020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeG3GyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeG3GyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:54:05 -0400
Received: from localhost (unknown [171.76.121.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052DB20870;
        Mon, 30 Jul 2018 05:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532928052;
        bh=9oG3U5zB3pRjazr56nCTSDnX9q9TTPXf9zbSmMp+3sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAgvIOtwaces3vJjXZf6VkosKZ7gTwTb1yqKxOPlJqS7Us/VydVYJI/MfoNUXHolp
         sNlGuK7srBCI1UP+yjQmg6bYu+jbOkKJL+BdtefI91AB+dXb6GiU/3j5Pkk4OO8NrI
         31IA9/0NxRcjTD6T80qv71Kebxm9eN84aoBdk+WY=
Date:   Mon, 30 Jul 2018 10:50:44 +0530
From:   Vinod <vkoul@kernel.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     corbet@lwn.net, dan.j.williams@intel.com, robh@kernel.org,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashutosh.dixit@intel.com
Subject: Re: [PATCH v2 1/2] dmaengine: add a new helper
 dmaenginem_async_device_register
Message-ID: <20180730052044.GH3661@vkoul-mobl>
References: <20180726064554.24975-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726064554.24975-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-18, 14:45, Huang Shijie wrote:
> This patch adds the dmaenginem_async_device_register for DMA code.
> Use the Devres to call the release for the DMA engine driver.

Applied both, thanks

-- 
~Vinod
