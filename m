Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B05C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E190E20663
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547421186;
	bh=KoG1ygPmLZE5kiMODamDuGDH2824TTPndRVinC8B3uM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Dbujbd47OyIQhc2MLHCspMO3KauPXfZ0MIpZUGltU/PZHairJEqJNY+IJ6yMn8HPQ
	 zUPUYTT0Jt4FTEq+wIEQQOCohRu1ZIavVgfa5Ch31iB3a0fRtzeYuBY1WR5Ufs24LH
	 8yGjw+E8gZFWb0Q4m2R+XAoUfFUYD9OvwEgKbBFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfAMXNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:13:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:37618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfAMXND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:13:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12B2EAD08;
        Sun, 13 Jan 2019 23:13:02 +0000 (UTC)
Date:   Mon, 14 Jan 2019 00:12:59 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
In-Reply-To: <20190113231001.GB18710@amd>
Message-ID: <nycvar.YFH.7.76.1901140012110.6626@cbobk.fhfr.pm>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com> <20181228103437.4c03c181@lwn.net> <aed62eaa-93b4-8dc5-1920-6a5547e349c8@linux.intel.com> <20190113231001.GB18710@amd>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Pavel Machek wrote:

> That one really is Intel-specific (not even all x86s are affectd). Same 
> for Meltdown.

At least for Meltdown, your claim is simply not correct.

-- 
Jiri Kosina
SUSE Labs

