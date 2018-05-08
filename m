Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932977AbeEHPeD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:34:03 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50210 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbeEHPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:34:01 -0400
Subject: Re: [PATCH] selftests: kvm: add .gitignore for generated files
To: Anders Roxell <anders.roxell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180410134822.23990-1-anders.roxell@linaro.org>
 <CADYN=9L-CBLjG=mtOOfzBC4EZt02idZKgnrj5bSvsfPVSFZpsg@mail.gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <4743ad90-6502-bf39-95bb-89759978784b@kernel.org>
Date: Tue, 8 May 2018 09:33:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9L-CBLjG=mtOOfzBC4EZt02idZKgnrj5bSvsfPVSFZpsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 02:21 AM, Anders Roxell wrote:
> On 10 April 2018 at 15:48, Anders Roxell <anders.roxell@linaro.org> wrote:
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>  tools/testing/selftests/kvm/.gitignore | 2 ++
>>  1 file changed, 2 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/.gitignore
>>
>> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
>> new file mode 100644
>> index 000000000000..a546e052d19a
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/.gitignore
>> @@ -0,0 +1,2 @@
>> +set_sregs_test
>> +sync_regs_test
>> --
>> 2.16.3
>>
> 
> ping.
> 

I plan to get this to inot 4.18-rc1.

thabks,
-- Shuah
