Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AIpwx48O7WPpX0vN0dpoEfQH+sWvI8JlmnAUPznjab+0XBl5QcvmeV26vcqzVXJGhHTDGboNebop
ARC-Seal: i=1; a=rsa-sha256; t=1523386635; cv=none;
        d=google.com; s=arc-20160816;
        b=IdZlvg28Nlbzo580VIO/jjaVhqmZ57T02PNkBSEMIKOrRvyiRNS/LSiAB5m3fzq0hP
         T6g2sDPPo+YlQ6QNz/PjmQXAvOOscIjxhMvamI0qXx3Jn7WyVoI0AT4y59PZAmgJaE2r
         cC70QLDQrk/566X2Mb8jCFunOfOGE7jTiwfPap1UeR1FbeaYgVRLRy3ZVPeI3xlASlYC
         NIAYIFRBD8SGeO8uG7fePgyg34etfb9D6982ckDuFtQGiZsj5NoPjpu7/CM/5C/x9bTT
         MO5n7wBRwhGUci7HOmdtNFiEZ03GXsbCP//E8ctVpXhMZEPEZVWD25vIra47CaKTbw8G
         xbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:arc-authentication-results;
        bh=Kdd2zS09h+jYppyw8GNLR8AUKwpLhdeyjeQ6fLGV0dE=;
        b=WSyg6UKa6ve0h6AywZjCGNm5s3DAO0S6jt9m4x+WexojjwP2LkMdXY4EHye4PAfVTA
         Cjl8veVCnqdwr+7S7xMN9R2yBkYmRr80bHfLndji53Va6wtgrLglpM6EpXgeGIP0gM5I
         t+4WHX0+Lc7ZzltMFDQ/8XU4HhIwRE4zVVBq7gMvt9g/62q9gisIEdeaEa/i1K2Bprqz
         wtL69T4TzOusmZiivCWDthEfvwInqSXXRULVImkkL57ktCr6qkpR07HpGBQTt0MkpfjR
         qmSB9Tp7+X9aQ8M57dwNsWT1z0M0LU5nOD3aVPclaa+ZTEAnZrJmpCXEjpMHuZnL7L4x
         5Hyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH] selftests/filesystems: Don't run dnotify_test by default
To: Christian Brauner <christian.brauner@canonical.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>
References: <20180410062053.8816-1-mpe@ellerman.id.au>
 <20180410094553.GB3438@gmail.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Openpgp: preference=signencrypt
Autocrypt: addr=shuahkh@osg.samsung.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3fb54ca8-bd31-4937-75f9-415a72eafaf2@osg.samsung.com>
Date: Tue, 10 Apr 2018 12:57:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410094553.GB3438@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597339082431063754?=
X-GMAIL-MSGID: =?utf-8?q?1597386664293140685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10/2018 03:45 AM, Christian Brauner wrote:
> On Tue, Apr 10, 2018 at 04:20:53PM +1000, Michael Ellerman wrote:
>> In commit ce290a19609d ("selftests: add devpts selftests"), the
>> filesystems directory was added to the top-level selftests Makefile.
>>
>> That had the effect of causing the existing dnotify_test in the
>> filesystems directory to now be run as part of the default selftests
>> test-run. Unfortunately dnotify_test is actually an infinite loop.
>>
>> Fix it by moving dnotify_test to TEST_GEN_PROGS_EXTENDED, which says
>> that it's a generated file (ie. built) but should not be run as part
>> of the default test suite run (it's an "extendend" test).

Typo - I can fix it when I apply it.

>>
>> While we're here cleanup a few other things, devpts_pts should be in
>> TEST_GEN_PROGS to indicate that it's built, and with the above two
>> changes we no longer need a custom all or clean rule.
>>
>> Fixes: ce290a19609d ("selftests: add devpts selftests")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> I'm not sure if I should've made it to be built given that it wasn't
> before but it probably doesn't hurt. It's either that or remove it I
> guess.

This way the test gets built and gets included in the installed tests.
This way somebody can run it by itself.
> 
> Acked-by: Christian brauner <christian.brauner@ubuntu.com>

Thanks Michael. I will get this into 4.17-rc2 or rc3.

-- Shuah
