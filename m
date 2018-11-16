Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F268C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B9B2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B9B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbeKPVBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:01:42 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:45885 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:01:42 -0500
Received: from [78.40.148.180] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gNbh4-00030x-RG; Fri, 16 Nov 2018 10:49:46 +0000
Subject: Re: SMSC95xx driver updates (round 1)
To:     Woojung.Huh@microchip.com, netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, steve.glendinning@shawell.net,
        linux-kernel@lists.codethink.co.uk, UNGLinuxDriver@microchip.com
References: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
 <BN6PR1101MB213051FC6843BE3B1973AD93E7DC0@BN6PR1101MB2130.namprd11.prod.outlook.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <1ca739b1-1c74-ba5d-0080-a0f67af53479@codethink.co.uk>
Date:   Fri, 16 Nov 2018 10:49:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB213051FC6843BE3B1973AD93E7DC0@BN6PR1101MB2130.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/18 18:06, Woojung.Huh@microchip.com wrote:
> Hi Ben,
> 
>> -----Original Message-----
>> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On Behalf Of Ben Dooks
>> Sent: Wednesday, November 14, 2018 6:50 AM
>> To: netdev@vger.kernel.org
>> Cc: oneukum@suse.com; davem@davemloft.net; linux-usb@vger.kernel.org; linux-
>> kernel@vger.kernel.org; steve.glendinning@shawell.net; linux-kernel@lists.codethink.co.uk
>> Subject: SMSC95xx driver updates (round 1)
>>
>> This is a series of a few driver cleanups and some fixups of the code
>> for the SMSC95XX driver. There have been a few reviews, and the issues
>> have been fixed so this should be ready for merging.
>>
>> I will work on the tx-alignment and the other bits of usbnet changes
>> and produce at least two more patch series for this later.
> 
> Some reason, maintainer email of UNGLinuxDriver@microchip.com is NOT included in CC.
> Please add it in following patch series you are creating to have a chance to review by
> proper reviewers.
> 
> USB SMSC95XX ETHERNET DRIVER
> M:	Steve Glendinning <steve.glendinning@shawell.net>
> M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
> L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/net/usb/smsc95xx.*

Sorry, must have missed this when rebasing from v4.18 to v4.19.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
