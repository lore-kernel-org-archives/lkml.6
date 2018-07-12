Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2328FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE70B20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70B20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeGLJXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:23:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbeGLJXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:23:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E0F5ACFA;
        Thu, 12 Jul 2018 09:15:02 +0000 (UTC)
Date:   Thu, 12 Jul 2018 11:15:01 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove reliable stacktrace check in
 klp_try_switch_task()
In-Reply-To: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.21.1807121114370.5050@pobox.suse.cz>
References: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018, Kamalesh Babulal wrote:

> Support for immediate flag was removed by commit d0807da78e11
> ("livepatch: Remove immediate feature").  We bail out during
> patch registration for architectures, those don't support
> reliable stack trace. Remove the check in klp_try_switch_task(),
> as its not required.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
