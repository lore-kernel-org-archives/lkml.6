Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBVUqa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:46:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBVUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:46:28 -0500
Date: Thu, 22 Feb 2018 12:46:25 -0800
From: Darren Hart <dvhart@infradead.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] platform/x86: Only activate tablet mode switch on
 2-in-1's
Message-ID: <20180222204625.GG19843@fury>
References: <1519329522-16919-1-git-send-email-mario.limonciello@dell.com>
 <01000161bf28670e-bfeaa576-853c-4760-a362-d6abdaa474f1-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000161bf28670e-bfeaa576-853c-4760-a362-d6abdaa474f1-000000@email.amazonses.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 08:15:51PM +0000, Jeremy Cline wrote:
> On Thu, Feb 22, 2018 at 01:58:42PM -0600, Mario Limonciello wrote:
> > Some laptops such as the XPS 9360 support the intel-vbtn INT33D6
> > interface but don't initialize the bit that intel-vbtn uses to
> > represent switching tablet mode.
> > 
> > By running this only on real 2-in-1's it shouldn't cause false
> > positives.
> > 
> 
> Tested-by: Jeremy Cline <jeremy@jcline.org>

Problem verified, solution tested and also verified. Queuing patch.

-- 
Darren Hart
VMware Open Source Technology Center
