Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09422C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D225520B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfBFK2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:28:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfBFK2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:28:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94A88B6AB;
        Wed,  6 Feb 2019 10:28:34 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:28:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of ENOSYS
Message-ID: <20190206102832.apa7sekkwljo4ejg@pathway.suse.cz>
References: <20190204183324.30775-1-alicef@alicef.me>
 <20190205155933.r6ey474lq4m5nlmp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205155933.r6ey474lq4m5nlmp@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-05 09:59:33, Josh Poimboeuf wrote:
> On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> > From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > 
> > As a result of an unsupported operation is better to use EOPNOTSUPP
> > as error code.
> > ENOSYS is only used for 'invalid syscall nr' and nothing else.
> > 
> > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

I have applied the patch into for-5.1/atomic-replace branch.

Best Regards,
Petr
