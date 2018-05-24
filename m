Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033814AbeEXQl0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:41:26 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:59194 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030912AbeEXQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:41:22 -0400
Subject: Re: [PATCH] selftests: intel_pstate: Fixes for the testing script for
 Intel P-State driver
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, gregkh@linuxfoundation.org,
        daniel.diaz@linaro.org, thomas@m3y3r.de, pombredanne@nexb.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Shuah Khan <shuah@kernel.org>
References: <20180522170505.5846-1-ahiliation@yahoo.co.in>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <620f060d-afab-e79c-43a6-3024d728157a@kernel.org>
Date: Thu, 24 May 2018 10:41:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522170505.5846-1-ahiliation@yahoo.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrin,

On 05/22/2018 11:05 AM, Jeffrin Jose T wrote:
> fix for notification of permission requirement to run test.
> fix for exit status value for test skipped.
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

The commit log doesn't match the commit summary. Please rephrase both the
commit summary and log to indicate why this fix is necessary.

Odd. I don't see your patch posted on the linux-kselftest patchwork and not
even on lkml archive. 

You signed off doesn't match your from. Are you using git send-email to send
patches?

thanks,
-- Shuah
