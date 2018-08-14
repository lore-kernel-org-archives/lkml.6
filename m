Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E4C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF7221709
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF7221709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbeHNTGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:06:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728978AbeHNTGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA42F4219DD2;
        Tue, 14 Aug 2018 16:18:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-8.rdu2.redhat.com [10.10.121.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A11410FFE70;
        Tue, 14 Aug 2018 16:18:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     dhowells@redhat.com, tony.luck@intel.com, fenghua.yu@intel.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oleg@redhat.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] Use ARRAY_SIZE to replace its implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30999.1534263506.1@warthog.procyon.org.uk>
Date:   Tue, 14 Aug 2018 17:18:26 +0100
Message-ID: <31000.1534263506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 14 Aug 2018 16:18:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 14 Aug 2018 16:18:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> "Use ARRAY_SIZE to replace its implementation"

Um, the subject line doesn't make sense.

David
