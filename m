Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DEC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87E42133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87E42133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeIMAoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:44:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeIMAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:44:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE52CD9C;
        Wed, 12 Sep 2018 19:38:36 +0000 (UTC)
Date:   Wed, 12 Sep 2018 21:38:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     stable@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: Re: [stable PATCH 2/2] arm64: Handle mismatched cache type
Message-ID: <20180912193834.GG21563@kroah.com>
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
 <1536052210-11625-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536052210-11625-2-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 10:10:10AM +0100, Suzuki K Poulose wrote:
> commit 314d53d297980676011e6fd83dac60db4a01dc70 upstream
> 
> Track mismatches in the cache type register (CTR_EL0), other
> than the D/I min line sizes and trap user accesses if there are any.
> 
> Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
> Cc: <stable@vger.kernel.org> # v4.9

Same 4.9 question here as well.

thanks,

greg k-h
