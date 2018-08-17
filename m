Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A8DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5392E21A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5392E21A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeHQTVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:21:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeHQTVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:21:30 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F55FBD4;
        Fri, 17 Aug 2018 16:17:31 +0000 (UTC)
Date:   Fri, 17 Aug 2018 18:17:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: Current LTS and their EOL
Message-ID: <20180817161727.GA24945@kroah.com>
References: <20180817154006.GA3725@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817154006.GA3725@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 08:40:06AM -0700, Rodrigo Vivi wrote:
> Hi Greg, Ben, and all
> 
> Is https://www.kernel.org/category/releases.html updated in terms of EOL?

As of right now, for the kernels I maintain, yes, it is correct.

> Some news out of Linaro conference [2] generated a lot of doubts and questions
> around.
> 
> Specially because on the way it was stated by the news 3.16 wouldn't be active
> anymore. So I'm not sure about the news, but I'd like confirmation from you about
> expected EOL.

Linaro has nothing to do with the 3.16 kernel, so why are you confusing
that with what was announced at that conference, which was about the 4.4
kernel tree?

thanks,

greg k-h
