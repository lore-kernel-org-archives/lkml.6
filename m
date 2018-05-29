Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeE2Kw5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:52:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55342 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932847AbeE2Kw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:52:56 -0400
Date: Tue, 29 May 2018 11:52:45 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM; fix cpu_v7_bugs_init reference
Message-ID: <20180529105245.GI17671@n2100.armlinux.org.uk>
References: <20180529102301.1145470-1-arnd@arndb.de>
 <20180529102502.GH17671@n2100.armlinux.org.uk>
 <CAK8P3a2TSQAdT94KMLiQF0ZvxEM_m+nVfgcY516EDoK4mQuTvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2TSQAdT94KMLiQF0ZvxEM_m+nVfgcY516EDoK4mQuTvw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:46:00PM +0200, Arnd Bergmann wrote:
> On Tue, May 29, 2018 at 12:25 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Please revalidate against the latest patches, this area has changed.
> 
> Ok. I assume they will be in tomorrow's linux-next kernel?
> I'll just wait for that then. Unfortunately there was no linux-next
> release yesterday, so I'm still testing on last Friday's code.

The patches are already pushed out in my for-next branch as of about
half an hour ago.  If that results in them appearing in linux-next
during the next 24 hours, then yes.  Look for this commit:

0fb1e7b0a396 ("ARM: KVM: report support for SMCCC_ARCH_WORKAROUND_1")

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
