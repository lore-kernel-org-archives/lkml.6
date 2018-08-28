Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE02C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88865208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NigQTKSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88865208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeH1JGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1JGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:06:52 -0400
Received: from localhost (unknown [223.226.38.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD3D208B9;
        Tue, 28 Aug 2018 05:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535433418;
        bh=SYBLh8J77fRU1tFAaD8jW1Sirt847FKwluVLb0mWCn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NigQTKSfDAVB8198IvsSSpgnVRTOBsQgsOpTIX7KV+T1lmabIHEf1Y5mNe5QW2L3+
         SPylQQ+U8I3BuKD+qI6TQpESSQEaKbHDVhqylzU2i/XC3Zgasd51rEVpNCTpqUH76V
         yGtSJqaJoU7XDxDtin46qMt+aB+1G9ipHRyq4FE0=
Date:   Tue, 28 Aug 2018 10:46:49 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180828051649.GB2388@vkoul-mobl>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-16-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-16-robh@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-18, 20:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org

Applied after dropping CC list. thanks

-- 
~Vinod
