Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8054C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F2F20836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547236602;
	bh=KEVLyAJfuJH8De7aN0VwV2iTCixFCxK9tM6njO4PkV8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=CnfJOGE8sun17vxIwrtxoW6N6hYhvMEgr6KHnfAl1kBDkf9TA4SY0inB+0NdFMhKA
	 ASXQxM0x3kp2lyoCO5co9/uN3L5Bv9SuXF886x1hs7an2ZMWvwp18XGYtxduDyN+de
	 z5qAdS/eywn9EED0h15aKZxaU+tw23ku5Fzr5iAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfAKT4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:56:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:48536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729938AbfAKT4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:56:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17CF6B052;
        Fri, 11 Jan 2019 19:56:40 +0000 (UTC)
Date:   Fri, 11 Jan 2019 20:56:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 00/11] livepatch: Atomic replace feature
In-Reply-To: <20190109124329.21991-1-pmladek@suse.com>
Message-ID: <nycvar.YFH.7.76.1901112055380.6626@cbobk.fhfr.pm>
References: <20190109124329.21991-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've now applied this patchset, so please send any further fixups as 
incremental on top of for-5.1/atomic-replace.

Thanks to everybody involved (especially Petr) for the patience and all 
the invested effort.

-- 
Jiri Kosina
SUSE Labs

