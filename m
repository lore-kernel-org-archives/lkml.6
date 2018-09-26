Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AABC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6937D21528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6937D21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeIZW1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeIZW1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:27:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E13853082B24;
        Wed, 26 Sep 2018 16:13:23 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-211.bos.redhat.com [10.18.17.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB6D86B65A;
        Wed, 26 Sep 2018 16:13:23 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 59188C0A4F; Wed, 26 Sep 2018 12:13:23 -0400 (EDT)
Date:   Wed, 26 Sep 2018 12:13:23 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Justin Ernst <justin.ernst@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926161323.2v4epi622yrknu53@redhat.com>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925143449.284634-1-justin.ernst@hpe.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Sep 2018 16:13:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:34:49AM -0500, Justin Ernst wrote:
> We observe an oops in the skx_edac module during boot.

That's happening also on sb_edac too and the oops comes from memory corruption
after trying to load the module several times during boot.

-- 
Aristeu

