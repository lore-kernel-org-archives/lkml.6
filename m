Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A022821746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A022821746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeHMOFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:05:00 -0400
Received: from ozlabs.org ([203.11.71.1]:58517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMOE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:57 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptd634t0z9sBD; Mon, 13 Aug 2018 21:23:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fce278af81daf8599f9e94883cbe43068b6c4785
In-Reply-To: <20180622192749.24954-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: =?utf-8?q?powerpc/mm=3A_remove_warning_about_=E2=80=98type?= =?utf-8?q?=E2=80=99_being_set?=
Message-Id: <41ptd634t0z9sBD@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:23:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 19:27:47 UTC, Mathieu Malaterre wrote:
> ‘type’ is only used when CONFIG_DEBUG_HIGHMEM is set. So add a possibly
> unused tag to variable. Remove warning treated as error with W=1:
> 
>   arch/powerpc/mm/highmem.c:59:6: error: variable ‘type’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fce278af81daf8599f9e94883cbe43

cheers
