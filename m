Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA25FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BB420866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BB420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIKRZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:25:46 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:55622 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKRZp (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 11 Sep 2018 13:25:45 -0400
Received: from linux-9avr.suse ([111.63.3.191])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 11 Sep 2018 14:26:34 +0200
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     Takashi Iwai <tiwai@suse.de>, Borislav Petkov <bp@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <20180911093324.GB10436@kroah.com>
 <2580518.z31CQjiopR@aspire.rjw.lan> <20180911110111.GF11418@zn.tnic>
 <s5hva7cz1ry.wl-tiwai@suse.de>
From:   James Wang <jnwang@suse.com>
Openpgp: preference=signencrypt
Organization: QA-SLE
Message-ID: <54f8f0de-be7e-f2af-7594-47ad28b0ec34@suse.com>
Date:   Tue, 11 Sep 2018 20:26:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hva7cz1ry.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2018 07:55 PM, Takashi Iwai wrote:
> On Tue, 11 Sep 2018 13:01:11 +0200,
> Borislav Petkov wrote:
>> On Tue, Sep 11, 2018 at 12:51:32PM +0200, Rafael J. Wysocki wrote:
>>> that may help in principle, so any chance to try them on the affected
>>> systems?
>> Right, and I don't recall James trying the upstream kernel on his box.
> It was tested on 4.18.5, but not with 4.19-rc, AFAIK.
>
>> James?
> Yep, James, please test the kernel in OBS Kernel:HEAD (or IBS
> Devel:Kernel:master) repo for testing the latest 4.19-rc3.
No problem.
> I'm building a test kernel in IBS home:tiwai:test:shutdown-fix repo
> containing the three patches Rafael suggested.  If the kernel above
> still shows the problem, try my test kernel to see whether it changes
> anything.
No problem.


But I afraid I have to offline in next 16 hours, I'm on the way to
Prague office.
sorry for the delay. I

James
>
> thanks,
>
> Takashi

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

