Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933777AbeEWRHQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:07:16 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:39176 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932649AbeEWRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:07:14 -0400
Date: Wed, 23 May 2018 19:07:07 +0200
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christian =?utf-8?Q?Kr=C3=BCger?= <C.Krueger.B@web.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Suggestion: =?utf-8?B?4oCec3BlY3RyZV92?=
 =?utf-8?B?Mj1vZmbigJwgYW5kIOKAnm5vcHRp?= =?utf-8?B?4oCc?= per default in
 "Intel Atom N270" case?
Message-ID: <20180523170706.GA21118@probook>
References: <72a7122d-0020-f307-a76d-bb80a2c19842@web.de>
 <20180523105302.GE15312@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523105302.GE15312@amd>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018 Mai 23, Pavel Machek wrote:
> On Sat 2018-05-19 21:53:02, Christian Krüger wrote:
> > Hi,
> > 
> > Since the old "in-order-execution" Intel CPUs like the Intel Atom N270
> > (known for being installed in many Netbooks and Nettops) are not sensitive
> > for "Meltdown" & "Spectre" , wouldn't it be a good idea to exclude these
> > anyway "weak" CPUs from the costly patches by default?
> > 
> > Browsing the web, I can "feel the difference" if the matching kernel options
> > are applied on such a device.
> 
> Can you also measure the difference? Placebo effect is hard to avoid.
> 
> But yes, we do not need to do workarounds on non-buggy machines...
> 
> 								Pavel

On my Atom N270 there doesn't seem to be any workaround active with
kernel 4.14.42:

localhost ~ # cat /sys/devices/system/cpu/vulnerabilities/*
Not affected
Not affected
Not affected

Christian, did you verified the mitigations are active on your system?
What kernels are affected? 

-- 
Regards,
  Johannes
