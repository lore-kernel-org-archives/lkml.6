Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C09ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C3F2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C3F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeJRBHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbeJRBHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 683B7AE6E;
        Wed, 17 Oct 2018 17:10:36 +0000 (UTC)
Date:   Wed, 17 Oct 2018 19:10:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/mcelog: Remove one mce_helper definition
Message-ID: <20181017171034.GO22571@zn.tnic>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
 <20181017170554.18841-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181017170554.18841-3-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 07:05:53PM +0200, Sebastian Andrzej Siewior wrote:
> Commit 5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog
> driver") moved the old interface into one file including mce_helper
> definition as static and "extern".
> 
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: linux-edac <linux-edac@vger.kernel.org>
> Cc: x86@kernel.org
> Fixes:  5de97c9f6d85f ("x86/mce: Factor out and deprecate the /dev/mcelog driver")

I'm not sure about the Fixes: tag - it'll trigger a flood of backporting
for no reason AFAICT.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
