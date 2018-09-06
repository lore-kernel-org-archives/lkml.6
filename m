Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E23C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5416B204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="NX56F4GI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5416B204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeIFTR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:17:28 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:55716 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729183AbeIFTR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1536244897;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=O6ivjs7jluVSGrqXfZpiCc++i7p+BKvaQQl6NlWNcsA=;
        b=NX56F4GIQJ4fPG8uY68aGB6gTvt+63Hbad3n1K0baVOmzBPErLL7eqrLhJzgYZ1t
        4t4RfxtjHYKJp/qRVcrDZs7nTmmstb5IVNgIOYxpyviipsRnsp6O2U4A2vWCr5aK7Gx
        6L4vQT4EaB0t1DsmOOKZU28VPNa0kGhwGMfG8Hzg=
Date:   Thu, 6 Sep 2018 14:41:37 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        ldufour@linux.vnet.ibm.com, Pavel.Tatashin@microsoft.com,
        paulmck@linux.vnet.ibm.com, shady.issa@oracle.com,
        tariqt@mellanox.com, tglx@linutronix.de, tim.c.chen@intel.com,
        vbabka@suse.cz, longman@redhat.com, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
In-Reply-To: <877ejzqtdy.fsf@yhuang-dev.intel.com>
Message-ID: <01000165af54d553-33f33ce2-7b36-4d67-a928-e53b10247e1d-000000@email.amazonses.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com> <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com> <877ejzqtdy.fsf@yhuang-dev.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-SES-Outgoing: 2018.09.06-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018, Huang, Ying wrote:

> > Certainly interested in attending but this overlaps supercomputing 2018 in
> > Dallas Texas...
>
> Sorry to know this.  It appears that there are too many conferences in
> November...

 I will try to get to it in the middle of SC18, RDMA track and RISC V
track... Sign me up.

