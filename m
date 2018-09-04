Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116372073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116372073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeIEAAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:00:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbeIEAAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:00:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8305ADF3;
        Tue,  4 Sep 2018 19:33:47 +0000 (UTC)
Date:   Tue, 4 Sep 2018 21:33:47 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] HID fixes
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1809042133250.15880@cbobk.fhfr.pm>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Benjamin Tissoires wrote:

> Hi Jiri,
> 
> there is no real link between those 4 commit but the fact that I wrote
> them today ;)
> 
> 2 patches should at least be scheduled for v4.19: 1/4 and 3/4
> Both are stable fixes for mistakes I made in v4.18.
> 
> Patch 2 and 4 are just nice to have, so v4.20 should be fine.

And I've queued the patches exactly like that. Thanks,

-- 
Jiri Kosina
SUSE Labs

