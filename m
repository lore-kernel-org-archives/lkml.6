Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD9DC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2331520849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2331520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLKUOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:14:33 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:55250 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeLKUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:14:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 70C51608A39E;
        Tue, 11 Dec 2018 21:14:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G7zW2dHH_V5o; Tue, 11 Dec 2018 21:14:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1AA0B608A3BA;
        Tue, 11 Dec 2018 21:14:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hD4t7JaysBga; Tue, 11 Dec 2018 21:14:29 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 56018608A39E;
        Tue, 11 Dec 2018 21:14:29 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@suse.de, bp@alien8.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size linker flag
Date:   Tue, 11 Dec 2018 21:14:28 +0100
Message-ID: <26201549.d0hG7Wm4ip@blindfold>
In-Reply-To: <CAKwvOd=OY-qWqxK9gcacKChAEAPqFWyyBbgsQK6-h0zTYTcOgg@mail.gmail.com>
References: <20181206191231.192355-1-ndesaulniers@google.com> <20181211180547.GG25994@zn.tnic> <CAKwvOd=OY-qWqxK9gcacKChAEAPqFWyyBbgsQK6-h0zTYTcOgg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Dezember 2018, 20:08:30 CET schrieb Nick Desaulniers:
> > But in this particular case, DKIM is pretty good spam protection
> > mechanism so enabling it is a good idea.
> 
> Internal Gmail developers were able to help me verify that SPF was
> setup correctly, but indeed there's no DKIM.  This article has more
> info: https://support.google.com/mail/answer/81126?hl=en.  Richard, I
> don't know if that's a lot of work on your end, but other folks using
> gmail might have the same issue repeatedly with receiving emails from
> your domain otherwise.

Running your own mailserver is already a PITA, so adding a little more
pain does not count in much more.
Thanks for talking to Gmail guys, I'll look into adding DKIM.

Thanks,
//richard


