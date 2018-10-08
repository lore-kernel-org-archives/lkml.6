Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87517C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323442077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323442077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJHMrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:47:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbeJHMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:47:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87134ACE7;
        Mon,  8 Oct 2018 05:37:15 +0000 (UTC)
Date:   Mon, 8 Oct 2018 07:37:14 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted
 memory with SME enabled
Message-ID: <20181008053714.GA6490@zn.tnic>
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
 <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
 <21eab36e-d113-cf88-e497-7dd620981544@redhat.com>
 <20181007084742.GA30797@zn.tnic>
 <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:30:56AM +0800, lijiang wrote:
> Yes. As previously mentioned, the correct patch is this one:

No, that chunk is not needed and I removed it. But I'd leave it as
an exercise to you to figure out why... or to prove me wrong with a
.config.

:-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
