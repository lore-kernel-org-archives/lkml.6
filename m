Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00619C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB1620658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB1620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeJVRve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:51:34 -0400
Received: from ozlabs.org ([203.11.71.1]:36463 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeJVRve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:51:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42drth6xSvz9sDC; Mon, 22 Oct 2018 20:33:48 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cf4a6085151ae3f4e78dd91981833e65aaae8bc6
In-Reply-To: <7c34db8eca67beefa7ec8243bc07135b4dff4440.1521641523.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2,1/2] powerpc/mm: Add missing tracepoint for tlbie
Message-Id: <42drth6xSvz9sDC@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:33:48 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 14:16:58 UTC, Christophe Leroy wrote:
> commit 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
> added tracepoints for tlbie calls, but _tlbil_va() was forgotten
> 
> Fixes: 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cf4a6085151ae3f4e78dd91981833e

cheers
