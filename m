Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995E625CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995E625CA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755695AbeFYPXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:23:50 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:44406 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751878AbeFYPXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:23:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C54E5180A813C;
        Mon, 25 Jun 2018 15:23:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: veil19_209ae301ccf59
X-Filterd-Recvd-Size: 1796
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 15:23:43 +0000 (UTC)
Message-ID: <35b62e21e0de223acae0f9f468212ee9638c3544.camel@perches.com>
Subject: Re: checkpatch false positive (IMO): typo detected in truncated
 commit message
From:   Joe Perches <joe@perches.com>
To:     Jann Horn <jannh@google.com>, Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Jun 2018 08:23:42 -0700
In-Reply-To: <CAG48ez02K0N6h-nfbnY81QAZoX1_gi4DTxuHxf1bSYiifu2v7g@mail.gmail.com>
References: <CAG48ez02K0N6h-nfbnY81QAZoX1_gi4DTxuHxf1bSYiifu2v7g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 17:22 +0200, Jann Horn wrote:
> Hello!
> 
> I got the following message from checkpatch:
> 
> =======
> $ scripts/checkpatch.pl
> 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch
> WARNING: 'calle' may be misspelled - perhaps 'called'?
> #15:
> Fixes: 266d07cb1c9a ("netfilter: nf_log: fix sleeping function calle[...]")
> 
> total: 0 errors, 1 warnings, 0 checks, 20 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch has
> style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> =======
> 
> I believe that it is appropriate here to truncate the commit message
> of the fixed commit.

It's not.

