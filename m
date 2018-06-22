Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7184AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D26241DC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D26241DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbeFVMfI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:35:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751295AbeFVMfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 516FA401C87C;
        Fri, 22 Jun 2018 12:35:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB2F511166E1;
        Fri, 22 Jun 2018 12:35:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1529546567-74814-1-git-send-email-weiyongjun1@huawei.com>
References: <1529546567-74814-1-git-send-email-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] mqueue: fix a typo in mq_init_ns()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28834.1529670904.1@warthog.procyon.org.uk>
Date:   Fri, 22 Jun 2018 13:35:04 +0100
Message-ID: <28835.1529670904@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 12:35:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 22 Jun 2018 12:35:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fix a typo, use 'm' instead of 'ns->mq_mnt'.

I've folded this into the original patch, thanks.

David
