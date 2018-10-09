Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37931C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3552054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xwM8nZW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3552054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJIUmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJIUmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:42:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4406921479;
        Tue,  9 Oct 2018 13:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539091512;
        bh=WVLqyDzMfHFkQ609SYCTb7hVLNxECcFXgDnGpsE3m4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xwM8nZW9xas70kJdBK92anVKyrS4CBZGboWaP+gRnFEcRfXvmi8DsybiP9qsvoQfr
         L1fyjH4lASXgCOIaLBwllPUHXu1yQwUwqgK4cOmTDAuFjpBMYEMLEXNntkhl0tHvKK
         jhJVWWJXAd5LKTT6doBpa64yyhR4UzXp4eh6T5bM=
Date:   Tue, 9 Oct 2018 15:25:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 02/11] staging:rtl8192u: Removed commented out include -
 Style
Message-ID: <20181009132509.GA24623@kroah.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
 <20181007214025.25469-3-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007214025.25469-3-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 10:40:16PM +0100, John Whitmore wrote:
> Remove commented out #include directive.
> 
> Additionally shorted a block comment to clear the checkpatch issue
> with line length.

You really should only do one type of thing per patch, but I'll let this
one go...

