Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16600ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B2E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B2E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeJRFSb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeJRFSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D51AFC05D3F3;
        Wed, 17 Oct 2018 21:20:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 120E118A4D;
        Wed, 17 Oct 2018 21:20:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7b409325-9e23-aa5e-916f-cb362a6940aa@gmail.com>
References: <7b409325-9e23-aa5e-916f-cb362a6940aa@gmail.com> <f6f2553e-f64d-9c26-4290-baf43e5f533b@gmail.com> <19866.1539782101@warthog.procyon.org.uk> <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk> <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com> <20181013061141.GR32577@ZenIV.linux.org.uk> <28710.1539782412@warthog.procyon.org.uk> <15867.1539791153@warthog.procyon.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock for reconfiguration [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6468.1539811255.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 17 Oct 2018 22:20:55 +0100
Message-ID: <6469.1539811255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 17 Oct 2018 21:20:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> static  int  do_remount <https://elixir.bootlin.com/linux/v4.18/ident/do_remount>(struct  path <https://elixir.bootlin.com/linux/v4.18/ident/path>  *path <https://elixir.bootlin.com/linux/v4.18/ident/path>,  int  ms_flags,  int  sb_flags,
> 		int  mnt_flags,  void  *data)

What happened there?  You seem to have had a load of URLs substituted in.

David
