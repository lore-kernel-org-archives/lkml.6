Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE84C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF62064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBF62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJXW0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:26:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:53480 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeJXW0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:26:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 06:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="98174069"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2018 06:57:44 -0700
Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py: Add
 All branches report
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181023075949.18920-1-adrian.hunter@intel.com>
 <20181023181218.GB6114@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C2B8A4D@IRSMSX106.ger.corp.intel.com>
 <20181023192935.GD6114@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C2B8AA7@IRSMSX106.ger.corp.intel.com>
 <20181023200230.GE6114@kernel.org>
 <fa8d2495-0c47-c023-53dd-66718c2e1751@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <04a9bf3a-ff00-2331-d0a5-a3efcc4cdd94@intel.com>
Date:   Wed, 24 Oct 2018 16:56:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fa8d2495-0c47-c023-53dd-66718c2e1751@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/18 11:31 PM, Adrian Hunter wrote:
> On 23/10/18 11:02 PM, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Oct 23, 2018 at 07:57:17PM +0000, Hunter, Adrian escreveu:
>>>> -----Original Message-----
>>>> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>>>> Sent: Tuesday, October 23, 2018 10:30 PM
>>>> To: Hunter, Adrian <adrian.hunter@intel.com>
>>>> Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
>>>> kernel@vger.kernel.org
>>>> Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
>>>> Add All branches report
>>>>
>>>> Em Tue, Oct 23, 2018 at 06:41:17PM +0000, Hunter, Adrian escreveu:
>>>>>> -----Original Message-----
>>>>>> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>>>>>> So, I followed the instructions then ended up with:
>>>>>>
>>>>>> [acme@seventh perf]$ find /usr/local -name "*xed*" | head
>>>>>> /usr/local/lib/libxed.so /usr/local/lib/libxed.a
>>>>>> /usr/local/lib/libxed-ild.so /usr/local/lib/libxed-ild.a
>>>>>> /usr/local/include/xed /usr/local/include/xed/xed- syntax-enum.h
>>>>>> /usr/local/include/xed/xed-attributes.h
>>>>>> /usr/local/include/xed/xed-build-defines.h
>>>>>> /usr/local/include/xed/xed-cpuid-rec.h
>>>>>> /usr/local/include/xed/xed-flags.h
>>>>>> [acme@seventh perf]$
>>>>>>
>>>>>> Ran ldconfig as root, etc:
>>>>>>
>>>>>> [acme@seventh perf]$ ldconfig -v -N | grep xed
>>>
>>> What about:
>>> 	ldconfig -p | grep  xed
>>
>> $ ldconfig -p | grep xed
>> $ echo $LD_LIBRARY_PATH 
>> /usr/local/lib
>> $ ls -la /usr/local/lib/libxed*so
>> -r--r--r--. 1 root root  132840 Oct 23 14:52 /usr/local/lib/libxed-ild.so
>> -r--r--r--. 2 root root 6842688 Oct 23 14:52 /usr/local/lib/libxed.so
>> $ ldconfig -p | grep xed
>> $ 
>>
> 
> A short term solution might be to add /usr/local/lib with ldconfig i.e.
> 
> sudo ldconfig /usr/local/lib

That worked for me, but I will look at making the script work even if
/usr/local/lib is not in /etc/ld.so.conf or /etc/ld.do.conf.d/*

However I found kernel disassembly doesn't work, I think due to:

    commit edeb0c90df3581b821a764052d185df985f8b8dc
    perf tools: Stop fallbacking to kallsyms for vdso symbols lookup

As I mentioned here:


https://lore.kernel.org/lkml/4c682937-3cee-6974-0970-68610e13ad37@intel.com/T/#u

So I will look at a fix for that also.
