Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeECLsS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:48:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:53829 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeECLsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:48:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="196421558"
Message-ID: <1525348093.21176.644.camel@linux.intel.com>
Subject: Re: [PATCH v1 5/6] x86/boot: Allow longer parameter list for
 earlyprintk
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 03 May 2018 14:48:13 +0300
In-Reply-To: <20180116155133.d7dknmm6vodpsqfb@gmail.com>
References: <20180114143254.15429-1-andriy.shevchenko@linux.intel.com>
         <20180114143254.15429-5-andriy.shevchenko@linux.intel.com>
         <20180116031123.35emo6eiqicbx67q@gmail.com>
         <1516100227.7000.1004.camel@linux.intel.com>
         <20180116155133.d7dknmm6vodpsqfb@gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-16 at 16:51 +0100, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, 2018-01-16 at 04:11 +0100, Ingo Molnar wrote:
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > Allow longer parameter list for earlyprintk to support new
> > > > coming
> > > > parameters.
> > > > 
> > > > No functional change intended.
> > > BTW., what happens if the parsed string is longer than this
> > > buffer?
> > 
> > It will be cut up to 63 characters IIUC.
> 
> Ok, that's fine!
> 
> Could you please add a comment that explains the limit and the
> (benign) effects if 
> we go past it?

Will do.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
