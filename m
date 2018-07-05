Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B800C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E872403B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1AqHcUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E872403B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeGENY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753947AbeGENY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:24:27 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F91A24037;
        Thu,  5 Jul 2018 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530797067;
        bh=Jo/gSbtR1S5x33Nkem4adhcfcJLovd7wL8hsJfdx6eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1AqHcUfEvbk4jAG8hEuFiHuRDQlUnwKKBcB2wIJZbzLSVdIjsGNCNSw6UtFjPWsC
         40eDQ+EgDtGf7sJbZECTAHJTAUEIVeVxW8aKU5OgBWRjbMbbcFuXE+jFBadAtn3FRu
         d68xf3BuHw8YHseMqM7LilX3cmXBhwkRo/wXIOKw=
Date:   Thu, 5 Jul 2018 18:54:18 +0530
From:   Vinod <vkoul@kernel.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 6/6] crypto: qcom: Add ACPI support
Message-ID: <20180705132418.GL22377@vkoul-mobl>
References: <20180704114427.29953-1-vkoul@kernel.org>
 <20180704114427.29953-7-vkoul@kernel.org>
 <b06a0327-bbfe-5f7c-c0e1-43227ce089ae@kernel.org>
 <20180705060733.GH22377@vkoul-mobl>
 <d59553c0-5b7c-87cc-76a6-ef70016ee6be@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59553c0-5b7c-87cc-76a6-ef70016ee6be@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-18, 07:23, Timur Tabi wrote:
> On 7/5/18 1:07 AM, Vinod wrote:
> > Meanwhile any word from testing on ACPI systems?
> 
> Jeff Hugo is handling that for me.  Since it's a whole new API, he's had to
> start over.

Okay great, I have already been thru the hoops, so please do ping me if
you folks have questions.

Thanks
-- 
~Vinod
