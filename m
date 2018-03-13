Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeCMRsm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:48:42 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:51308 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932257AbeCMRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:48:39 -0400
Subject: Re: [PATCH v2 0/1] Open questions
To: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <e0c8c001-f66b-2e8e-d9ec-89a0db9c5853@theobroma-systems.com>
 <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <eb5c728a-e6c2-c610-47ca-a5b3f636a2fc@theobroma-systems.com>
Date: Tue, 13 Mar 2018 18:48:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.18 18:42, Dr. Philipp Tomsich wrote:
> 
>> On 13 Mar 2018, at 18:40, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com> wrote:
>>
>>>> +    /* get the urb context */
>>>> +    if (WARN_ON(!context))
>>>> +        return;
>>>
>>> Can this happen?
>>
>> Not unless there is a bug in the code. But we want to get a message
>> before dereferencing a pointer.
> 
> Why not use BUG_ON(!context)?

I believe BUG_ON kills the kernel - the intention was to get loud 
message, but we'd rather not crash the user's machine.

Best regards,
Jakob
