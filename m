Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELv+8KH5XuJPS+bHBzXsv+EtvAi38Of7XntZzrS8aVlaW2atGBUp4SEvCqIHEzKMV1UYeoq5
ARC-Seal: i=1; a=rsa-sha256; t=1521651031; cv=none;
        d=google.com; s=arc-20160816;
        b=RtS06rdXFtm13kteIUbqjV7CfAM+eyA9ZB7WS7Wh6NpvUV/Dpi75wVVokbvGmG6F6H
         xeAaoH1e1Um+ISqlFyVf9mt60Uj1O7jptQx9WOJjRpHQ6yRY5JORJluYdXsWMhez7JwJ
         92DuFcOIdplCAuBiDhB+l/haUYyNJ3K4bNzMOVio0vOc3vSAipkAG5BZXQ+33wPvU2DS
         M+6+I5RiYh8wSS/lYh8oeak8VDEUKOyO0X11+zVGlvrp9EU4NBHiRIGRKZ8dz2CpXX6c
         rjf2pHBOSxUKyMD1rDAccY/nEvBCeNDfJShCHoYiS8WzqvyhgYmmq5l52zhcZY1E4vFO
         9Kpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=hf5fBB/h8iDhe0u/KKVSA6/HlbyXOdI1ujtuWfETYno=;
        b=0GWZBPEebzuc5ddDiA1YueFZw7uwYncwUxokJdvmR/Ab6gWNxwjvyfHc6oQJQqoC1z
         KSjZ+Z/CMkMYfE0z3eA7HiKTZksUqfcPTwbVLfun8bLa2txkIDASpbnP1eWX6z1UZQKd
         o80VkbG6bzWWLWlt+mQ4FDSpW+CnpzaWKA4pHOGWLIbFpHBKd6wyHXoX3Blx6Lcp9GfI
         XgcvFDpxOZL0w7IHn/4Pw5gk8VG/o1yzuXDVBIuW4zHvzYTHsDJzzNv+KqSZW+SDaYG6
         p8tjtdlNqQl2VmsAA4f9qc4lAy/3N1HV5s8d2wyLRf88TM8PKX7jQDFblxGGpMQyOkgn
         kirw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeCUQuS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Mar 2018 12:50:18 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38859 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbeCUQuI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Mar 2018 12:50:08 -0400
Subject: Re: [PATCH] selftests/seccomp: Allow get_metadata to XFAIL
To: Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180315165916.GA31072@beast>
 <20180315171445.fv53cmgboucbf6m3@smitten>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f3877cd3-454c-46cb-60ad-5cb1251c9def@kernel.org>
Date: Wed, 21 Mar 2018 10:48:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315171445.fv53cmgboucbf6m3@smitten>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595023726325314850?=
X-GMAIL-MSGID: =?utf-8?q?1595566751537258132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/15/2018 11:14 AM, Tycho Andersen wrote:
> On Thu, Mar 15, 2018 at 09:59:16AM -0700, Kees Cook wrote:
>> Since seccomp_get_metadata() depends on CHECKPOINT_RESTORE, XFAIL the
>> test if the ptrace reports it as missing.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Tycho Andersen <tycho@tycho.ws>
> 
> Thanks, Kees.
> 

Thanks. Applied to linux-kselftest next for 4.17-rc1

thanks,
-- Shuah

