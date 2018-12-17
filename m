Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704BDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4645820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeLQRxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:53:21 -0500
Received: from cheddar.halon.org.uk ([93.93.131.118]:40458 "EHLO
        cheddar.halon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLQRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:53:18 -0500
Received: from bsmtp by cheddar.halon.org.uk with local-bsmtp (Exim 4.89)
        (envelope-from <93sam@debian.org>)
        id 1gYx4q-0000F6-Ge; Mon, 17 Dec 2018 17:53:12 +0000
Received: from steve by tack.einval.org with local (Exim 4.89)
        (envelope-from <93sam@debian.org>)
        id 1gYx4D-0000eJ-NB; Mon, 17 Dec 2018 17:52:33 +0000
Date:   Mon, 17 Dec 2018 17:52:33 +0000
From:   Steve McIntyre <93sam@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 087/361] signal: Introduce COMPAT_SIGMINSTKSZ for
 use in compat_sys_sigaltstack
Message-ID: <20181217175228.3wlx6ad7xnjrp2o5@tack.einval.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221632.025807083@linuxfoundation.org>
 <20181112114857.2aidwlw2podpzytb@tack.einval.com>
 <20181119151551.GC5340@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119151551.GC5340@kroah.com>
X-attached: none
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 04:15:51PM +0100, Greg Kroah-Hartman wrote:
>On Mon, Nov 12, 2018 at 11:49:05AM +0000, Steve McIntyre wrote:

...

>> Thanks Greg! If it's not too much effort, could you also take this for
>> 4.9-stable as well please? That would get it into our next Debian
>> stable update too. :-)
>
>Does not apply to 4.9.y, can you provide a working backport?

No problem. It's a bit belated (sorry!) but the fixup is fairly
obvious. On its way in separate mail shortly.

-- 
Steve McIntyre, Cambridge, UK.                                steve@einval.com
"We're the technical experts.  We were hired so that management could
 ignore our recommendations and tell us how to do our jobs."  -- Mike Andrews

