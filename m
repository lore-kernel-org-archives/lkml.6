Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id geJDAQoaGluXHgAAmS7hNA
	; Fri, 08 Jun 2018 05:54:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E7F04607A4; Fri,  8 Jun 2018 05:54:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4704560590;
	Fri,  8 Jun 2018 05:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4704560590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeFHFyP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:54:15 -0400
Received: from verein.lst.de ([213.95.11.211]:46407 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeFHFyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:54:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 21D9E68B97; Fri,  8 Jun 2018 08:01:44 +0200 (CEST)
Date: Fri, 8 Jun 2018 08:01:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Gabriel C <nix.or.die@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics
        performance regression in 4.15 and later )
Message-ID: <20180608060144.GA24107@lst.de>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com> <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com> <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net> <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com> <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com> <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com> <CAEJqkghgkDeZheZsFC3rJ3W5Z-5DYdqA0U+zas0voDp7kSdORg@mail.gmail.com> <f3ae499f-c78f-4d65-ddfe-b74468b0fd81@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3ae499f-c78f-4d65-ddfe-b74468b0fd81@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:20:37PM +0200, Christian König wrote:
> Hi Christopher,

I don't see a Christopher on the Cc list..
