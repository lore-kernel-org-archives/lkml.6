Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeB0Jna (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:43:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbeB0Jn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:43:26 -0500
Date: Tue, 27 Feb 2018 10:43:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v4] KVM: X86: Allow userspace to define the microcode
 version
Message-ID: <20180227094303.GA30022@pd.tnic>
References: <1519698910-4272-1-git-send-email-wanpengli@tencent.com>
 <b6051971-04a5-09e7-d11f-3689369292fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6051971-04a5-09e7-d11f-3689369292fe@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:38:12AM +0100, Paolo Bonzini wrote:
> On 27/02/2018 03:35, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> > 
> > Linux (among the others) has checks to make sure that certain features 
> > aren't enabled on a certain family/model/stepping if the microcode version 
> > isn't greater than or equal to a known good version.
> > 
> > By exposing the real microcode version, we're preventing buggy guests that
> > don't check that they are running virtualized (i.e., they should trust the
> > hypervisor) from disabling features that are effectively not buggy.
> > 
> > Suggested-by: Filippo Sironi <sironi@amazon.de>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Liran Alon <liran.alon@oracle.com>
> > Cc: Nadav Amit <nadav.amit@gmail.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> > v3 -> v4:
> >  * add the shifts back
> 
> Please wait for a review instead of pushing new versions continuously.

... and pls CC me on your submissions.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
