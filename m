Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsZZLFNU2EdP2NJYE4JOflSAruo3b+s3C+0t27A5rWdu304nDQcnd4EgZTYGurmsmD2hYAv
ARC-Seal: i=1; a=rsa-sha256; t=1521239569; cv=none;
        d=google.com; s=arc-20160816;
        b=HL2LzqglTTABpSfDnkUlfrPNsCYctuDQuw9sugwFmdcKT2mMvlJ3YNP8d4ha+pP/db
         j2dOihSNrSOPU9VjpV2/lSMy8DWqG25ajOaWebs0JBFEgJiq4XQkDRHAbi/n962r7fTi
         q1gfClqFB4Hq0BkuEvkkJE4B7forAc6bTE/0uMzzWM4XpBtDnF8YVdkEX4PL72BGcDWt
         dMnAOHiyAiBH7qSMMILhpeAxoF6PP2GeqJUNKMNE3wV3+LtO4BecYGyL7fCEUYnrAx4p
         YqcfL047PE51GfFqyP7wCHSu3nI3W2jJ935yTMFKnE7cEr8l0tIqBawmoCw4oN65bPRI
         Mz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=/iiCrlAZahhR4JM4hdHkKzWQ81r15463YqSqeEzOxPI=;
        b=gSpPNmlql1CMCuNoAptdwPaj20jgrGa83tr6v8CoB3ha8DfvcX08w3i9GsrS8wSDOa
         hg8yNqPQ9vlzgiKz8AdUmBYTQNFsk5u6vosYcOZsxkmLphi2/eGc4JGbcd30NQ2FCYnO
         J4D096cKS7obLlMt2IlYOnKjvA/g8F+W7tq16uXLk5sfKz+SE8wfZxU8eDadY8qqsjnw
         zE1SCehohtmhA+P6Pt4Ggx31fXkpwT/aHwj5eSSpDzpGoV7GjURFMOxn/nIUvsfcwHRB
         KmCG4qpCAd2QXXGS2QJUAsZC8eVWMqbMUE8VB+1QGLKxp4PlWsMzU1PI1EXg6i3zfBos
         ZX1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeCPWcs (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:32:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:38325 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCPWcr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:32:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25373479"
Subject: Re: [PATCH v12 20/22] selftests/vm: testcases must restore
 pkey-permissions
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-21-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6f45e32f-a18c-9b33-efaa-aab3c095720f@intel.com>
Date: Fri, 16 Mar 2018 15:32:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-21-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064510961959598?=
X-GMAIL-MSGID: =?utf-8?q?1595135302542981294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> Generally the signal handler restores the state of the pkey register
> before returning. However there are times when the read/write operation
> can legitamely fail without invoking the signal handler.  Eg: A
> sys_read() operaton to a write-protected page should be disallowed.  In
> such a case the state of the pkey register is not restored to its
> original state.  The test case is responsible for restoring the key
> register state to its original value.

Oh, that's a good point.

Could we just do this in a common place, though?  Like reset the
register after each test?  Seems more foolproof.
