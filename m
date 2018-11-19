Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C8A20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C8A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeKTAAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:00:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:47726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeKTAAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:00:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 692EEAD48;
        Mon, 19 Nov 2018 13:36:33 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:36:32 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] l1tf: drop the swap storage limit restriction when
 l1tf=off
In-Reply-To: <20181114073229.GC23419@dhcp22.suse.cz>
Message-ID: <nycvar.YFH.7.76.1811191436140.21108@cbobk.fhfr.pm>
References: <20181113184910.26697-1-mhocko@kernel.org> <nycvar.YFH.7.76.1811132054521.19754@cbobk.fhfr.pm> <20181114073229.GC23419@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Michal Hocko wrote:

> > > +				It also drops the swap size and available
> > > +				RAM limit restriction.
> > 
> > Minor nit: I think this should explicitly mention that those two things 
> > are related to bare metal mitigation, to avoid any confusion (as otherwise 
> > the l1tf cmdline parameter is purely about hypervisor mitigations).
> 
> Do you have any specific wording in mind?
> 
> It also drops the swap size and available RAM limit restrictions on both
> hypervisor and bare metal.
> 
> Sounds better?
> 
> > With that
> > 
> > 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> Thanks!

Yes, I think that makes it absolutely clear. Thanks,

-- 
Jiri Kosina
SUSE Labs

