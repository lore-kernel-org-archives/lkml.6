Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55722C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B29421920
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfBGNLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:11:06 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:39490 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBGNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:11:06 -0500
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id x17CiFGc011238;
        Thu, 7 Feb 2019 12:44:15 GMT
From:   Nix <nix@esperi.org.uk>
To:     Coly Li <colyli@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Andre Noll <maan@tuebingen.mpg.de>,
        linux-bcache@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk
Subject: Re: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at all?
References: <87h8dgefee.fsf@esperi.org.uk> <20190206234328.GH14116@dastard>
        <20190207002425.GX24140@tuebingen.mpg.de>
        <20190207022657.GI14116@dastard>
        <438851ef-ef77-b5f2-d46d-05762b6330b2@suse.de>
Emacs:  where editing text is like playing Paganini on a glass harmonica.
Date:   Thu, 07 Feb 2019 13:10:52 +0000
In-Reply-To: <438851ef-ef77-b5f2-d46d-05762b6330b2@suse.de> (Coly Li's message
        of "Thu, 7 Feb 2019 10:38:58 +0800")
Message-ID: <875ztveobn.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-DCC-wuwien-Metrics: loom 1290; Body=8 Fuz1=8 Fuz2=8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Feb 2019, Coly Li stated:
> On 2019/2/7 10:26 上午, Dave Chinner wrote:
>> So, yeah, that needs to be reverted if you want bcache to function
>> properly for metadata caching.
>
> Sure, I will fix this, once I make it clear to me.

I'll give it a test :)

The meaning of these flags was somewhat opaque to me, too (mostly due to
novelty: I've never really looked at anything in the block layer
before).

-- 
NULL && (void)
