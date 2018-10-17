Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62A5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670B0214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670B0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJQIoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:44:13 -0400
Received: from ozlabs.org ([203.11.71.1]:32965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbeJQIoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:44:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ZYWv35Y3z9s9h;
        Wed, 17 Oct 2018 11:51:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "christophe.leroy\@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus\@samba.org" <paulus@samba.org>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>
Cc:     "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/io: remove old GCC version implementation
In-Reply-To: <8eb877e31130aee531409d18e19894d64690163d.camel@infinera.com>
References: <199ae2a28f14f944ee9ae2770a3f1dd030e762bc.1539693039.git.christophe.leroy@c-s.fr> <8eb877e31130aee531409d18e19894d64690163d.camel@infinera.com>
Date:   Wed, 17 Oct 2018 11:51:07 +1100
Message-ID: <87y3axjszo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim Tjernlund <Joakim.Tjernlund@infinera.com> writes:

> On Tue, 2018-10-16 at 12:33 +0000, Christophe Leroy wrote:
>> 
>> 
>> GCC 4.6 is the minimum supported now.
>
> Ouch, from kernel 4.19 or earlier even ?

Yes.

Though to be honest we haven't been testing much with compilers older
than that for several years.

If you care about something older please let us know :)

cheers
