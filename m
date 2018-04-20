Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbeDTLoY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:44:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754591AbeDTLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:44:23 -0400
Subject: Re: s390 perf events JSONs query
To: John Garry <john.garry@huawei.com>, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
References: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Fri, 20 Apr 2018 13:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042011-0044-0000-0000-0000054A5DA0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042011-0045-0000-0000-0000288A7F43
Message-Id: <a3d9a3c0-8251-c922-64d4-6b91fe5df324@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200114
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 12:51 PM, John Garry wrote:
> Hi Hendrik, Thomas,
> 
> I noticed that in 4.17-rc1 support was included for s390 perf pmu-events. I also notice that the JSONs contain many common (identical actually) events between different chips for this arch.
> 
> Support was added for factoring out common arch events in https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/perf/pmu-events?h=next-20180420&id=e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
> 
> ARM64 chips use this feature. I am not familiar with the s390 arch, but do you think you could also use this feature?
> 
> Thanks,
> John
> 

Thanks John,

for bringing this to my attention. Yes I will definitely look into this feature and will try to
rework our s390 json files when this seems beneficial.

I did not notice this patch on the linux-perf-users mailing list. Was it there for review?
I do ask this because recently I have nearly no traffic on this list in my reader, so I wonder
if there is something wrong with my mailing list subscription or setup.

Thanks.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
