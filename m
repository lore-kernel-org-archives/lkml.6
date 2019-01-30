Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DEA218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548854928;
	bh=G+NzTZ5T2O4c7tvvtBgYus0Iu7akyNa34hReIPLpOi0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=gRZkcKkfSKYtHYCUU6qvIyXXzfZU9k/eRPabEZIy9QbB0dPlgeWmwR4FaTAql8TIU
	 Ays57E7/ofDCHH1xu1U7BShkWFzkFB/7ObVg4MNSFapk1dJtqJ+EYQlHQuenFUu7bN
	 3EdG8DT//oZjh8SweBxZ8rf7dnjjmtXNeURAAXPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfA3N2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:28:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:46162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfA3N2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:28:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 428CFAEF8;
        Wed, 30 Jan 2019 13:28:44 +0000 (UTC)
Date:   Wed, 30 Jan 2019 14:28:43 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 0/4] powerpc/livepatch: reliable stack unwinder fixes
In-Reply-To: <87y372pc75.fsf@concordia.ellerman.id.au>
Message-ID: <nycvar.YFH.7.76.1901301427320.6626@cbobk.fhfr.pm>
References: <20190122155724.27557-1-joe.lawrence@redhat.com> <nycvar.YFH.7.76.1901300049470.6626@cbobk.fhfr.pm> <87y372pc75.fsf@concordia.ellerman.id.au>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Michael Ellerman wrote:

> I'm happy to take it, unless there's some reason you'd rather it go via 
> the LP tree?

As this is more about reliable stack unwinding than live patching per se 
(which is only a user of that facility), I'd actually slightly prefer if 
it goes via your tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs

