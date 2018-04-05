Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDETNZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:13:25 -0400
Received: from mout.web.de ([212.227.17.11]:57787 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeDETNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:13:23 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
Date: Thu, 5 Apr 2018 21:13:09 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5I7KUHipNsaiyYTieuHa0WP9GqMwAaf1ZePrtMnxrat84rAu3mI
 s9Ps6lCf13gQmmbHmXfccZw8fSG3mUvy0exSg1+ghojBGnJ+qf+F5U3iR1L2MqS3yey5qR7
 0I869FlB/kp7cib/GXBv/dEb673mJo88Ljbvp6tsvf72UOnNn6qIGC1vqro6yyC+xLJp6sZ
 eePJHd+I8taCpn0dq9x0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kj6Zi4UTgB4=:Vtm/+FGD1sa6K/GSi8dRNK
 LQaxs32nwienDXtJsReQnAiycFs1OIGI14pk2yqxR2F25rikCA3elEKjyGAhThFObJbkCVnWF
 gAJG5/PN3qJ769S9D4vccsdgRE81NCE89kdfiVVd9zu+uuwK/Qzs9Qno0d9p0Tp5Pir0PI1rv
 ZOs+aLcwI0BMBCAMApT0VPH6m7QQ+jTREwWIzXDTrqOxmiPWPtpWeFVVm5IHKBQCIfHV9/8fV
 oaYUfQ+23x4LBkL6FGOTuFD/mPx4QwXZZSn9rKcGbPGlEh2/keBMDFHxss+1azoxIWYGLvseN
 64EBFuxk+FJxkWpjPOneHpuyQlH3gnePRJQYGTxa4xLK++PHlyVcatY1cfBb31CN3IgxHuHa0
 kkQIlpopnjS7Jw/n1CQd8go9hPeaEYrsAFo7qBTtCRKM7D5LlX+bcaxB0ZLzI2ROEhGlkBcHv
 4v9HFGIJ+nNxAUDo29q1w77GB7qELHyTNcXmJZSiJLeJqcT/6KzR6xIVuTjpn+DDmxOenoog7
 QEtvq9iIfgbhM0ie7S4BFZZj9rP4SaO6QOPlA8P3nhjc9wKFe6l0pTl9klGIPxa7yYXpFtLqw
 x1l3SM+Dr75hdVAivYHqenOUdTzCK9bscqumM+PdWFvbraJNCS6gTDS7yQtv59dyq/dqS2XMx
 Chx8NJ1D8z6YtyJYtAKd0BXoN1UrtbSVAE1NiJTrAgU0/OTtWM9Pc4BDLGNEuFoYTCHzUXSUr
 oZeK81pASG3jPomPURB77cO85RH6p1NJw1Mp4wwwPHsUeFRPtcbzsLWgNzoNdwUkFD6LitcNz
 Nu6XZFX8qhi6dH8Mn8ozqwwnHCam5M7O7U2Zf2LvBbP7LDWDttSsIq9neDWWmPZtKErHbF2QM
 gGyzbHWAqUtwN/KWkeeaUOfkL5QF/AgBGo51tm/zDaiQY51YIzm/ahkiCGVTcWQnIhLDhL4z1
 X0zWfp776B27PA3r3tqRSKSa1ufpEgmJbXYMXl/0MielPFgileVIFQlIoJisV26Fe+IyCaoKj
 ww==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-05 20:59, Frank Rowand wrote:
> Hi Jan,
> 
> On 04/04/18 15:35, Jan Kiszka wrote:
>> Hi Frank,
>>
>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Move duplicating and unflattening of an overlay flattened devicetree
>>> (FDT) into the overlay application code.  To accomplish this,
>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>
>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>> original FDT.
>>>
>>> The unflattened devicetree now belongs to devicetree code, which is
>>> thus responsible for freeing the unflattened devicetree.
>>>
>>> These ownership changes prevent early freeing of the duplicated FDT
>>> or the unflattened devicetree, which could result in use after free
>>> errors.
>>>
>>> of_overlay_fdt_apply() is a private function for the anticipated
>>> overlay loader.
>>
>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>> device during hypervisor activation with Linux. The DT overlay is
>> created from a a template but modified prior to application to account
>> for runtime-specific parameters. See [1] for the current implementation.
>>
>> I'm now wondering how to model that scenario best with the new API.
>> Given that the loader lost ownership of the unflattened tree but the
>> modification API exist only for the that DT state, I'm not yet seeing a
>> clear solution. Should we apply the template in disabled form (status =
>> "disabled"), modify it, and then activate it while it is already applied?
> 
> Thank you for the pointer to the driver - that makes it much easier to
> understand the use case and consider solutions.
> 
> If you can make the changes directly on the FDT instead of on the
> expanded devicetree, then you could move to the new API.

Are there some examples/references on how to edit FDTs in-place in the
kernel? I'd like to avoid writing the n-th FDT parser/generator.

> 
> Looking at the driver, I see one potential issue with that approach.
> The property "interrupt-map" is added directly to the changeset
> instead of being an existing property in the overlay.  Is it possible
> to have this property in the overlay when needed?

Well, the size of that property has a runtime dependency on the gic's
#address-cells. If that is easy to account for depends a bit on the
available FDT manipulation services. Or it would take multiple templates
to handle the different cases (0, 1, or 2 IIRC).

> 
> I'll also reply to other comments in this thread.

TIA!

Jan
