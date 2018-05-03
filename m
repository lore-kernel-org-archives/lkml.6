Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeECKiD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:38:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeECKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:38:02 -0400
Date: Thu, 3 May 2018 12:37:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kang, Luwei" <luwei.kang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v7 00/13] Intel Processor Trace virtualization enabling
Message-ID: <20180503103750.GY12217@hirez.programming.kicks-ass.net>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DD2C@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167F6DD2C@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 10:23:12AM +0000, Kang, Luwei wrote:
> Send this patch set twice because path 2 send fail in the first time.

Then just resend patch 2; also I have two copies of patch 2, so clearly
it _did_ send.
