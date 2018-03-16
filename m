Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvSIc/o5QTn8aVWlhSFz4n6M6XLOdnMqNSBdzU0ymkjGCRsk/B2LIECaYNc9lK2S6iryofi
ARC-Seal: i=1; a=rsa-sha256; t=1521239662; cv=none;
        d=google.com; s=arc-20160816;
        b=lQkrO83hdcZi2C9FbpfbYY7vTSRVGT2IKriotFnqEfC9ZT50blo5+AenlEAi9MgfgL
         rpWSbID3C+rgpJQomRs6C4/AvzZ+Buaj5dwHZlOP6Yfx8i9fGAfLV4I2jjvrFUbPqpjF
         MtKSWl8T1YyTgPkBqypLB1UMdMpaEB+Fr13/0oEgAHdLq1bplnYt0zFzMFe0NhwQpd7g
         M8WnNbZxvtLdZ2+J/EXutfGZr1hvKqnrVHJjmnP2ie+cMbUJ7bBE4WB3lHeonAZT3e7T
         G1HMD1FUyFagxKy/+1wpQIx58BVZV74ejb5G2XmxRa+CgYFypxuuZXo0PGYlZ4IKa3bX
         2VKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=UFEyHjU6Cjd3F5x6R6oLItpgzxKp1ncjjt7W0Q089EM=;
        b=w01r7fJGzfHHdNSOfjmbwFy6o/fVGuGScDI9oB9UZF1pSmYWKBi5E/NghWIWJMjg+i
         zLW3VG9pPhvZika3lL6W0njkPz9vB5iaPbTW+tMuX29NW8FGflcHQ3NyeFgH5BAFLIWB
         kn+WOm+QmTofoF3VQbtz1/ePEGQc6eK+ueSbvH3RLMfY8XY6niIqxGx/yKVVGx9MF4/J
         l8Mr9kk25v0Cg2Lh4Iok53VNg8vy9QTP6OnzPFCVLX+FWwqTXkJ734DcOghkN3TyBdFO
         vXGhmASYOs2jARnMvpLEOeQhvddt0/6vUrvYdH32VuqR0lyv+rYjWsfdv7hW16NGH575
         Qbbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeCPWeG (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:34:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:27546 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbeCPWeE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:34:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25373621"
Subject: Re: [PATCH v12 21/22] selftests/vm: sub-page allocator
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-22-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f2c8f721-b107-3bdc-3c09-01b9849c4ce2@intel.com>
Date: Fri, 16 Mar 2018 15:33:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-22-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064477181029892?=
X-GMAIL-MSGID: =?utf-8?q?1595135400032068544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
...
> @@ -888,6 +917,7 @@ void setup_hugetlbfs(void)
>  void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
>  
>  	malloc_pkey_with_mprotect,
> +	malloc_pkey_with_mprotect_subpage,
>  	malloc_pkey_anon_huge,
>  	malloc_pkey_hugetlb
>  /* can not do direct with the pkey_mprotect() API:


I think I'd rather have an #ifdef on the array entries than have the
malloc entry do nothing on x86.  Maybe have a ppc-specific section at
the end?
