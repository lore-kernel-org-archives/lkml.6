Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCOMqJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:46:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeCOMqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:46:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Mar 2018 18:16:04 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: "Christ, Austin" <austinwc@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
In-Reply-To: <cf4b43fc-8051-77d1-c4f0-e46cb209fa49@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <2a092d8f-6d1a-27e4-01f6-49790f767ae6@codeaurora.org>
 <20180313211758.kv5voneg4akm3rqo@ninjato>
 <cf4b43fc-8051-77d1-c4f0-e46cb209fa49@codeaurora.org>
Message-ID: <14ad40fa8443f443326601695d711b77@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-14 03:42, Christ, Austin wrote:
> Sorry for the miscommunication. I reviewed the patches and tested them
> on the Centriq 2400 platform.
> 
> Perhaps the following is the most appropriate.
> 
> Acked-by: Austin Christ <austinwc@codeaurora.org>
> 

  Thanks Austin for reviewing and testing the code changes.

  It would be more helpful if you provide your 'Tested-by'
  for last 2 changes. Sricharan has already given 'Reviewed-by'
  for last 2 major changes and your 'Tested-by' will help
  in confirming that these changes are working fine in
  other platforms also.

  Thanks,
  Abhishek

> 
> On 3/13/2018 3:17 PM, Wolfram Sang wrote:
>> On Tue, Mar 13, 2018 at 03:09:00PM -0600, Christ, Austin wrote:
>>> I've tested this v2 series on Centriq 2400. Looks good to me.
>>> 
>>> Reviewed-by: Austin Christ <austinwc@codeaurora.org>
>> 
>> I am a little confused. Do you mean Tested-by or Reviewed-by?
>> 
