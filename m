Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756740AbeDZPcU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:32:20 -0400
Received: from omr-m001e.mx.aol.com ([204.29.186.1]:34286 "EHLO
        omr-m001e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755172AbeDZPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:32:16 -0400
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
To: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
 <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
 <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <57ea75b8-cebd-0ca2-0e4e-acf2beb6e981@aim.com>
Date: Thu, 26 Apr 2018 11:26:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1afe6e5ae1ef986f8b
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/26/18 04:09, Thomas-Mich Richter wrote:
> was different. With you patch it changed from /usr/lib64/libc.so (old) to
> /usr/lib/debug/lib64/libc-2.26.so.debug (new)
>
Thomas,

Can you tell me what 'file' reports for the old and new files?

Regards,
MV
