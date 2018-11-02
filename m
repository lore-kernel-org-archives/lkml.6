Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4FBC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AEF2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AEF2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeKCDXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:23:54 -0400
Received: from namei.org ([65.99.196.166]:50608 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbeKCDXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:23:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wA2IFlFN032321;
        Fri, 2 Nov 2018 18:15:48 GMT
Date:   Sat, 3 Nov 2018 05:15:47 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] security: keys updates for v4.20
In-Reply-To: <CAHk-=wgiWxgsvmSs=BewWpfLB=vjCJ4U3yzaKzDsZVFA0L3Xtw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1811030513480.31297@namei.org>
References: <alpine.LRH.2.21.1810262033270.5228@namei.org> <CAHk-=wgiWxgsvmSs=BewWpfLB=vjCJ4U3yzaKzDsZVFA0L3Xtw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018, Linus Torvalds wrote:

> On Fri, Oct 26, 2018 at 2:36 AM James Morris <jmorris@namei.org> wrote:
> >
> > From David: "Provide five new operations in the key_type struct that can
> > be used to provide access to asymmetric key operations.  These will be
> > implemented for the asymmetric key type in a later patch and may refer to
> > a key retained in RAM by the kernel or a key retained in crypto hardware.
> 
> Pulled.
> 
> However. I really would have expected some of the TPM people to have
> acked these, or at least looked at them. There was no sign of that in
> any of the tpm commits that I could see..
> 
> Hmm?

Good poin.  I'll ensure the linux-integrity list (now cc'd) is always 
included when asking for review of code which touches TPM.

-- 
James Morris
<jmorris@namei.org>

