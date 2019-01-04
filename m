Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DFBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBA721872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfADM6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:58:00 -0500
Received: from ozlabs.org ([203.11.71.1]:34337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfADM6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:58:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43WPw55cvZz9s7T; Fri,  4 Jan 2019 23:57:57 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 074400a7be61250d9f0ccec07d5c35ffec4d8d22
X-Patchwork-Hint: ignore
In-Reply-To: <20190104092758.4378-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Remove 'type' argument from access_ok() function
Message-Id: <43WPw55cvZz9s7T@ozlabs.org>
Date:   Fri,  4 Jan 2019 23:57:57 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-04 at 09:27:58 UTC, Mathieu Malaterre wrote:
> In commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") an attempt was made to remove a warning by referencing the
> variable `type`, however in commit 96d4f267e40f ("Remove 'type' argument
> from access_ok() function") the variable `type` has been removed.
> 
> Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") to fix the following compilation error:
> 
>   arch/powerpc/include/asm/uaccess.h:66:32: error: âtypeâ undeclared (first use in this function)
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/074400a7be61250d9f0ccec07d5c35

cheers
