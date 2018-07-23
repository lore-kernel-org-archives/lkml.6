Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B33BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5623E20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5623E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbeGWQMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:12:55 -0400
Received: from ozlabs.org ([203.11.71.1]:54415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387859AbeGWQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:12:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Z4h14DHpz9s3N; Tue, 24 Jul 2018 01:11:11 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d69ccc00c497a4d81fca2dca9bda9f7799971b38
In-Reply-To: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
To:     Michael Hanselmann <linux-kernel@hansmi.ch>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Mark ams driver as orphaned in MAINTAINERS
Message-Id: <41Z4h14DHpz9s3N@ozlabs.org>
Date:   Tue, 24 Jul 2018 01:11:11 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-01-29 at 22:40:09 UTC, Michael Hanselmann wrote:
> I no longer have any hardware with the Apple motion sensor and thus
> relinquish maintainership of the driver.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d69ccc00c497a4d81fca2dca9bda9f

cheers
