Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F33C760555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeFFODH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:03:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752046AbeFFODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:03:05 -0400
Date: Wed, 06 Jun 2018 23:03:02 +0900 (JST)
Message-Id: <20180606.230302.980331656652452057.yamato@redhat.com>
To: tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: Re: [PATCH] x86/iommu: Fix a typo in a macro parameter
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <alpine.DEB.2.21.1806061440000.1579@nanos.tec.linutronix.de>
References: <20180606.201529.867663362891798169.yamato@redhat.com>
        <alpine.DEB.2.21.1806061409150.1579@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1806061440000.1579@nanos.tec.linutronix.de>
Organization: Red Hat Japan, Inc.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 14:41:57 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 6 Jun 2018, Thomas Gleixner wrote:
>> On Wed, 6 Jun 2018, Masatake YAMATO wrote:
>> > On Wed, 6 Jun 2018 12:37:34 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
>> > > On Wed, 6 Jun 2018, Masatake YAMATO wrote:
>> > > 
>> > > Can you please explain why 0 is the wrong value.
>> > 
>> > I don't know such constants, 0 and 1.
>> > 
>> > What I change is just the name of macro parameter as 
>> > 
>> >      s/detect/_detect/
>> 
>> OOps. Misread the patch. Sorry.
> 
> But the fix is pretty pointless. IOMMU_INIT_POST_FINISH() is completely
> unused and should just be removed.

Oh, I see. Thank you for taking your time.

Masatake YAMATO

> Thanks,
> 
> 	tglx
