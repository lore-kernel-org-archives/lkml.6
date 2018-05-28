Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeE1GOj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:14:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36415 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeE1GOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:14:36 -0400
Date: Mon, 28 May 2018 08:14:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/KVM: Fix incorrect SSBD bit in
 kvm_cpuid_7_0_edx_x86_features
In-Reply-To: <20180525195009.GC26007@flask>
Message-ID: <alpine.DEB.2.21.1805280811440.1585@nanos.tec.linutronix.de>
References: <1527268584-752-1-git-send-email-longman@redhat.com> <20180525195009.GC26007@flask>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1075720976-1527488068=:1585"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1075720976-1527488068=:1585
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

On Fri, 25 May 2018, Radim Krèmáø wrote:

> 2018-05-25 13:16-0400, Waiman Long:
> > As the SSBD bit in kvm_cpuid_7_0_edx_x86_features has been renamed to
> > SPEC_CTRL_SSBD in the commit 52817587e706 ("x86/cpufeatures: Disentangle
> > SSBD enumeration"). The corresponding name change needed to be made in
> > the KVM code as well.
> > 
> > Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> 
> Thomas, are you taking this one?

Konrad sent the same fix, which is already upstream 

0aa48468d009 ("KVM/VMX: Expose SSBD properly to guests")

Thanks,

	tglx
--8323329-1075720976-1527488068=:1585--
