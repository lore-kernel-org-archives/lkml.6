Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1AC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3862087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3862087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeJOLoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:44:24 -0400
Received: from ozlabs.org ([203.11.71.1]:33499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeJOLoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:44:24 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42YPqv1dT2z9sDJ; Mon, 15 Oct 2018 15:00:59 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0792a2c8e0bbda3605b8d42c6b9635be7b19982a
In-Reply-To: <7a0748d8cd97964a99879a0b9f1c0243c677c7c3.1536709753.git.fthain@telegraphics.com.au>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [1/7] macintosh: Use common code to access RTC
Message-Id: <42YPqv1dT2z9sDJ@ozlabs.org>
Date:   Mon, 15 Oct 2018 15:00:59 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-12 at 00:18:44 UTC, Finn Thain wrote:
> Now that the 68k Mac port has adopted the via-pmu driver, the same RTC
> code can be shared between m68k and powerpc. Replace duplicated code in
> arch/powerpc and arch/m68k with common RTC accessors for Cuda and PMU.
> 
> Drop the problematic WARN_ON which was introduced in commit 22db552b50fa
> ("powerpc/powermac: Fix rtc read/write functions").
> 
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0792a2c8e0bbda3605b8d42c6b9635

cheers
