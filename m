Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AECCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8FF2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8FF2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJ3ARW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:17:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbeJ3ARW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:17:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2E4DAD5C;
        Mon, 29 Oct 2018 15:28:15 +0000 (UTC)
Date:   Mon, 29 Oct 2018 16:28:14 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH v2] HID: moving to group maintainership model
In-Reply-To: <CAO-hwJLVY25VXyMKWD6u22gWV3mqgu1iXT3chL3rJ8zXbVbwag@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1810291627570.23511@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm> <nycvar.YFH.7.76.1810271425060.23511@cbobk.fhfr.pm> <CAO-hwJLVY25VXyMKWD6u22gWV3mqgu1iXT3chL3rJ8zXbVbwag@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018, Benjamin Tissoires wrote:

> > From: Jiri Kosina <jkosina@suse.cz>
> > Date: Sat, 27 Oct 2018 14:16:13 +0200
> > Subject: [PATCH] HID: moving to group maintainership model
> >
> > Benjamin and myself will from now on be sharing maintainership
> > responsibilities for hid.git.
> >
> > Update maintainers to reflect that change, and also move a git
> > repository to shared space at kernel.org.
> >
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> I guess I can answer this with:
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Jiri, would this need to go through the HID tree or some other? (I guess HID).

I've just pushed it to for-4.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

