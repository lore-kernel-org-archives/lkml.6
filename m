Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65240C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EF123E51
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EF123E51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeGCNcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:32:10 -0400
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]:60861 "EHLO
        mtlfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752508AbeGCNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:32:09 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 09:32:09 EDT
Received: from bell.net mtlfep01 184.150.200.30 by mtlfep01.bell.net
          with ESMTP
          id <20180703132232.VMDW10498.mtlfep01.bell.net@mtlspm02.bell.net>;
          Tue, 3 Jul 2018 09:22:32 -0400
Received: from [192.168.0.138] (really [76.69.63.211]) by mtlspm02.bell.net
          with ESMTP
          id <20180703132232.QMHW6415.mtlspm02.bell.net@[192.168.0.138]>;
          Tue, 3 Jul 2018 09:22:32 -0400
Subject: Re: Build regressions/improvements in v4.18-rc3
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>
References: <20180702140050.1660-1-geert@linux-m68k.org>
 <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com>
 <1fa6b973-33e7-53f8-75bb-92d1e8932813@gmx.de>
 <87601xgm6a.fsf@concordia.ellerman.id.au>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <74980be1-0684-09ef-9e31-cb8f0db13139@bell.net>
Date:   Tue, 3 Jul 2018 09:22:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87601xgm6a.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=IaFoYSia c=1 sm=0 tr=0 a=W8V8PKhHyJD+HXwBaZ+/FA==:17 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=mDV3o1hIAAAA:8 a=FBHGMhGWAAAA:8 a=WIMuH9iB4f1ny0LeIgcA:9 a=QEXdDO2ut3YA:10 a=ATlVsGG5QSsA:10 a=_FVE-zBwftR9WsbkzFJk:22 a=9gvnlMMaQFpL9xblJ6ne:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-02 9:09 PM, Michael Ellerman wrote:
> It's GCC 4.6.3. Are you saying that's not supported anymore?
See <https://gcc.gnu.org/> for supported releases.

Dave

-- 
John David Anglin  dave.anglin@bell.net

