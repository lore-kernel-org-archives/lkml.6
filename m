Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D51C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBDA2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfAQJs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:48:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbfAQJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:48:27 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0H9jFt5185667
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:48:26 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2mt2pbd9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:48:26 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Thu, 17 Jan 2019 09:48:25 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 09:48:22 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0H9mLD520643954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 09:48:21 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1A5C124052;
        Thu, 17 Jan 2019 09:48:20 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7459512405C;
        Thu, 17 Jan 2019 09:48:18 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.124.35.202])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 09:48:18 +0000 (GMT)
Subject: Re: [PATCH] perf scripts python: Add Python 3 support to
 mem-phys-addr.py
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <1547655825-28754-8-git-send-email-s1seetee@linux.vnet.ibm.com>
 <20190116093233.4873b784@lwn.net>
From:   seeteena <s1seetee@linux.vnet.ibm.com>
Date:   Thu, 17 Jan 2019 15:18:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190116093233.4873b784@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19011709-0052-0000-0000-00000379D808
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010423; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01147708; UDB=6.00597870; IPR=6.00928006;
 MB=3.00025170; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-17 09:48:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011709-0053-0000-0000-00005F7FB170
Message-Id: <89d6529f-1849-ce36-bd33-b65f2252214c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have added


On 01/16/2019 10:02 PM, Jonathan Corbet wrote:
> On Wed, 16 Jan 2019 21:53:36 +0530
> Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com> wrote:
>
>> Support both Python 2 and Python 3 in mem-phys-addr.py. ``print`` is now a
>> function rather than a statement. This should have no functional change.
>>
>> Fix lambda syntax error.
> So, I just picked one of these at random....
>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   tools/perf/scripts/python/mem-phys-addr.py | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
>> index ebee2c5..52fe9bd 100644
>> --- a/tools/perf/scripts/python/mem-phys-addr.py
>> +++ b/tools/perf/scripts/python/mem-phys-addr.py
>> @@ -38,14 +38,14 @@ def parse_iomem():
>>   			pmem.append(long(m[1], 16))
>>   
>>   def print_memory_type():
>> -	print "Event: %s" % (event_name)
>> -	print "%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"),
>> -	print "%-40s  %10s  %10s\n" % ("----------------------------------------", \
>> -					"-----------", "-----------"),
>> +	print("Event: %s" % (event_name))
>> +	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage")),
>> +	print("%-40s  %10s  %10s\n" % ("----------------------------------------", \
>> +					"-----------", "-----------")),
> You have not added "from __future__ import print_function", so you're
> relying on a Python 2 parsing oddity to make this work.  If anybody ever
> adds a second parameter, things will break.  I think that if you really
> want to support both versions (which seems like the right goal) you should
> add the import and do it properly.
>
> Thanks,
>
> jon
>

Thanks Jonathan. I have added "from __future__ import print_function" 
for all the scripts.

