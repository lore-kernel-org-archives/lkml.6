Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC7C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9365C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9365C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJIWxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJIWxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:53:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB8E8308424D;
        Tue,  9 Oct 2018 15:36:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8B2C79595;
        Tue,  9 Oct 2018 15:36:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAPcyv4gmMwRAG=VxWNyeacxdsPCsaT+BtR+27+bHT=6heAZ3sQ@mail.gmail.com>
References: <CAPcyv4gmMwRAG=VxWNyeacxdsPCsaT+BtR+27+bHT=6heAZ3sQ@mail.gmail.com> <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk> <153622557095.14298.10281337300003012767.stgit@warthog.procyon.org.uk>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dhowells@redhat.com, Linux API <linux-api@vger.kernel.org>,
        linux-kbuild@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] UAPI: ndctl: Remove use of PAGE_SIZE [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17646.1539099374.1@warthog.procyon.org.uk>
Date:   Tue, 09 Oct 2018 16:36:14 +0100
Message-ID: <17647.1539099374@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 09 Oct 2018 15:36:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> wrote:

> Let me know if you want me to pick this up for 4.20.

If you could pick this and also 09?

Thanks,
David
