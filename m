Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeEBPnW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:43:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751451AbeEBPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:43:20 -0400
Date: Wed, 2 May 2018 10:43:19 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for May 2 (objtool bug!)
Message-ID: <20180502154319.cbi47tw2fmhxlnr4@treble>
References: <20180502165939.2375cf6a@canb.auug.org.au>
 <fb41f3ee-705e-4886-3f78-c7f88db5276d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb41f3ee-705e-4886-3f78-c7f88db5276d@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 08:37:53AM -0700, Randy Dunlap wrote:
> On 05/01/2018 11:59 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20180501:
> > 
> 
> on x86_64 randconfig:
> 
>   CC      fs/cifs/smbencrypt.o
> drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
> drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)

Can you share the object file (or at least the .config and GCC version)?

-- 
Josh
