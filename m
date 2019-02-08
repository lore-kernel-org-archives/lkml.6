Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B288C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C3820823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfBHQbn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfBHQbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:31:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E15E088E52;
        Fri,  8 Feb 2019 16:31:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88AEB10002B9;
        Fri,  8 Feb 2019 16:31:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ce8d60c2-5166-6c40-011f-4dff8dc25ebe@oracle.com>
References: <ce8d60c2-5166-6c40-011f-4dff8dc25ebe@oracle.com> <20190205012224.65672-1-cai@lca.pw>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     dhowells@redhat.com, Qian Cai <cai@lca.pw>,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] hugetlbfs: a terminator for hugetlb_param_specs[]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16206.1549643499.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 08 Feb 2019 16:31:39 +0000
Message-ID: <16207.1549643499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 08 Feb 2019 16:31:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Thanks for fixing this.  Looks like a simple oversight when 2284cf59cbce
> was added.

I've already pushed a fix for this which Al should have folded in already.

> FYI David, the fs_parameter_spec example in the documentation (mount_api.txt)
> is also missing a terminator.

Thanks.

David
