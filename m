Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B970C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E496D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E496D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeIFMvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:51:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeIFMvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BA4C8010FDF;
        Thu,  6 Sep 2018 08:17:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF5B0D93CB;
        Thu,  6 Sep 2018 08:17:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ce6ac597-751c-8881-160d-28d62a898a3e@sakamocchi.jp>
References: <ce6ac597-751c-8881-160d-28d62a898a3e@sakamocchi.jp> <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk> <153616293089.23468.13515059526628668970.stgit@warthog.procyon.org.uk>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 08/11] UAPI: sound: Fix use of u32 and co. in UAPI headers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21301.1536221853.1@warthog.procyon.org.uk>
Date:   Thu, 06 Sep 2018 09:17:33 +0100
Message-ID: <21302.1536221853@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 08:17:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 08:17:35 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:

> A similar patch was already proposed[1] and has been applied by Mark to
> his tree[2]. Your issue (3) is going to be solved soon for v4.19
> kernel.

Thanks, I've pulled the branch leading up to that commit into the base of
mine.  It seems the changes were identical:-)

David
