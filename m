Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeEGTlm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:41:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:41289 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeEGTlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:41:40 -0400
Subject: Re: [PATCH 14/24] selftests: kvm: return Kselftest Skip code for
 skipped tests
To: Paolo Bonzini <pbonzini@redhat.com>, hofsass@google.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-14-shuah@kernel.org>
 <08ca6038-00a0-1526-493a-36e6732b5934@redhat.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <004c6cf7-a79d-ab00-ee68-f8c5bc7f5988@kernel.org>
Date: Mon, 7 May 2018 13:41:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <08ca6038-00a0-1526-493a-36e6732b5934@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 05:46 AM, Paolo Bonzini wrote:
> On 05/05/2018 03:13, Shuah Khan (Samsung OSG) wrote:
>> When kvm test is skipped because of unmet dependencies and/or unsupported
>> configuration, it exits with error which is treated as a fail by the
>> Kselftest framework. This leads to false negative result even when the test
>> could not be run.
>>
>> Change it to return kselftest skip code when a test gets skipped to clearly
>> report that the test could not be run.
>>
>> Change it to use ksft_exit_skip() when the test is skipped. In addition,
>> refine test_assert() message to include strerror() string and add explicit
>> check for root user to clearly identofy non-root user skip case.
> 
> Root should not be needed.

Will remove the root check and send v2.

> 
> Otherwise
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 

thanks,
-- Shuah
