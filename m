Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 12:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9642F2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 12:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbeLOMlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 07:41:55 -0500
Received: from verein.lst.de ([213.95.11.211]:53121 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbeLOMlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 07:41:55 -0500
Received: by newverein.lst.de (Postfix, from userid 107)
        id 0F3DE68DEF; Sat, 15 Dec 2018 13:41:54 +0100 (CET)
Received: from blackhole.lan (p5B33F2D3.dip0.t-ipconnect.de [91.51.242.211])
        by newverein.lst.de (Postfix) with ESMTPSA id 3653E68D7F;
        Sat, 15 Dec 2018 13:41:50 +0100 (CET)
Date:   Sat, 15 Dec 2018 13:41:44 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        julien.thierry@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        mingo@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, takahiro.akashi@linaro.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
Message-ID: <20181215134144.6b0cc45b@blackhole.lan>
In-Reply-To: <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
References: <20181130162015.83FE767357@newverein.lst.de>
        <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
        <20181214094714.GA30043@lst.de>
        <CADGdYn69reXed-DBMTCezNyNEgKn-h0NA-D6dnoRrJx2_bE71Q@mail.gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 21:45:03 +0530
Amit Daniel Kachhap <amit.kachhap@arm.com> wrote:

> Sorry I didn't mention my environment. I am using 4.20-rc3 and it has
> all the above 8 extra patches
> mentioned by you.

So that should be fine.

> I read your change description in v3 patchset. You had mentioned there
> that graph caller
> is broken.

No, actually I thought I had fixed that for v4. Would you care to show
us an actual error message or some symptom?

	Torsten
