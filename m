Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B122177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeLTLFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:05:00 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:36610 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbeLTLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:05:00 -0500
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.7) with ESMTPA;
        Thu, 20 Dec 2018 12:04:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Dec 2018 12:04:30 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v2 0/4] serial: uartps: Driver updates
In-Reply-To: <be121f63-fe03-8b50-54e5-24865d856e56@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
 <06bcd18cb2e0e81d3051ef6305139d40@vanmierlo.com>
 <be121f63-fe03-8b50-54e5-24865d856e56@xilinx.com>
Message-ID: <923d0af3a92f4be6e064de90db0925ea@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-20 07:52, Michal Simek wrote:
> Hi,
> 
> On 19. 12. 18 19:40, Maarten Brock wrote:
>> Hello Michal,
>> 
>> On 2018-12-18 13:18, Michal Simek wrote:
>>> Hi,
>>> 
>>> I am sending 4 patches in series to fix some issues we found.
>>> Patches were sent separately but I have been asked to send them in
>>> serial that's why I am also adding cover letter to explain this v2
>>> version.
>>> 
>>> Thanks,
>>> Michal
>> 
>> I'm wondering why, when reading the linux-serial mailing list, I can
>> only see this cover letter.
>> Are you perhaps using a different To/Cc for the actual patches? And if
>> so, is that on purpose?
>> 
> 
> I have checked linux-serial mailing list and I see all of them there.
> https://www.spinics.net/lists/linux-serial/
> 
> Individual here.
> https://www.spinics.net/lists/linux-serial/msg32919.html
> https://www.spinics.net/lists/linux-serial/msg32916.html
> https://www.spinics.net/lists/linux-serial/msg32917.html
> https://www.spinics.net/lists/linux-serial/msg32918.html
> 
> Also I see linux-serial@ in CC in all emails I have sent.
> 
> Thanks,
> Michal

Thanks, I see them there too. But the odd thing is that I did not 
receive
them in my mailbox. And I had noticed this before that I was missing 
your
posts following a cover letter.

I normally do receive other peoples patches after a cover letter.

Maarten

