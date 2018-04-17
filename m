Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDQBVL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 21:21:11 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:47004 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDQBVJ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 16 Apr 2018 21:21:09 -0400
Date: Tue, 17 Apr 2018 09:20:48 +0800
From: joeyli <jlee@suse.com>
To: Randy Wright <rwright@hpe.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] efi: Fix the size not consistent issue when unmapping
 memory map
Message-ID: <20180417012048.GK16023@linux-l9pv.suse>
References: <20180413062716.8040-1-jlee@suse.com>
 <20180416025734.GA26685@dhcp-128-65.nay.redhat.com>
 <20180416030904.GB26685@dhcp-128-65.nay.redhat.com>
 <20180416063738.GH16023@linux-l9pv.suse>
 <20180417003522.GA2741@rfwz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417003522.GA2741@rfwz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 06:35:22PM -0600, Randy Wright wrote:
> On Mon, Apr 16, 2018 at 02:37:38PM +0800, joeyli wrote:
> > Hi Randy,
> > ...
> > Randy, do you want to try Dave's kexec patch on your environment? Please remove
> > my patch first.  
> > 
> > Thanks a lot!
> > Joey Lee
> 
> Hi Joey, 
> 
> I tried Dave's patch to kexec-bzimage64.c on my build of the SuSE
> 4.12.14-15 kernel.   I ran the same test as I did with your patch: I
> verified the early_ioremap.c warnings occurred with a crash triggered
> from a kexec boot of the unmodified kernel. Then I applied the patch to
> kexec-bzimage64.c, rebuilt, re-ran the test to crash from the kexec'ed
> kernel, and verified the warnings are no longer seen.
>

Thanks for your help! Looks that Dave's kexec patch works to prevent the
warning message. 
 
> I'm out of time today, but I will plan to run the same  test tomorrow on
> a build of the SuSE 4.4.120-94.17 kernel, on which I had also reported
> the original bug.
>

Both kexec and efi sides will be applied patches.

Thanks a lot!
Joey Lee 
