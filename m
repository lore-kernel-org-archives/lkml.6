Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935281AbeEIOy7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:54:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934331AbeEIOy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:54:57 -0400
Date: Wed, 9 May 2018 09:54:54 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'damian'" <damian.tometzki@icloud.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-ID: <20180509145454.tppr2l436o5icgwe@treble>
References: <20180505192112.GA18728@zrhn9910b>
 <36baff2c776a4c3799f40a9033fc90fc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36baff2c776a4c3799f40a9033fc90fc@AcuMS.aculab.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 02:27:48PM +0000, David Laight wrote:
> From: damian
> > Sent: 05 May 2018 20:21
> > is something special to note when kernel build with gcc 8? I receive various warnings from the
> > objtool:
> 
> Someone ought to persuade the gcc folks to try compiling the Linux kernel
> before releasing a new compiler :-)

That would have been good.  Though, I also deserve blame as Arnd warned
me about this several months ago before the spec-pocalypse diverted my
attention.

-- 
Josh
