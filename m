Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F598C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5822075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5822075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIFNPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:15:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727827AbeIFNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 457EE804BAAD;
        Thu,  6 Sep 2018 08:41:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E5FD2166B41;
        Thu,  6 Sep 2018 08:41:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000006082bd05752f92bb@google.com>
References: <0000000000006082bd05752f92bb@google.com>
To:     syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        alexander.levin@verizon.com, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, luc.vanoostenryck@gmail.com,
        nikolaus.voss@loewensteinmedical.de, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Subject: Re: linux-next boot error (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29978.1536223287.1@warthog.procyon.org.uk>
Date:   Thu, 06 Sep 2018 09:41:27 +0100
Message-ID: <29979.1536223287@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 08:41:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 08:41:30 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do we know what type of filesystem is on the root device?

Also, is there a way to tell if AppArmor denied something?

David
