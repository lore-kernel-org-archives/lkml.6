Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeECMNJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:13:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:48675 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECMNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:13:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="225491764"
Date: Thu, 3 May 2018 15:13:01 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function to
 get capability of Intel PT
Message-ID: <20180503121301.nlbm4cotbv26tc7l@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-6-git-send-email-luwei.kang@intel.com>
 <20180503105032.h73n5lcrwkdbahgm@um.fi.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DDCE@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167F6DDCE@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 11:04:52AM +0000, Kang, Luwei wrote:
> > > New function __pt_cap_get() will be invoked in KVM to check if a
> > > specific capability is availiable in KVM guest.
> > > Another function pt_cap_get() can only check the hardware capabilities
> > > but this may different with KVM guest because some features may not be
> > > exposed to guest.
> > 
> > Do we really need both in KVM?
> 
> Yes, KVM need get host capability to estimate if can expose this feature
> to guest

Can you elaborate on this, what information do we need besides
MSR_IA32_VMX_MISC[14]?

Thanks,
--
Alex
