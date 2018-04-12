Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeDLFIi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 01:08:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:49424 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeDLFIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 01:08:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,439,1517904000";
   d="scan'208";a="190860259"
Message-ID: <1523509711.16235.25.camel@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
From: Zhang Rui <rui.zhang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Li, Philip" <philip.li@intel.com>
Date: Thu, 12 Apr 2018 13:08:31 +0800
In-Reply-To: <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
References: <1523436077.16235.5.camel@intel.com>
         <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

On 三, 2018-04-11 at 17:01 -0700, Linus Torvalds wrote:
> On Wed, Apr 11, 2018 at 1:41 AM, Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > Please pull from
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> > next
> Pulled, and then immediately unpulled again.
> 
> The code causes new compiler warnings, and the warnings are valid.
> 
> If people don't care enough about their code to even check the
> warnings, I'm not going to waste one second pulling the resulting
> garbage. It's that simple.
> 

I'm really sorry for this.
could you please illustrate me what the kconfig & warning is?
I didn't
get such warnings from 0-day.

thanks,
rui
