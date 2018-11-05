Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562A7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1941720892
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1941720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbeKFDZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:25:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50248 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387640AbeKFDZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:25:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: padovan)
        with ESMTPSA id 036D3260E1F
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        alexander.levin@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, alice.ferrazzi@gmail.com,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>, dvyukov@google.com,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        knut.omang@oracle.com
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
From:   Gustavo Padovan <gustavo.padovan@collabora.com>
Organization: Collabora Ltd
Message-ID: <70eba492-0b3d-1fe1-f17c-88964254124a@collabora.com>
Date:   Mon, 5 Nov 2018 19:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhaval,

On 9/19/18 7:13 PM, Dhaval Giani wrote:
> Hi folks,
>
> Sasha and I are pleased to announce the Testing and Fuzzing track at
> LPC [ 1 ]. We are planning to continue the discussions from last
> year's microconference [2]. Many discussions from the Automated
> Testing Summit [3] will also continue, and a final agenda will come up
> only soon after that.
>
> Suggested Topics
>
> - Syzbot/syzkaller
> - ATS
> - Distro/stable testing
> - kernelci
> - kernelci auto bisection

Having 2 kernelci talks don't make too much sense, I discussed with 
Kevin and we thing it would be a good idea to merge them together. Could 
you do that?

Thanks,

Gustavo


Gustavo Padovan
Collabora Ltd

