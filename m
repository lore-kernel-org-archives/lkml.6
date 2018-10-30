Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC226C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8002220664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8002220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeJaIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:10:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:48082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727739AbeJaIKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F65DAF8A;
        Tue, 30 Oct 2018 23:15:14 +0000 (UTC)
Date:   Tue, 30 Oct 2018 16:15:06 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Waiman Long <longman@redhat.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181030231506.fy3oix75rifimevv@linux-r8p5>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <0afed890-7c5a-93ee-cdb9-e30775bd9cf1@redhat.com>
 <20181029200050.iejuxckzbm742dmw@linux-r8p5>
 <3c5ba85b-5114-c751-0114-ac2cb64c02ea@redhat.com>
 <20181029203818.pot26ewxbncfrnua@linux-r8p5>
 <b40690db-273f-ff67-01bf-de0111deb499@redhat.com>
 <20181029212314.nwruqg6au23ebqlu@shells.gnugeneration.com>
 <20181030185756.w3f2trelb7nikgmk@linux-r8p5>
 <20181030224012.mgatj7ddhj3sefkv@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181030224012.mgatj7ddhj3sefkv@shells.gnugeneration.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018, Vito Caputo wrote:

>If you create /proc/stat2 to omit interrupts, do we then create
>/proc/stat3 to omit CPUs when just interrupts are of interest to the
>application running on a 256-cpu machine?

Be real, this is a bogus argument. As mentioned, stat2 is named as such
because it's a replacement for a better common case, not some random increment.

Thanks,
Davidlohr
