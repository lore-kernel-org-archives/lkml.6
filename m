Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B58C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1988821479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546515960;
	bh=ew02E7Pws5/0WnMLm/Bz6feHNGUJH53KsudmuFh2XZU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=F5bi8eod6IBf99Mt+EflslyKfHeogaanZ1zoYzpJBERZ6IUaUAxTM2toxcV48bow0
	 cV87sUI7G12agy8N2PkuJnKDr/0aMRLdyCkFCt6kPi5XGZF0AjzNex4ou7nq7ydzIJ
	 F4l+8ylmfQ7A9rbpawEChXMxTXePfjbPDK2YJEJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfACLp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:45:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfACLp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:45:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19CB4ACAE;
        Thu,  3 Jan 2019 11:45:57 +0000 (UTC)
Date:   Thu, 3 Jan 2019 12:45:56 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [GIT PULL] HID for 4.21
In-Reply-To: <nycvar.YFH.7.76.1901031231040.14047@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1901031242110.14047@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901031231040.14047@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019, Jiri Kosina wrote:

> Linus,
> 
> please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
> 
> to receive HID merge window updates.
> 
> =====
> This round is particularly tiny. Some highlights:
> 
> - MSI IRQ support for intel-ish driver, from Song Hongyan
> - support for new hardware (Cougar 700K, Odys Winbook 13) from
>   Daniel M. Lambea and Hans de Goede
> - other small assorted fixups
> =====

Linus, please scratch this pull request, I by mistake dropped the 
highres-wheel branch (thanks Benjamin for noticing my brainfart). I'll 
resend shortly. Sorry,

-- 
Jiri Kosina
SUSE Labs

