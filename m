Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZrrOszfuFaA7fyq8DOuolSo3uqrEYbQVt3dZC2Ewn3K/g/ivjrXCmnHeZT8n6k4TX7WBfkR
ARC-Seal: i=1; a=rsa-sha256; t=1526414955; cv=none;
        d=google.com; s=arc-20160816;
        b=HrCr4G73R6e8tSIkh+y8rh0/csnSiH+gywU2mh8lkVa38Ew2PmonW/USxRdQ2V9fAW
         yR6cS6JCjmqiYbDf5n96yrWAw6hyssocHmgtiVOQBzhwchRjmLsMga6Wwa0OQouK0Bf6
         41dQFLuFzSfj6Sv480MSG2RzngKNPQVV5wuufn4BmZqT9EKWXk52flYlFPjaFQdjqj/j
         WjtOhg8XkQWj1gka+6givJAFiA2KONKS/KOsnIikizmJ4KMt6QaQ/zXIUK++12nEwsEo
         qIJQtA1RWyrQnrs+9Pd1Gz1tz6bMbckF6J+1ISolCSflW6Xz/sFim0FfQWUVY5tEEoLL
         URhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=OM7USWje5OStX9KmV4/iGWpX+Z1V0Dp+7mo+SX8tr2Y=;
        b=HFq4m+DPDlShW3ciQz62lR+PvYyk+FxtHo9ywJ/vlfwS8ilFdOSkNhSLbefsgX+OLg
         icw5Zv3IvVWVOJ414f9gjz8OuUf35rUsK1IVFFbRmdd65RrJCsSSN9Gn6O89vof91it/
         k/bMrY2fnJTsJlTBdkWLgaHuClaTZ4u40t9dtdAZFKOxhi0O+PYtq+StJ287BPm774yY
         XRqGjoMgF2BCQpwSYgzqmspYE06HHGne0p5KAGnc6KWcPAdfHPSneuaBtWalIp0QmOYh
         FLbQSsYI5MswMJK+0zx9mwMhWYU1GeH8UJdaVfA3pMz6zTQQDxks7Ll/l8jBO1cnlT/3
         Y5Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH 1/2] tools/testing/selftests/x86: fix warning:
 "SEGV_PKUERR|SEGV_BNDERR" redefined
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Li Zhijian
 <lizhijian@cn.fujitsu.com>, linux-kselftest@vger.kernel.org,
 tglx@linutronix.de, gregkh@linuxfoundation.org, pombredanne@nexb.com,
 ebiederm@xmission.com, luto@kernel.org, linux-kernel@vger.kernel.org,
 philip.li@intel.com, leist.fnst@cn.fujitsu.com, zhijianx.li@intel.com,
 Shuah Khan <shuah@kernel.org>
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
 <8f91739f-5d63-e6c9-7bf9-4c970237bcf8@intel.com>
 <486b5b09-d45f-5d79-cb8a-9ea3537ae048@kernel.org>
 <20180514093157.GB27428@gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <68755e04-3954-e193-8ba3-e96930075622@kernel.org>
Date: Tue, 15 May 2018 14:08:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514093157.GB27428@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734267032257?=
X-GMAIL-MSGID: =?utf-8?q?1600562088072845286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 03:31 AM, Ingo Molnar wrote:
> 
> * Shuah Khan <shuah@kernel.org> wrote:
> 
>> On 05/08/2018 10:25 AM, Dave Hansen wrote:
>>> On 05/08/2018 02:14 AM, Li Zhijian wrote:
>>>> SEGV_PKUERR and SEGV_BNDERR are defined since glibc-2.27
>>>
>>>
>>> Acked-by: Dave Hansen <dave.hansen@intel.com>
>>>
>>
>> Thanks. Queuing this up for 4.17-rc5
> 
> Please drop these patches, I have fixed them slightly differently and there are 
> dependencies with followup patches.
> 
> Tanks,
> 
> 	Ingo
> 

Dropped now.

thanks,
-- Shuah
