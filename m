Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE31218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548431612;
	bh=n55Td2HXnlX6yLj0Ib+n0LrPXQUo8XDGj7tWecaxkHo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=fLQFizd3037XviY3PEuVzHErHolj5h29fxM3jSi06xhLSrlUHhSffvteGFfklb0o7
	 hgcGly/Ar9CEwQKnbQ3P719WCn2Db9yzGT540uO+pcOqLv97ib1UG/+DW9TQ23wRaA
	 86FXIoeRmxEGIVSMufSXRtwumFKuXiH9YB465yJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAYPxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:53:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:55756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfAYPxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:53:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29A65B003;
        Fri, 25 Jan 2019 15:53:29 +0000 (UTC)
Date:   Fri, 25 Jan 2019 16:53:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: elan: Make array buf static, shrinks object size
In-Reply-To: <11666348-f50a-719f-89d6-d90b0a1ea8f7@canonical.com>
Message-ID: <nycvar.YFH.7.76.1901251653080.6626@cbobk.fhfr.pm>
References: <20180926084150.17514-1-colin.king@canonical.com> <11666348-f50a-719f-89d6-d90b0a1ea8f7@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Colin Ian King wrote:

> ping?

I don't think I've ever seen the original patch in my inbox. Could you 
please just resend it?

-- 
Jiri Kosina
SUSE Labs

