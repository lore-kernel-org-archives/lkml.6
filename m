Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE8C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 22:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888B724D59
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 22:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888B724D59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeFWWyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 18:54:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751625AbeFWWyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 18:54:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07A6240AC6DF;
        Sat, 23 Jun 2018 22:54:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5FCD1C73D;
        Sat, 23 Jun 2018 22:54:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de> <cover.1529706536.git.reinette.chatre@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     dhowells@redhat.com, Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V7 00/41] Intel(R) Resource Director Technology Cache Pseudo-Locking enabling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14112.1529794442.1@warthog.procyon.org.uk>
Date:   Sat, 23 Jun 2018 23:54:02 +0100
Message-ID: <14113.1529794442@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 23 Jun 2018 22:54:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 23 Jun 2018 22:54:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:

> I've also created a branch based on Davids mount-context branch, applied
> the cleanup patch below to it and merged the for-vfs branch on top.
> 
> David feel free to pull the result from
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs-merged

I have some other fixes folded into my copy, so I won't pull this, but thanks
anyway.

David
