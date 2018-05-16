Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeEPUOx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:14:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42082 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeEPUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:14:50 -0400
Date: Wed, 16 May 2018 22:14:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: KY Srinivasan <kys@microsoft.com>
cc: "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 0/5] X86: Hyper-V: APIC enlightenments 
In-Reply-To: <MW2PR2101MB111381CFB4F6D34410DB936DA0920@MW2PR2101MB1113.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1805162212100.1586@nanos.tec.linutronix.de>
References: <20180504060653.3240-1-kys@linuxonhyperv.com> <MW2PR2101MB111381CFB4F6D34410DB936DA0920@MW2PR2101MB1113.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, KY Srinivasan wrote:

> 
> 
> > -----Original Message-----
> > From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> > Sent: Thursday, May 3, 2018 11:07 PM
> > To: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> > kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> > apw@canonical.com; jasowang@redhat.com; tglx@linutronix.de;
> > hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> > Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> > Cc: KY Srinivasan <kys@microsoft.com>
> > Subject: [PATCH V2 0/5] X86: Hyper-V: APIC enlightenments
> > 
> > From: "K. Y. Srinivasan" <kys@microsoft.com>
> > 
> > Implement APIC related enlightenments.
> > 
> > V2: Addressed comments from Thomas Gleixner <tglx@linutronix.de>
> > and Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>.
> 
> Thomas,
> 
> I think I have addressed all your comments;
> let me know if you have any additional comments on this patch set.

Looks good now. There is just the build robot fallout which needs to be
addressed AFAICT.

Thanks,

	tglx
