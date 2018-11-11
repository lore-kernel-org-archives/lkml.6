Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651FC2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPkp7muM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651FC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKKTQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 14:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeKKTQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 14:16:16 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8E42087C;
        Sun, 11 Nov 2018 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541928493;
        bh=AnmBKQwBP5OrgF7sbBCqXPdKbq1ICLfSIYx6pJ5KXJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPkp7muMsl/UdJsjqW8cMwneDbJ84ZfkBSOptWtmkBjjHwAxQmm583txhDDBrFHJA
         2uRD1HSvV+Awah/CRNRv38F019xnnOc58DkvYvfFSieV2XBecRlTTRJpcJmnc8gLjL
         JrXC6PPW34FjawUw+LmkVlUIFUnNymR604q+iqPk=
Date:   Sun, 11 Nov 2018 14:58:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fix some typo
Message-ID: <20181111092805.GD12092@vkoul-mobl>
References: <20181101153543.22883-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101153543.22883-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-18, 11:35, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

While sending patches it is a good idea to see the convention of the
tags used. git log <file> will help you with that

Applied after adding file tag to this

-- 
~Vinod
