Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F53214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F53214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeKVDci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:32:38 -0500
Received: from verein.lst.de ([213.95.11.211]:52562 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732043AbeKVDci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:32:38 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C89CE68C19; Wed, 21 Nov 2018 17:57:23 +0100 (CET)
Date:   Wed, 21 Nov 2018 17:57:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, jaharkes@cs.cmu.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
Message-ID: <20181121165723.GA5980@lst.de>
References: <20181030202713.26203-1-semen.protsenko@linaro.org> <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com> <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 06:41:13PM +0200, Andy Shevchenko wrote:
> I'm not sure how you managed to miss people in this list (perhaps by
> default you have suppress all Cc in your Git configuration), but I
> guess we may gently ask Christoph to apply this in case Jan will not
> appear.

I don't really have a relevant tree.  You probably want to send it
to Al Viro.
