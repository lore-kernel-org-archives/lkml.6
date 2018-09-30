Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AFDC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 06:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4E1206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 06:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4E1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeI3NFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 09:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeI3NFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 09:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2421308424F;
        Sun, 30 Sep 2018 06:34:07 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADB3A5D985;
        Sun, 30 Sep 2018 06:34:03 +0000 (UTC)
Date:   Sun, 30 Sep 2018 14:34:01 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kselftest@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] userfaultfd: selftest: cleanup help messages
Message-ID: <20180930063401.GA18728@xz-x1>
References: <20180929084311.15600-1-peterx@redhat.com>
 <20180929084311.15600-2-peterx@redhat.com>
 <20180929102811.GA6429@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180929102811.GA6429@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 30 Sep 2018 06:34:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 01:28:12PM +0300, Mike Rapoport wrote:

[...]

> > +const char *examples =
> > +    "# 100MiB 99999 bounces\n"
> > +    "./userfaultfd anon 100 99999\n"
> > +    "\n"
> > +    "# 1GiB 99 bounces\n"
> > +    "./userfaultfd anon 1000 99\n"
> > +    "\n"
> > +    "# 10MiB-~6GiB 999 bounces, continue forever unless an error triggers\n"
> > +    "while ./userfaultfd anon $[RANDOM % 6000 + 10] 999; do true; done\n"
> > +    "\n";
> 
> While at it, can you please update the examples to include other test
> types?

Sure thing.

Thanks for the quick review!

Regards,

-- 
Peter Xu
