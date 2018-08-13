Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DF7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEC82174D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEC82174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeHNBkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:40:37 -0400
Received: from namei.org ([65.99.196.166]:43064 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbeHNBkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:40:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7DMuHkp003247;
        Mon, 13 Aug 2018 22:56:17 GMT
Date:   Tue, 14 Aug 2018 08:56:17 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] security subsystem: general update for v4.19
In-Reply-To: <alpine.LRH.2.21.1808140835030.2526@namei.org>
Message-ID: <alpine.LRH.2.21.1808140855520.3087@namei.org>
References: <alpine.LRH.2.21.1808140835030.2526@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, James Morris wrote:

> I'll followup with updates for Smack and TPM once this is merged.

As well as an update for the Integrity subsystem.

-- 
James Morris
<jmorris@namei.org>

