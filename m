Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B90ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830552064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830552064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJJBFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:05:10 -0400
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:43844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbeJJBFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:05:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 36531180A8459;
        Tue,  9 Oct 2018 17:47:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grain81_1fe660c1bae26
X-Filterd-Recvd-Size: 2351
Received: from XPS-9350 (unknown [172.58.41.87])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Oct 2018 17:46:58 +0000 (UTC)
Message-ID: <262d8a05cedc76bc90fa5be7d3b92d5faa2b4ce9.camel@perches.com>
Subject: Re: [Patch v2] MAINTAINERS: intel_telemetry: Update maintainers info
From:   Joe Perches <joe@perches.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com,
        david.e.box@linux.intel.com
Date:   Tue, 09 Oct 2018 10:46:56 -0700
In-Reply-To: <20181009141833.25972-1-rajneesh.bhardwaj@linux.intel.com>
References: <20181009141833.25972-1-rajneesh.bhardwaj@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-09 at 19:48 +0530, Rajneesh Bhardwaj wrote:
> Add myself and David as the new maintainers for Intel Telemetry driver
> since Souvik no longer works with Intel. David and I work on power
> management and debug related drivers which are pretty close to this one
> in terms of functionalities so volunteering for the task.
> 
> Signed-off-by: Box, David E <david.e.box@linux.intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 22065048d89d..f33ebd1b8034 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7530,7 +7530,8 @@ F:	arch/x86/crypto/sha*-mb/
>  F:	crypto/mcryptd.c
>  
>  INTEL TELEMETRY DRIVER
> -M:	Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> +M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> +M:	Box, David E <david.e.box@linux.intel.com>

It is better to quote your name when it uses
non-alphabetic characters like periods and commas.

Especially the comma because that is commonly used
by email clients as a multiple address separator so
it makes copy/paste use error-prone.

It's also likely better to use a more typical
"First <Initial> Last" name style. 

>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	arch/x86/include/asm/intel_telemetry.hch mor

