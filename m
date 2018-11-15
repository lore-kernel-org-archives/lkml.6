Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14789C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8AC22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8AC22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dh-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeKOTJY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:09:24 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeKOTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:09:24 -0500
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPA (Nemesis) id
 1M5fUy-1gPxM81PRq-007B6p; Thu, 15 Nov 2018 10:02:18 +0100
Received: from sun1049.dh.corp (unknown [10.64.9.49])
        by sun05.dh.corp (Postfix) with ESMTP id 76BAE1FA3D;
        Thu, 15 Nov 2018 10:02:17 +0100 (CET)
Received: from SUN1049.dh.corp ([::1]) by sun1049.dh.corp ([::1]) with mapi id
 14.03.0415.000; Thu, 15 Nov 2018 10:02:28 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "C.Emde@osadl.org" <C.Emde@osadl.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: RE: [PATCH 0/2] Docs/EDID: Fixed and improved EDID documentation
Thread-Topic: [PATCH 0/2] Docs/EDID: Fixed and improved EDID documentation
Thread-Index: AQHUdd372aKemkOCNEebpzMkutC1AKVOFlyAgAJ8GyA=
Date:   Thu, 15 Nov 2018 09:02:27 +0000
Message-ID: <82DABEC7F9941D458E51BA62B2739EF437ADEC88@sun1049.dh.corp>
References: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
 <20181106073536.58b14759@lwn.net> <87lg5wg3s6.fsf@intel.com>
In-Reply-To: <87lg5wg3s6.fsf@intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.31.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Provags-ID: V03:K1:Qb4mgpskgW0MXUQtlP4dCUR7R2VtQL6gWGvAWCfimZ+jTlCwlkJ
 NXrSkj/lEDw/GHSGqIIeZRm/dYtMjxh7I3G1DL+Xz4e3X7ghvhznHWZHY6CfiGq31Ote71I
 r/I5s63mffBssn+L87JMi9idjdLeI/Y9STAV5CdwRfkwDt65Y5jZJIzalZhtR+YbkNmquRn
 Yzgb4mFw5t9iPyTUZqcSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jlJJxiyd3ag=:N4Hi4y620LW887tr44Nf34
 rN/JtX2Azzgjty2vrWdkJP2YCHVq9RMHYqcWDbts1MWhdXKfiU/LiqA2xqqTbe1smKo7UfFvY
 u/aTuLCH6D1rBrRXPCZpltNDuaYJhxVz3GmBpQkIlUdlHa0Ql2RjN9haiIZsIgVIGu9qNy2SK
 Mt3IlqE4c2IGgxhE3T3jJ3lpebfusaoE0pT/+t7NcBNg86K82DJzKv83iAVMmOvjBv3VHfDD7
 uip8hPeovIM0apQeGqgWRgymSsp7NX7Mbnxq39U8KmRE6CosytralFZuecg7opQ/kmCIop6F4
 b0O/KDsiShSuYCeGw0Y0JppsW6nZkuazVpUufnubPXflrFt2YjSkxQbrc+DqIdvCRM0edfr+P
 tylStTROIak83/drtrUoQo6I+Y+p5Sk8phDzsTDf4RlAnDOMw3oT6sTC1E+vhGaYFFJ9RlvuF
 6/DdDTpbwHaJL1w1heXjkOtwz3IuBDxdt/Mhbj1dwY8OzR4QV2iNMZj6ttr6tSQ6sl3zyGUnP
 urlnMyzmKFK0iqNg9f3xuvC+DfagbuzYQ6qJuEaRFiTwV6iK59P4l8qAxNboHs2flpRNxRsZq
 kQkB3XjiV6ksqvGcMEFHk9neFgDd5X5vf+p84bp/7d5tEdp2rLFT886Hj9lwjsgQDTqtKBY8j
 3sP5cTZTPoWE1Ep8/bh+4WbivkwWcXlrL5UVUOZveL+vnrimdr0zxdiXcQQu7T/tUcCwldq8r
 iUF5SyZTUglIm+Zn0lJXK955lFCQqDkC6OagelKZCSSeSTI7d8xxR2tLVPp8libSwdPMC3WdD
 /OKp2sdeSxmWsNqn+4zW6n1TwwgOpzpK2NrMy8EUb0hSKF1b1E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Jani Nikula wrote:
> On Tue, 06 Nov 2018, Jonathan Corbet <corbet@lwn.net> wrote:
>> On Mon, 5 Nov 2018 09:48:33 +0100
>> Christoph Niedermaier <cniedermaier@dh-electronics.de> wrote:
>>
>>> A problem was found when EDID data sets for displays other than the 
>>> provided samples were generated. The patch series has no effect on 
>>> the provided samples that still match the data used in 
>>> drivers/gpu/drm/drm_edid_load.c.
>>> The provided samples use small values for XOFFSET, XPULSE, YOFFSET 
>>> and YPULSE, where the error doesn't occur. This fix corrects the use 
>>> of that values in case of high values, because the most significant 
>>> bits were treated incorrectly.
>>> 
>>> The previous version made it necessary to first generate an EDID data 
>>> set without correct CRC and then to fix the CRC in a second step. 
>>> This patch series adds the CRC calculation to the makefile in such a 
>>> way that a correct EDID data set is generated in a single build step.
>>
>> This seems reasonable, I guess; I've applied both.  It seems to me, 
>> though, that this stuff is in the wrong place.  Perhaps we should go 
>> one step further and move it to tools/ ?
>
> And then the next step further would be to write a tool in a high level language to generate the data rather than assemble the binary. Such a tool would, of course, catch errors like the ones fixed by this patch.

It would be nice, but for now it works.
Speaking for me such a task has low priority,
because in my opinion this code is not often used and
it is more intended for documentation purpose.

Best regards,
Christoph
