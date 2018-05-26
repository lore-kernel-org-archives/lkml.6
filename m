Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031797AbeEZOYH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 10:24:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753924AbeEZOYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 10:24:06 -0400
Date: Sat, 26 May 2018 16:24:01 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Joerg Roedel <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: X86: prevent integer overflows in
 KVM_MEMORY_ENCRYPT_REG_REGION
Message-ID: <20180526142400.GD23390@flask>
References: <20180519060135.GA4991@mwanda>
 <f8e3af2e-08d2-bcb2-be09-c93f8b6d6bd6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e3af2e-08d2-bcb2-be09-c93f8b6d6bd6@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-21 10:52-0500, Brijesh Singh:
> On 05/19/2018 01:01 AM, Dan Carpenter wrote:
> > This is a fix from reviewing the code, but it looks like it might be
> > able to lead to an Oops.  It affects 32bit systems.
> > 
> 
> Please note that SEV is not available on 32bit systems.

Added this note and queued, thanks.
