Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E47208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqKdMTJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E47208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeKKUXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeKKUXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:23:13 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A41120871;
        Sun, 11 Nov 2018 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541932501;
        bh=ciUZpi9tYqyW6YPHFyaiufbPhiJvoijUa2iPtM8HWZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqKdMTJkruPqfxQ57eh+aLDTWppDPB0MDTkcbXxSwp91iNZuyOmbdHb+GI/CYiSOP
         sZttxlchrcv6/3jv36UlA3mGCEJbWYuYOAjQ1TSB/JJKbVP8+HsR6/Gd7YESmRLiPr
         y7H/TOdWOk3aYdkmkaWN/GhHivsb3QZBECrcqtYE=
Date:   Sun, 11 Nov 2018 16:04:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dmaengine: xilinx_dma: Minor fix and refactoring
Message-ID: <20181111103453.GH12092@vkoul-mobl>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-18, 11:17, Radhey Shyam Pandey wrote:
> This patchset fixes 64-bit simple CDMA transfer.
> It also does some trivial code refactoring.

Applied except 2nd patch, thanks

-- 
~Vinod
