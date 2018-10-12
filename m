Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D35C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7F42075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7F42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeJMATa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:19:30 -0400
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:59012 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbeJMAT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:19:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EAA1E181D341A;
        Fri, 12 Oct 2018 16:46:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waves17_6f935b1d06038
X-Filterd-Recvd-Size: 1916
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 12 Oct 2018 16:46:06 +0000 (UTC)
Message-ID: <6fd036103f87d52214694ac0a172527a113c07b5.camel@perches.com>
Subject: Re: [PATCH V3] MAINTAINERS: intel_telemetry: Update maintainers info
From:   Joe Perches <joe@perches.com>
To:     "David E. Box" <david.e.box@intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@linux.intel.com
Date:   Fri, 12 Oct 2018 09:46:05 -0700
In-Reply-To: <20181012162816.14396-1-david.e.box@intel.com>
References: <262d8a05cedc76bc90fa5be7d3b92d5faa2b4ce9.camel@perches.com>
         <20181012162816.14396-1-david.e.box@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-12 at 09:28 -0700, David E. Box wrote:
> Remove Souvik who has left this role. Add Rajneesh and David who work
> jointly on telemetry updates for new platforms.
> 
> Signed-off-by: David E. Box <david.e.box@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -7355,7 +7355,8 @@ F:	arch/x86/crypto/sha*-mb
>  F:	crypto/mcryptd.c
>  
>  INTEL TELEMETRY DRIVER
> -M:	Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> +M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> +M:	"David E. Box" <david.e.box@linux.intel.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained

	S: Status, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.

Perhaps this is driver status should be marked

	"S:	Supported"

>  F:	arch/x86/include/asm/intel_telemetry.h

