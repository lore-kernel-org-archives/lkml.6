Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4EBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1104321B6A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404684AbeLVRBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:05 -0500
Received: from ozlabs.org ([203.11.71.1]:37977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbeLVRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:02 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSp49M5z9sPJ; Sat, 22 Dec 2018 20:54:50 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8dbdec0bcb416d0ef0bfd737620d08f5160ac290
X-Patchwork-Hint: ignore
In-Reply-To: <20181216172828.GA25359@altlinux.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/ptrace: cleanup do_syscall_trace_enter
Message-Id: <43MLSp49M5z9sPJ@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:50 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-16 at 17:28:28 UTC, "Dmitry V. Levin" wrote:
> Invoke tracehook_report_syscall_entry once.
> 
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8dbdec0bcb416d0ef0bfd737620d08

cheers
