Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934553AbeEIKbp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:31:45 -0400
Received: from verein.lst.de ([213.95.11.211]:42506 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933715AbeEIKbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:31:44 -0400
Date: Wed, 9 May 2018 12:35:13 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] ppc64le livepatch: implement reliable stacktrace
        for newer consistency models
Message-ID: <20180509103513.GA24464@lst.de>
References: <20180305164928.GA17953@lst.de> <20180308162616.yhbymodggnfzpskx@treble> <20180309174718.2700b29e@blackhole.lan> <20180312153536.7avozx64ku4lvd3e@treble> <20180504123834.GA16581@lst.de> <20180507154208.jo4s43olrf5a3hw4@treble> <20180508103832.085378b9@blackhole.lan> <20180509001432.5nd55ictwf5yi7sm@treble> <87sh71zjuy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh71zjuy.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:41:09AM +1000, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> 
> > Generally we refer to it as "the consistency model".
[...]
> 
> We use "powerpc" as the prefix.
> 
> So I've used:
> 
>   powerpc/livepatch: Implement reliable stack tracing for the consistency model

Perfect. Thanks!

	Torsten
