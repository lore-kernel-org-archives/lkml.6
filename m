Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDGQo7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 12:44:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeDGQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 12:44:57 -0400
Date: Sat, 7 Apr 2018 09:44:48 -0700
From: Darren Hart <dvhart@infradead.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, pali.rohar@gmail.com, andy@infradead.org,
        mario.limonciello@dell.com, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 1/3] dell-led: Change dell-led.h to dell-common.h
Message-ID: <20180407164448.GC11256@fury>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308091023.9061-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 05:10:21PM +0800, Kai-Heng Feng wrote:
> This header will be used for more than just led. Change it to a more
> generic name.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2: Mario suggested to squash the HDA part into the same series.

Apologies for the silence on my end. I've reviewed all the comments, and
my understanding is we are awaiting a v3 from Kai-Heng. Is that correct?

Mario and Pali, thank you for working through the heuristics of platform
identification. I appreciate taking the time to look at the big picture,
or the scale impacts ("what if everyone did this?") - that leads to
better solutions. Of course, this is the platform driver subsystem, and
part of why we exist is to cover the quirks of today's systems, so we
can't spend too much time on what-ifs. I think your conclusions were
reasonable.

So I'm waiting for v3 from Kai-Heng - unless I've misunderstood the
conclusion of this thread.
-- 
Darren Hart
VMware Open Source Technology Center
