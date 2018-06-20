Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE80C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8632086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8632086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbeFTACV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:02:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:47948 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeFTACU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:02:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5K02C06010693;
        Tue, 19 Jun 2018 19:02:13 -0500
Message-ID: <d86fa9cdb4c160350268c70bd8fead138ce5a8e2.camel@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Jun 2018 10:02:12 +1000
In-Reply-To: <CA+55aFxRyp4G4niZ=aMk+epdSbu5MB1oJg_h4NhLkxsM+f+SLQ@mail.gmail.com>
References: <1281327087.2168.67.camel@pasglop>
         <CA+55aFxRyp4G4niZ=aMk+epdSbu5MB1oJg_h4NhLkxsM+f+SLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 07:58 +0900, Linus Torvalds wrote:
> On Wed, Jun 20, 2018 at 5:23 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
> 
> I love the alleged line removal, but there's nothing in that 'merge'
> branch. It points to an ancient powerpc commit from 2016.
> 
> And please, signed tags. I know you do them, because you used to send me them.
> 

I didn't send this. It's an ancient (8 years old) email... I have no
idea how it got resent while I was asleep...

Cheers,
Ben.

