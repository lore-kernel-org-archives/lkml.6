Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933502AbeEIBlO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:41:14 -0400
Received: from ozlabs.org ([203.11.71.1]:56071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933305AbeEIBlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:41:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Torsten Duwe <duwe@lst.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3] ppc64le livepatch: implement reliable stacktrace for newer consistency models
In-Reply-To: <20180509001432.5nd55ictwf5yi7sm@treble>
References: <20180305164928.GA17953@lst.de> <20180308162616.yhbymodggnfzpskx@treble> <20180309174718.2700b29e@blackhole.lan> <20180312153536.7avozx64ku4lvd3e@treble> <20180504123834.GA16581@lst.de> <20180507154208.jo4s43olrf5a3hw4@treble> <20180508103832.085378b9@blackhole.lan> <20180509001432.5nd55ictwf5yi7sm@treble>
Date: Wed, 09 May 2018 11:41:09 +1000
Message-ID: <87sh71zjuy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:

> On Tue, May 08, 2018 at 10:38:32AM +0200, Torsten Duwe wrote:
>> On Mon, 7 May 2018 10:42:08 -0500
>> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> 
>> > The subject doesn't actively describe what the patch does, maybe
>> > change it to something like:
>> > 
>> >   powerpc: Add support for HAVE_RELIABLE_STACKTRACE
>> > 
>> > or maybe
>> > 
>> >   powerpc: Add support for livepatch consistency model
>> 
>> Maybe $SUBJECT? You're absolutely right, the old subject was just a
>> leftover of my original attempt to just set the flag, before Miroslav
>> corrected me. I just kept on copying it without a second thought. Thanks
>> for noting.
>
> Generally we refer to it as "the consistency model".  So I would
> propose a minor edit:
>
>   ppc64le/livepatch: Implement reliable stack tracing for the consistency model

We use "powerpc" as the prefix.

So I've used:

  powerpc/livepatch: Implement reliable stack tracing for the consistency model


cheers
