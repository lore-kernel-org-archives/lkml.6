Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966723AbeEJR1m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:27:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:42310 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:27:40 -0400
Subject: Re: [PATCH] selftests: kvm: update .gitignore with missing file
To: Anders Roxell <anders.roxell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20180423135725.3753-1-anders.roxell@linaro.org>
 <CADYN=9KPSYmrAA_N-J-OLvn2+B1_hU5KK24-Q1V66j3cCmkNTw@mail.gmail.com>
 <62bdea19-17e2-82e9-c2bf-214f8219f7c6@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <cb55d1fa-e5b2-5e3c-a74e-d60b3f9a2088@kernel.org>
Date: Thu, 10 May 2018 11:27:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <62bdea19-17e2-82e9-c2bf-214f8219f7c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 09:34 AM, Shuah Khan wrote:
> On 05/08/2018 02:22 AM, Anders Roxell wrote:
>> On 23 April 2018 at 15:57, Anders Roxell <anders.roxell@linaro.org> wrote:
>>> Fixes: d5edb7f8e7ab ("kvm: selftests: add vmx_tsc_adjust_test")
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>  tools/testing/selftests/kvm/.gitignore | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
>>> index a546e052d19a..63fc1ab9248f 100644
>>> --- a/tools/testing/selftests/kvm/.gitignore
>>> +++ b/tools/testing/selftests/kvm/.gitignore
>>> @@ -1,2 +1,3 @@
>>>  set_sregs_test
>>>  sync_regs_test
>>> +vmx_tsc_adjust_test
>>> --
>>> 2.17.0
>>>
>>
>> ping.
>>
> 
> I plan to get this into 4.18-rc1
> 
> thanks,
> -- Shuah
> 

Applied to linux-kselftest next for 4.18-rc1

thanks,
-- Shuah
