Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757601AbeD0Hzm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:55:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757536AbeD0Hzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:55:39 -0400
Subject: Re: [PATCH] perf test: Adapt test case record+probe_libc_inet_pton.sh
 for s390
To: Martin Vuille <jpmv27@aim.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180412081959.85193-1-tmricht@linux.ibm.com>
 <20180412131012.GC9818@kernel.org>
 <25418aa4-60bb-9f16-c880-8caaf8a20931@aim.com>
 <151b93fd-8e12-4abf-1e69-329de6eab777@linux.ibm.com>
 <57ea75b8-cebd-0ca2-0e4e-acf2beb6e981@aim.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Fri, 27 Apr 2018 09:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <57ea75b8-cebd-0ca2-0e4e-acf2beb6e981@aim.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042707-0040-0000-0000-000004339E7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042707-0041-0000-0000-00002637A93D
Message-Id: <a9448c11-2843-c82f-34d3-e9c96db346cf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 05:26 PM, Martin Vuille wrote:
> 
> 
> On 04/26/18 04:09, Thomas-Mich Richter wrote:
>> was different. With you patch it changed from /usr/lib64/libc.so (old) to
>> /usr/lib/debug/lib64/libc-2.26.so.debug (new)
>>
> Thomas,
> 
> Can you tell me what 'file' reports for the old and new files?
> 
> Regards,
> MV
> 

Martin,

not sure I understand your question:

Before your patch the file which was picked by dwarf was
/usr/lib64/libc.so

With your patch file which was picked by dwarf was 
/usr/lib/debug/lib64/libc-2.26.so.debug

Was this your question?
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
