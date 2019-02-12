Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C47C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8072620821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfBLNyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:54:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfBLNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:54:48 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtYWE-0004Hi-Tr; Tue, 12 Feb 2019 14:54:39 +0100
Date:   Tue, 12 Feb 2019 14:54:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
In-Reply-To: <4e4b9f97-b7f5-f353-4abe-d9e3af076d74@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902121453080.3710@nanos.tec.linutronix.de>
References: <20190212044914.15490-1-aubrey.li@linux.intel.com> <20190212044914.15490-2-aubrey.li@linux.intel.com> <alpine.DEB.2.21.1902121358050.3710@nanos.tec.linutronix.de> <61791002-0928-fa79-8cba-9625eb0418dd@linux.intel.com>
 <alpine.DEB.2.21.1902121422180.3710@nanos.tec.linutronix.de> <4e4b9f97-b7f5-f353-4abe-d9e3af076d74@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Li, Aubrey wrote:
> On 2019/2/12 21:24, Thomas Gleixner wrote:
> > And please take your time and do not shoot out half baken patch series
> > every 5 minutes.
> > 
> Sorry for the trouble, just want to solve the problem before your eyes move
> away from this thread.

You achieve exactly the opposite of what you are trying to do. If I get
repeated half baken crap, that surely does not foster my interest.

Thanks,

	tglx
