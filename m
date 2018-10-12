Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E7BC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA152086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUiiOA3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA152086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJMAbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeJMAbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:31:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633C12064E;
        Fri, 12 Oct 2018 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539363463;
        bh=MblfT0VjGjz2iJ/pPcaFo9E2dQdoqK3W7MDp0eNukJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUiiOA3Nwhqp1nRLbORy50P31sPvOTAf7D8VQNd+kwzRSzvsT2d6UkXXxG5AokvSQ
         iAYHCLcJlvXON4/ElI78dx5zU+4j6iMRnFt71+o4rx0aS/cy3y7mQtT4m/mqgODC5c
         /r1HoY8sGNt2v+9InautQy4xSyKHp9mBdUJMCqd0=
Date:   Fri, 12 Oct 2018 18:57:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     thor.thayer@linux.intel.com
Cc:     geert+renesas@glider.be, jhogan@kernel.org, atull@kernel.org,
        bhelgaas@google.com, james.hartley@sondrel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Replace Vince Bridgers as Altera TSE
 maintainer
Message-ID: <20181012165741.GA12446@kroah.com>
References: <1539363052-6143-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539363052-6143-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:50:52AM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Vince has moved to a different role. Replace him as Altera
> TSE maintainer.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>

Would be nice if Vince can ack this...

