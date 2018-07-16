Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F76E20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F76E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGPNKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:10:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728524AbeGPNKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:10:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 287E78315E;
        Mon, 16 Jul 2018 12:43:19 +0000 (UTC)
Received: from treble (ovpn-122-49.rdu2.redhat.com [10.10.122.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E90857C4D;
        Mon, 16 Jul 2018 12:43:18 +0000 (UTC)
Date:   Mon, 16 Jul 2018 07:43:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: livepatch: fix minor typo in shadow-vars.txt
Message-ID: <20180716124317.g42p64ay4ooehoxt@treble>
References: <1531720120-4132-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531720120-4132-1-git-send-email-kamalesh@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:43:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 16 Jul 2018 12:43:19 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:18:40AM +0530, Kamalesh Babulal wrote:
> Fix the spelling of 'varibles' -> 'variables' in
> shadows->vars.txt file.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
>  Documentation/livepatch/shadow-vars.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/livepatch/shadow-vars.txt b/Documentation/livepatch/shadow-vars.txt
> index ecc09a7be5dd..f69c6261e951 100644
> --- a/Documentation/livepatch/shadow-vars.txt
> +++ b/Documentation/livepatch/shadow-vars.txt
> @@ -150,7 +150,7 @@ In-flight parent objects
>  
>  Sometimes it may not be convenient or possible to allocate shadow
>  variables alongside their parent objects.  Or a livepatch fix may
> -require shadow varibles to only a subset of parent object instances.  In
> +require shadow variables to only a subset of parent object instances.  In

While we're at it, the sentence grammar can be fixed by changing "to" to
"for".

-- 
Josh
