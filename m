Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AE8C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE27321924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbfBOQy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfBOQy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:54:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E619DC60FC;
        Fri, 15 Feb 2019 16:54:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1BE65D6A9;
        Fri, 15 Feb 2019 16:54:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LRH.2.21.1902150601280.17510@namei.org>
References: <alpine.LRH.2.21.1902150601280.17510@namei.org> <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
To:     James Morris <jmorris@namei.org>
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, ebiggers@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] keys: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27274.1550249694.1@warthog.procyon.org.uk>
Date:   Fri, 15 Feb 2019 16:54:55 +0000
Message-ID: <27275.1550249695@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 15 Feb 2019 16:54:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> For which kernel, -rc or 5.1?

-rc, preferably, but I don't think any of them are particularly urgent, so if
you'd rather wait...

David
