Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F814ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4CA20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtphZp7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4CA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeGTKUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbeGTKUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:20:05 -0400
Received: from localhost (unknown [106.51.19.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DFC9206B7;
        Fri, 20 Jul 2018 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532079162;
        bh=OStE2f4cXnou/ab++WDMKuwrISqYPCCsJxb5Vr8nlR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtphZp7+B/57CTF01DHHXQvwrU9IGlmwPLHonaqKgdHCYuzloRTjDjjTAFOJZgI8c
         0aOsLKdLnQ5zjKGCoDzC18PdPJiOBP8AN14C5BznxPhquykIylhHf/r9KaqweFXyvY
         QvrXTkncuSkgEC45L694hE699qlvr5XQV/9+/HnE=
Date:   Fri, 20 Jul 2018 15:02:37 +0530
From:   Vinod <vkoul@kernel.org>
To:     hannah@marvell.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
        nadavh@marvell.com, omrii@marvell.com, oferh@marvell.com,
        gregory.clement@bootlin.com
Subject: Re: [PATCH 0/5] dmaengine: mv_xor_v2: fixes and alignment for XOR-v2
 driver
Message-ID: <20180720093237.GS3219@vkoul-mobl>
References: <1531823403-3683-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531823403-3683-1-git-send-email-hannah@marvell.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-18, 13:29, hannah@marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> This series bring some minor fixes & alignmnet to the driver of
> Marvell XOR-v2 engine.

Applied after fixing typo is 3rd patch, thanks

-- 
~Vinod
