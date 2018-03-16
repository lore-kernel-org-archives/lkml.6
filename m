Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsKEr/6aENzvYXgJZmAVRoeISH+HNGMFowJ2BXyCDA3dmEOKkQ/6wJTHmgiW6vmob//o7eo
ARC-Seal: i=1; a=rsa-sha256; t=1521237506; cv=none;
        d=google.com; s=arc-20160816;
        b=zUozFml+eybchIv1X9nstKdojq14WQqxvYIKHr7A8bXThqoGTD9mkYDgjuBAxOXccC
         nCQOf3O4mt6TFIMvuszqds2FF1dGSH88hJ0rS+EZ030BK1Wm6eHOKiifnFLDjoxa7NHn
         +In8Lpds7pp2lYnxPI8PEqpIXiSaWX0RW/ek9BfHaMHOTZGlCp8177wE1+FseCtNXmUt
         oGP7uN5eS/uXMelzVh/hCmirqMtj1r/KF8/2BUjIF8hAVp64aQph/d1ZwgcxIGYXFR4m
         8+IOZRBrA2lrWIB0voMmVolHzLQ/5h4vVYXlQypp2XkuIsOmG/bDg8QSya8uO6OFeyow
         oyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=VROUTf/ao4i45fnK7TCmaJvX0bNc50VPUfGm5vSnLPY=;
        b=HBfU8PU1Wk3RgdyGYK2NXLB29lEmLdhMzXr8w8+RvgPM7+w2v/iAbCO+Sy0/cd5uux
         DFE9NKOLcMPqwgCfL+mYJBFTFb63uiIwcC0f65qzitXvveNqn2CbJMPSq66Rom1fdE1J
         CRXkTcLU+av4h47vdR8oINmFmzF1/sUJhLa7pArOQqecO60PkCFGWU0fmZLkhnXeqkAf
         I4Qa+5fKlHqZWwPIA29Ubzzbdrh1rLhD7Z1dg/om8IfGMyqnseErD0CyFxhRVZuaZ6dZ
         HsRi9PvbbdU8hrhEC9QfidRmwu5KTzpYsyq2Z8Z25a+NHPmiPCya0irfG1qhIJuFYjbh
         RjUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeCPV60 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 17:58:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:32464 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeCPV6Z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 17:58:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25366531"
Subject: Re: [PATCH v12 04/22] selftests/vm: typecast the pkey register
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-5-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <00081300-e891-3381-3acd-e3312e54fb58@intel.com>
Date: Fri, 16 Mar 2018 14:58:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-5-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064769921910354?=
X-GMAIL-MSGID: =?utf-8?q?1595133139922938409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> -static inline unsigned int _rdpkey_reg(int line)
> +static inline pkey_reg_t _rdpkey_reg(int line)
>  {
> -	unsigned int pkey_reg = __rdpkey_reg();
> +	pkey_reg_t pkey_reg = __rdpkey_reg();
>  
> -	dprintf4("rdpkey_reg(line=%d) pkey_reg: %x shadow: %x\n",
> +	dprintf4("rdpkey_reg(line=%d) pkey_reg: %016lx shadow: %016lx\n",
>  			line, pkey_reg, shadow_pkey_reg);
>  	assert(pkey_reg == shadow_pkey_reg);

Hmm.  So we're using %lx for an int?  Doesn't the compiler complain
about this?
