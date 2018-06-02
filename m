Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbeFBNm7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 09:42:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeFBNm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 09:42:58 -0400
Date: Sat, 2 Jun 2018 15:42:53 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make elf2ecoff work on 64bit host machines
Message-Id: <20180602154253.5a65264ec4d11a8c8a16ef1a@suse.de>
In-Reply-To: <20180601000311.lgwempsux7hnz7pn@pburton-laptop>
References: <20180528112625.25509-1-tbogendoerfer@suse.de>
        <20180601000311.lgwempsux7hnz7pn@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 17:03:11 -0700
Paul Burton <paul.burton@mips.com> wrote:


> Perhaps we should #include <stdint.h> before making use of the types it
> provides?

good point, will send a new version.

> > @@ -518,7 +518,7 @@ int main(int argc, char *argv[])
> >  
> >  		for (i = 0; i < nosecs; i++) {
> >  			printf
> > -			    ("Section %d: %s phys %lx  size %lx	 file offset %lx\n",
> > +			    ("Section %d: %s phys %x  size %x	 file offset %x\n",
> 
> Maybe #include <inttypes.h>, then use PRIx32 & co here & below?

I'll have look.

Thomas.
