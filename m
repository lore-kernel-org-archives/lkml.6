Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7C9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76BB24CDF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76BB24CDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeGCJzw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:55:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:39502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932517AbeGCJzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:55:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69006ADC1;
        Tue,  3 Jul 2018 09:55:49 +0000 (UTC)
Date:   Tue, 3 Jul 2018 11:55:48 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Daniel Rosenberg <drosen@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        "3.8+" <stable@vger.kernel.org>
Subject: Re: [PATCH] HID: debug: check length before copy_to_user()
In-Reply-To: <CAO-hwJLocBwuS7TGaXW88B-V8xSheATNDuvobv-Vk+hU0hei0A@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1807031155040.2273@cbobk.fhfr.pm>
References: <20180702235937.111619-1-drosen@google.com> <CAO-hwJLocBwuS7TGaXW88B-V8xSheATNDuvobv-Vk+hU0hei0A@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Benjamin Tissoires wrote:

> > If our length is greater than the size of the buffer, we
> > overflow the buffer
> >
> > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> 
> Looks good:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Indeed, thanks a lot for fixing this. Now queued, I'll push it for 4.18.

-- 
Jiri Kosina
SUSE Labs

