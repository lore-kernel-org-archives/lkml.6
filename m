Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD7DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E93520989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E93520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeK0UTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:19:36 -0500
Received: from ozlabs.org ([203.11.71.1]:40843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbeK0UTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:19:36 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 433ywp4SMFz9s55; Tue, 27 Nov 2018 20:22:18 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c516886f8437b85489d06115c54761880c7d67ac
In-Reply-To: <20181031110308.8194-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: =?utf-8?q?powerpc/mm=3A_remove_const_type_qualifier_from_function_?= =?utf-8?b?4oCYcHVkX3BmbuKAmQ==?=
Message-Id: <433ywp4SMFz9s55@ozlabs.org>
Date:   Tue, 27 Nov 2018 20:22:18 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 11:03:07 UTC, Mathieu Malaterre wrote:
> Type qualifier on return type is ignored. Remove warning in W=1:
> 
>   arch/powerpc/include/asm/book3s/64/pgtable.h:1268:25: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c516886f8437b85489d06115c54761

cheers
