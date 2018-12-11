Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2755DC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20B22084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20B22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeLKXkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:40:37 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:44314 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:40:37 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992828AbeLKXkfQ0bYt (ORCPT
        <rfc822;linux-api@vger.kernel.org> + 1 other);
        Wed, 12 Dec 2018 00:40:35 +0100
Date:   Tue, 11 Dec 2018 23:40:35 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Thorsten Glaser <tg@mirbsd.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        fweimer@redhat.com, vapier@gentoo.org, hjl.tools@gmail.com,
        dalias@libc.org, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
In-Reply-To: <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
Message-ID: <alpine.LFD.2.21.1812112337270.11202@eddie.linux-mips.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com> <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com> <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Thorsten Glaser wrote:

> Furthermore, x32 was the first of the many *64ilp32
> architectures; I know I’ve seen amd64ilp32 and at least
> one other I don’t recall.

 Maybe you mean n32 MIPS, complete kernel+userland support for which has 
been available in Linux from 2001?

  Maciej
