Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZoPPLZIw0wLNzwAcmJN+dOYg/B15nATkHthWOJB1ft+4klIx0Bakj1/KzJ1a2iW49ZXcwBy
ARC-Seal: i=1; a=rsa-sha256; t=1525800965; cv=none;
        d=google.com; s=arc-20160816;
        b=lFUy2+S3kLjx5aa6+Ad2ZMqaOuc+qZ2tDRjLHkGdYMHWXT+LA8D2I2zZbLQRuWnp1+
         GuTJ62k48qfE9Pi6tFvqej+TKfPfAvTgwGTRER+YULGYlOaXgL6wfWZfcYNkP4b1V7h2
         SkNBzyP/X4B4j6eGqIiwVOmE2j7uLvD1njnc1Jjbq4hysoDd44pW12nRK4an1Gjkq1B7
         hagUkwKC4PSnIjg2xlFQw6C6W9DvmulAs1X7kN+eFiXJYqjruvAo3pleVtz97y0I1DA4
         FZWN3Aq12Qqr40ZCuqx0uu/EzSbt09sLTlHvPdIqrnVqrI/zntkp5N4qHTCYZNuhJ8l2
         Kmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=rEbcB5h10asSZxlMmoHw7VW/Fo0+GwDvJ2h1qTViE60=;
        b=Na/Ah4yca44N6+rHnw+y+mBUpIjp1xgBQ0TJHPvwwv/Xkdq6LBJ8G5zTk0baOnPfAU
         eR2d4n1arO377BRtsniYYK5CYAkPZe0LfuAh9I/IUcE2xce/0ztHatbSCzCNGlHbvFh+
         +UtLid5F5OyIU3/u48qqpomAfGVgwziOg293of7adXH3/vGdQ7y6ds2jeRB4q062Pvx7
         KFcgAmj3gWyMoObJ+xqd/YzfYGpAFHH8fx9lMQzUjDlQKQ38BQMDkrNbaUbyt5OpDcmU
         d9KpUZMZ01Z5MjKORvbS/3iuIAmK9dgTDRSMN+CsWZa+B6ofct+JgQlyfmqtU5slTjAt
         +wKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH 1/2] tools/testing/selftests/x86: fix warning:
 "SEGV_PKUERR|SEGV_BNDERR" redefined
To: Dave Hansen <dave.hansen@intel.com>, Li Zhijian
 <lizhijian@cn.fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org,
 pombredanne@nexb.com, ebiederm@xmission.com, luto@kernel.org,
 linux-kernel@vger.kernel.org, philip.li@intel.com,
 leist.fnst@cn.fujitsu.com, zhijianx.li@intel.com,
 Shuah Khan <shuah@kernel.org>
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
 <8f91739f-5d63-e6c9-7bf9-4c970237bcf8@intel.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <486b5b09-d45f-5d79-cb8a-9ea3537ae048@kernel.org>
Date: Tue, 8 May 2018 11:35:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8f91739f-5d63-e6c9-7bf9-4c970237bcf8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734267032257?=
X-GMAIL-MSGID: =?utf-8?q?1599918272341442572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 10:25 AM, Dave Hansen wrote:
> On 05/08/2018 02:14 AM, Li Zhijian wrote:
>> SEGV_PKUERR and SEGV_BNDERR are defined since glibc-2.27
> 
> 
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> 

Thanks. Queuing this up for 4.17-rc5

-- Shuah
