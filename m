Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145BAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEE020779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEE020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeGWQNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:13:04 -0400
Received: from ozlabs.org ([203.11.71.1]:38289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388387AbeGWQND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:13:03 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Z4h91xc7z9s9J; Tue, 24 Jul 2018 01:11:20 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ec9336396a98f61290f45e8bb942458a1b2f299b
In-Reply-To: <20180718161544.12134-1-muriloo@linux.ibm.com>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/prom_init: remove linux,stdout-package property
Message-Id: <41Z4h91xc7z9s9J@ozlabs.org>
Date:   Tue, 24 Jul 2018 01:11:20 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 16:15:44 UTC, Murilo Opsfelder Araujo wrote:
> This property was added in 2004 and the only use of it, which was already inside
> `#if 0`, was removed a month later.
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec9336396a98f61290f45e8bb94245

cheers
