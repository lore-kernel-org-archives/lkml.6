Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC79C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86AE21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86AE21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbeIUJGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeIUJGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:06:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDA46308402B;
        Fri, 21 Sep 2018 03:19:31 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEB145C54F;
        Fri, 21 Sep 2018 03:19:30 +0000 (UTC)
Date:   Fri, 21 Sep 2018 11:19:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        x86@kernel.org, thgarnie@google.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 3/3] x86/doc/kaslr.txt: Create a separate part of
 document abourt KASLR at the end of file
Message-ID: <20180921031927.GS2555@MiWiFi-R3L-srv>
References: <20180921020550.13095-1-bhe@redhat.com>
 <20180921020550.13095-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921020550.13095-4-bhe@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 21 Sep 2018 03:19:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/18 at 10:05am, Baoquan He wrote:
> +Name 		Starting address	   Size						Aligned
> +-----------------------------------------------------------------------------------------------
> +direct mapping  page_offset_base	[actual size of system RAM + 10 TB padding]	1 GB
> +*guard hole	random			random						1 GB
> +vmalloc		vmalloc_base		32 TB						1 GB
> +*guard hole	random			random						1 GB
> +vmemmap		vmemmap_base		1 TB						1 GB
> +*guard hole	random			random						1 GB

OK, seems tab is uncontrollable, I will use space instead.
