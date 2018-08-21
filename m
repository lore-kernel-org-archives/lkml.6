Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE29C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89765214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89765214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeHUQSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:18:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeHUQSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:18:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so5306569wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJeTZCFZ6Vc724C5uEYbt7sNJqz7l1QoeZkwSeK1ZDQ=;
        b=LbvUfxAOOkCoKSEeZjh8oKWCQXjU3PDUif1LqXQdk3fHSXFci5YR/B1hR+KpCk9nsG
         NelIwREKfBCcjLdaTExCeHYjn10PvKUyZyk+3XZEVXwI9p72Ic76YUf+IXv24goeK+ev
         rp86UFUtqJBdc3snL6oycCQOuvo7i+YLL3WjEJ6jJwlSFE3H+MjbyjvDybWes1AmBls7
         LqjeXXM/UUQocPND61CEvFwyqkrcOqVG/39ywkiLS4CPq4mKsTyl/O0iW4gdBORUWNJv
         GJfuVDX03ttyA2pN/EeM6EvNMCN6viuT6/XaVtcflQ0jwCDOC2i3uAQQlIrQXHHTrgdN
         BceQ==
X-Gm-Message-State: APzg51BZrwALorWFiVWvx85nMms2GkxIdvQe7XzjsMP6MpmpueV0Evfb
        gDAev0qVAWPEIk2DFNe/frA=
X-Google-Smtp-Source: ANB0VdYIAsOhmGhYZBQvWRX474wkfVyBb2cPKHfQ6/GSDYaXcfsevA1sFQWugnKsbtqkO6Y8FQT8SQ==
X-Received: by 2002:adf:a11c:: with SMTP id o28-v6mr11236890wro.169.1534856328037;
        Tue, 21 Aug 2018 05:58:48 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id g6-v6sm2370606wmf.16.2018.08.21.05.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:58:47 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id BBA911249C5; Tue, 21 Aug 2018 14:58:46 +0200 (CEST)
Date:   Tue, 21 Aug 2018 14:58:46 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Message-ID: <20180821125846.GB9489@techadventures.net>
References: <20180820085516.9687-1-osalvador@techadventures.net>
 <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
 <20180821121734.GA29735@dhcp22.suse.cz>
 <20180821123024.GA9489@techadventures.net>
 <20180821125156.GB29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821125156.GB29735@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:51:56PM +0200, Michal Hocko wrote:
> On Tue 21-08-18 14:30:24, Oscar Salvador wrote:
> > On Tue, Aug 21, 2018 at 02:17:34PM +0200, Michal Hocko wrote:
> > > We do have CONFIG_NODES_SHIFT=10 in our SLES kernels for quite some
> > > time (around SLE11-SP3 AFAICS).
> > > 
> > > Anyway, isn't NODES_ALLOC over engineered a bit? Does actually even do
> > > larger than 1024 NUMA nodes? This would be 128B and from a quick glance
> > > it seems that none of those functions are called in deep stacks. I
> > > haven't gone through all of them but a patch which checks them all and
> > > removes NODES_ALLOC would be quite nice IMHO.
> > 
> > No, maximum we can get is 1024 NUMA nodes.
> > I checked this when writing another patch [1], and since having gone
> > through all archs Kconfigs, CONFIG_NODES_SHIFT=10 is the limit.
> > 
> > NODEMASK_ALLOC gets only called from:
> > 
> > - unregister_mem_sect_under_nodes() (not anymore after [1])
> > - __nr_hugepages_store_common (This does not seem to have a deep stack, we could use a normal nodemask_t)
> > 
> > But is also used for NODEMASK_SCRATCH (mainly used for mempolicy):
> 
> mempolicy code should be a shallow stack as well. Mostly the syscall
> entry.

Ok, then I could give it a try and see if we can get rid of NODEMASK_ALLOC in there
as well.

-- 
Oscar Salvador
SUSE L3
